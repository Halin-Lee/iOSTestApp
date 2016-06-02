//
//  VolleyQueue.h
//  TestApp
//
//  Created by 17track on 6/1/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VolleyRequest.h"

/**一个模仿Android Volley的请求队列,Session不方便请求的统一管理,使用请求队列将所有请求统一集合*/
@interface VolleyQueue : NSObject

/**插入一个请求*/
- (void)add:(VolleyRequest *)request;

/**获得请求数量*/
- (NSInteger)requestCount;
@end
