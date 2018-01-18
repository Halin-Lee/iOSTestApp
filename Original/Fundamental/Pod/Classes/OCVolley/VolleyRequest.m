//
//  VolleyRequest.m
//  TestApp
//
//  Created by 17track on 6/1/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "VolleyRequest.h"

@interface VolleyRequest ()

/**服务器返回的data*/
@property (nonatomic, copy, readwrite) NSData *data;

/**启动时间*/
@property (nonatomic,assign) NSTimeInterval startTime;

@end

@implementation VolleyRequest




+ (instancetype)requestWithMehtod:(RequestMethod)method url:(NSString *)url param:(id)param success: (void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable)) success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
   return [self requestWithMehtod:method url:url param:param responseSerializer:nil success:success failure:failure];
}

+ (instancetype)requestWithMehtod:(RequestMethod)method url:(NSString *)url param:(id)param responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer  success: (void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable)) success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    return [self requestWithMehtod:method url:url param:param requestSerializer:nil responseSerializer:responseSerializer success:success failure:failure];
}

+ (instancetype)requestWithMehtod:(RequestMethod)method url:(NSString *)url param:(id)param requestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *) requestSerializer responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer success: (void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable)) success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    VolleyRequest *request = [[self alloc] init];
    request.method = method;
    request.url = url;
    request.param = param;
    request.requestSerializer = requestSerializer?:[AFHTTPRequestSerializer serializer];
    request.responseSerializer = responseSerializer?:[AFHTTPResponseSerializer serializer];
    request.success = success;
    request.failure = failure;
    return request;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _state = RequestStateInitiation;
        _startTime = -1;
        _networkTime = -1;
    }
    return self;
}


- (void)cancel{
    _state = RequestStateCanceled;
    _hasHadTaskWhenCancel = _task?YES:NO;
    if (_task) {
        [_task cancel];
    }
}

- (void)setState:(RequestState)state{
    _state = state;
    if (_state == RequestStateRunning) {
        _startTime = [NSDate date].timeIntervalSince1970;
    }else if(_state == RequestStateFinished){
        if (_startTime > 0) {
            _networkTime = [NSDate date].timeIntervalSince1970 - _startTime;
        }
    }
}

- (BOOL)isCanceled{
    return _state == RequestStateCanceled;
}

- (BOOL)isFinished{
    return _state == RequestStateFinished;
}


- (nullable id)responseObjectForResponse:(nullable NSURLResponse *)response
                                    data:(nullable NSData *)data
                                   error:(NSError * _Nullable __autoreleasing *)error{
    _data = data;
    return [self.responseSerializer responseObjectForResponse:response data:data error:error];
}


@end
