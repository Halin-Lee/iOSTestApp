//
//  JSPatchDemo.m
//  TestApp
//
//  Created by 17track on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "JSPatchDemo.h"

#import "JPEngine.h"
#import "JPLoader.h"

@implementation JSPatchDemo

+ (void)test{
    //JSPatch测试,从本地文件加载JS
    //    [JPEngine startEngine];
    //    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"JSPatchDemo" ofType:@"js"];
    //    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    //    [JPEngine evaluateScript:script];
    //
    //    //重复调用,只有最后一次起作用
    //    sourcePath = [[NSBundle mainBundle] pathForResource:@"JSPatchDemo_Second" ofType:@"js"];
    //    script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    //    [JPEngine evaluateScript:script];
    
    //使用JPLoader完成初始化
    [JPLoader run];
    //为Loader设置Logger
    [JPLoader  setLogger:^(NSString *log) {
        //        NSLog(@"%@",log);
    }];
    
    //设置JPLoader的版本
    [JPLoader updateToVersion:1 callback:^(NSError *error) {
        if (error) {
            NSLog(@"更新失败 %@",error);
        }
    }];

}

@end
