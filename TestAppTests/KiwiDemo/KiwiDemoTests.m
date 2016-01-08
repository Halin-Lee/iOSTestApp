//
//  KiwiDemoTests.m
//  TestApp
//
//  Created by 17track on 1/7/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(KiwiDemo)


describe(@"Kiwi Demo", ^{
    context(@"Kiwi 简单使用例子", ^{
        
        NSMutableArray *testArray = [NSMutableArray array];
        
        
        beforeAll(^{
            [testArray addObject:@"Before All Call"];
        });
        
        beforeEach(^{
              [testArray addObject:@"Before Each Call"];
        });
        
        
        it(@"模拟成功测试", ^{
            [[testArray shouldNot] beNil];
        });
        
        it(@"模拟失败测试", ^{
//            [[arrayInitInBeforeAll should] beNil];
        });
        
        afterAll(^{
            NSLog(@"after all %@",testArray);
        });
        
    });
    
    
    context(@"Kiwi mock 测试例子", ^{
       
        NSArray *testArray = @[@"a",@"b",@"c"];
        
        //注1.使用mock stub将对每个用例有效,否则,stub只对一个用例有效,具体效果可注释此代码
        testArray = [NSArray mock];
        
        beforeAll(^{
            [testArray stub:@selector(description) andReturn:@"Foo"];
            [testArray stub:@selector(objectAtIndex:) andReturn:@"objectAtIndex:1 调用" withArguments:theValue(1)];
        });
        
        
        it(@"测试stub是否成功", ^{
            [[testArray.description should] equal:@"Foo"];
            [[[testArray objectAtIndex:1] should] equal:@"objectAtIndex:1 调用"];
            //注2.当使用mock的时候.调用未stub的方法将导致测试出错,如当开启注1的时候,下面方法将报错
//            [[[testArray objectAtIndex:0] should] equal:@"a"];
            
        });
        
        xit(@"测试stub是否针对每个it都有效", ^{
            [[testArray.description should] equal:@"Foo"];
            [[[testArray objectAtIndex:1] should] equal:@"objectAtIndex:1 调用"];
            [[[testArray objectAtIndex:0] should] beNil];
        });
        
    });
    
    
    context(@"Kiwi 参数捕获", ^{
        it(@"测试参数捕获", ^{
            NSArray *testArray = @[@"a",@"b",@"c"];
            testArray = [NSArray mock];
            KWCaptureSpy *spy = [testArray captureArgument:@selector(objectAtIndex:) atIndex:0];

            //调用次数在方法调用之前统计
            [[testArray should] receive:@selector(description) withCount:1];
            [testArray description];
            
            [[testArray should] receive:@selector(objectAtIndex:) withCount:1];
            [testArray objectAtIndex:1];
            
            //参数捕获在方法之后(那不是废话么)
            [[spy.argument should] equal:theValue(1)];
            
        });
    });
    
});

SPEC_END
