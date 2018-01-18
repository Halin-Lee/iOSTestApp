//
//  TestModel.m
//  TestApp
//
//  Created by Halin on 11/10/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "DataBindingPlaceHolderbTestModel.h"
#import "DataBindingUtil.h"

@implementation DataBindingPlaceHolderbTestModel


- (void)dealloc{
    [[DataBindingUtil dataBindingUtil] unbindModel:self];
}

@end
