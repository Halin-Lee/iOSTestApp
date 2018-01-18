//
//  RACSignalDemo.h
//  TestApp
//
//  Created by Halin on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RACSignalDemo : NSObject


+ (void)test;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,assign) BOOL isRight;

@property (nonatomic,strong) id releaseTest;


@end
