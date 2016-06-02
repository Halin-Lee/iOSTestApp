//
//  VolleyRequest.m
//  TestApp
//
//  Created by 17track on 6/1/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "VolleyRequest.h"

@interface VolleyRequest ()
@property (nonatomic,assign) BOOL isCanceled;
@property (nonatomic,assign) BOOL isFinished;

@end

@implementation VolleyRequest




+ (instancetype)requestWithMehtod:(RequestMethod)method url:(NSString *)url param:(id)param success: (void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable)) success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
   return [self requestWithMehtod:method url:url param:param requestSerializer:nil responseSerializer:nil success:success failure:failure];
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


- (void)cancel{
    _isCanceled = YES;
    _hasHadTaskWhenCancel = _task?YES:NO;
    if (_task) {
        [_task cancel];
    }
}

- (void)finish{
    _isFinished = YES;
}



@end
