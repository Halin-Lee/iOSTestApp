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
    RequestMethodGet = 0,                                      /* Cancel the load, this is the same as -[task cancel] */
    RequestMethodPost = 1,                                       /* Allow the load to continue */
};

@interface VolleyRequest : NSObject

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
/**成功回调*/
@property (nonatomic,nullable,copy) void (^success)(NSURLSessionDataTask * _Nonnull, id _Nullable);
/**失败回调*/
@property (nonatomic,nullable,copy) void (^failure)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);
/**请求任务,可能为空*/
@property (nonatomic,nullable,strong) NSURLSessionDataTask* task;
/**测试用变量*/
@property (nonatomic,assign) BOOL hasHadTaskWhenCancel;

+ (instancetype)requestWithMehtod:(RequestMethod)method url:(NSString *)url param:(id)param success: (void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable)) success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

+ (instancetype)requestWithMehtod:(RequestMethod)method url:(NSString *)url param:(id)param requestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *) requestSerializer responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer success: (void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable)) success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure ;

/**取消*/
- (void)cancel;
/**请求是否取消*/
- (BOOL)isCanceled;

/**结束*/
- (void)finish;
/**请求是否结束*/
- (BOOL)isFinished;

@end
