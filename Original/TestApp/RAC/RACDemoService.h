//
//  RACDemoService.h
//  TestApp
//
//  Created by Halin Lee on 6/3/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface RACDemoService : NSObject

+ (instancetype)sharedSingleton;


/**
 执行上传任务，参数为RACTuple，其中，第一个参数为 BOOL 是是否成功，第二个参数为 NSTimeInterval 表示执行时间
 */
@property (nonatomic,strong) RACCommand *uploadCommand;

@end


@interface RACDemoServiceTestCase : NSObject;

+ (void)test;

@end
