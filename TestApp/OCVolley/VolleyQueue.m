//
//  VolleyQueue.m
//  TestApp
//
//  Created by 17track on 6/1/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "VolleyQueue.h"
#import "AFNetworking.h"
#import "FIFOQueue.h"


@interface VolleyQueue ()
/**保存所有session的manager,这部分把SessionManager当做Volley的NetworkDispatch来用,一个SessionManager同时只处理一个请求*/
@property (nonatomic,strong) NSArray<AFHTTPSessionManager *> *sessionManagerArray;
/**正在等待的队列,一个SessionManager同时只处理一个请求,未能插入的保存在这里*/
@property (nonatomic,strong) FIFOQueue *pendingQueue;
/**当前所有请求*/
@property (nonatomic,strong) NSMutableArray<VolleyRequest *> *currentRequests;

@end

@implementation VolleyQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sessionManagerArray = [NSArray arrayWithObjects:[AFHTTPSessionManager manager],[AFHTTPSessionManager manager],[AFHTTPSessionManager manager],[AFHTTPSessionManager manager], nil];
        _pendingQueue = [[FIFOQueue alloc] init];
        _currentRequests = [NSMutableArray array];
    }
    return self;
}

- (void)add:(VolleyRequest *)request{
    
    if(!request || request.isCanceled || request.isFinished){
        NSAssert(NO,@"Request为空,或已取消 或已完成");
        return;
    }

    [_currentRequests addObject:request];
    for(AFHTTPSessionManager *manager in _sessionManagerArray){
        //遍历所有manager,找出空闲的插入请求
        if (manager.tasks.count == 0) {
            [self doRequest:request withSessionManage:manager];
            return;
        }
    }
    //未找到空闲的manager,排队等候
    [_pendingQueue enqueue:request];
    
    
}

/**将request交给manager执行*/
- (void)doRequest:(VolleyRequest *)request withSessionManage:(AFHTTPSessionManager *)manager{
    
    manager.requestSerializer = request.requestSerializer;
    manager.responseSerializer = request.responseSerializer;
    
    void (^success)(NSURLSessionDataTask * _Nonnull, id _Nullable) =^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_currentRequests removeObject:request];
        if(!request || request.isFinished){
            NSAssert(NO,@"Request为空,或已取消 或已完成 %d",request.hasHadTaskWhenCancel);
        }
        
        if (!request.isCanceled ) {
            //未被取消,调用回调  AFNetworking(也可能是NSURLSession)有个Bug,在task被取消后,仍然可能调用成功回调
            [request finish];
            request.success(task,responseObject);
            [self takeNext:manager];
        }
    };
    
    void (^failure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)= ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_currentRequests removeObject:request];
        if (!request.isCanceled ) {
            //未被取消,调用回调
            [request finish];
            request.failure(task,error);
            [self takeNext:manager];
        }
    };
    
   switch (request.method) {
       case RequestMethodGet:
            request.task = [manager GET:request.url parameters:request.param progress:nil success:success failure:failure];
            break;
       case RequestMethodPost:
           request.task =[manager POST:request.url parameters:request.param progress:nil success:success failure:failure];
           break;
    }
}

/**manager执行下一个请求*/
- (void)takeNext:(AFHTTPSessionManager *)manager{
    
    while (true) {
        VolleyRequest *request = _pendingQueue.dequeue;
        if (!request) {
            //没有请求了,跳过
            return;
        }
    
        if (!request.isCanceled) {
            //从队列中获得下一个,执行
            [self doRequest:request withSessionManage:manager];
            return;
        }else{
            //已取消的请求忽略
            [_currentRequests removeObject:request];
        }
    }
   
}

- (NSInteger)requestCount{
    return _currentRequests.count;
}

@end



