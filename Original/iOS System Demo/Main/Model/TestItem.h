//
//  TestItem.h
//  TestApp
//
//  Created by Halin on 11/10/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestItem : UIViewController

@property (nonatomic,copy,readonly) NSString *testName;
@property (nonatomic,copy,readonly) NSString *testGroup;
@property (nonatomic,assign,readonly) Class clazz;


+ (instancetype)testItemWithTestGroup:(NSString *)group name:(NSString *)name clazz:(Class)clazz;

@end
