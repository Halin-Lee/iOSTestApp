//
//  SwiftToObjectiveC.h
//  TestApp
//
//  Created by 17track on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwiftToObjectiveC : NSObject

@property (nonatomic,strong) SwiftToObjectiveC *objectiveCObj;
@property (nonatomic,copy) NSString *objectiveCString;

- (SwiftToObjectiveC *)objectiveCMethod;

+ (void)test;

@end
