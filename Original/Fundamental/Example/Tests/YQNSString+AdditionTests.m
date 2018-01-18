//
//  YQNSString+AdditionTests.m
//  Fundamental
//
//  Created by 17track on 3/5/16.
//  Copyright © 2016 17track. All rights reserved.
//
#import <Kiwi/Kiwi.h>
#import "NSString+Addition.h"

SPEC_BEGIN(NSStringAdditionTests)

describe(@"NSString+Addition", ^{
    

    
    context(@"isEmpty", ^{
        
        it(@"empty", ^{
            [[theValue([NSString isEmpty:@""]) should] equal:theValue(YES)];
            [[theValue([NSString isEmpty:nil]) should] equal:theValue(YES)];
        });
        
        it(@"non empty", ^{
            [[theValue([NSString isEmpty:@"ABC"]) should] equal:theValue(NO)];
            [[theValue([NSString isEmpty:@"%@"]) should] equal:theValue(NO)];
        });  
    });
    
});

SPEC_END


