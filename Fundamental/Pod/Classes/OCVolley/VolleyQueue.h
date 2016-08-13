//
//  VolleyQueue.h
//  TestApp
//
//  Created by 17track on 6/1/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VolleyRequest.h"
#import "RequestFinishedDelegate.h"


/**一个模仿Android Volley的请求队列,Session不方便请求的统一管理,使用请求队列将所有请求统一集合*/
@interface VolleyQueue : NSObject

/**当前所有请求*/
- (NSArray<VolleyRequest *> *)currentRequests;

/**插入一个请求*/
- (void)add:(VolleyRequest *)request;

/**获得请求数量*/
- (NSInteger)requestCount;

/**取消全部请求*/
- (void)cancelAll;

- (void)addRequestFinishedDelegate:(id<RequestFinishedDelegate>)delegate;

- (void)removeRequestFinishedDelegate:(id<RequestFinishedDelegate>)delegate;

@end
