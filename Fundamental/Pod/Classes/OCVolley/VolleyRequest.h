//
//  VolleyRequest.h
//  TestApp
//
//  Created by 17track on 6/1/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**请求类型*/
typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethodGet = 0,
    RequestMethodPost = 1,
};

/**请求状态*/
typedef NS_ENUM(NSInteger, RequestState) {
    RequestStateInitiation = 1 << 0,
    RequestStateAdded =  1 << 1,
    RequestStateRunning =  1 << 2,
    RequestStateFinished =  1 << 3,
    RequestStateCanceled =  1 << 4
};

@interface VolleyRequest : NSObject<AFURLResponseSerialization>

/**请求方式,分为Get和Post*/
@property (nonatomic,assign) RequestMethod method;
/**请求URL*/
@property (nonatomic,nonnull,strong) NSString *url;
/**请求参数,代入AFHTTPSessionManager的param*/
@property (nonatomic,nullable,strong) id param;
/**request解析*/
@property (nonatomic,nonnull,strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * requestSerializer;
/**response解析*/
@property (nonatomic,nonnull,strong) AFHTTPResponseSerializer <AFURLResponseSerialization> * responseSerializer;
/**成功回调,取消后回调不会被调用*/
@property (nonatomic,nullable,copy) void (^success)(NSURLSessionDataTask * _Nonnull, id _Nullable);
/**失败回调,取消后回调不会被调用*/
@property (nonatomic,nullable,copy) void (^failure)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);
/**请求任务,可能为空*/
@property (nonatomic,nullable,strong) NSURLSessionDataTask* task;
/**服务器返回内容*/
@property (nonatomic,nullable, copy, readonly) NSData *data;
/**异常*/
@property (nonatomic,nullable,strong) NSError *error;
/**请求状态*/
@property (nonatomic, assign) RequestState state;
/**测试用变量*/
@property (nonatomic,assign) BOOL hasHadTaskWhenCancel;
/**网络耗时*/
@property (nonatomic,assign) NSTimeInterval networkTime;
/**tag*/
@property (nonatomic,strong) id tag;


+ (instancetype)requestWithMehtod:(RequestMethod)method url:(NSString *)url param:(id)param success: (void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable)) success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

+ (instancetype)requestWithMehtod:(RequestMethod)method url:(NSString *)url param:(id)param responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer  success: (void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable)) success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

+ (instancetype)requestWithMehtod:(RequestMethod)method url:(NSString *)url param:(id)param requestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *) requestSerializer responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer success: (void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable)) success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure ;

/**取消*/
- (void)cancel;
/**请求是否取消*/
- (BOOL)isCanceled;
/**请求是否结束*/
- (BOOL)isFinished;



@end
