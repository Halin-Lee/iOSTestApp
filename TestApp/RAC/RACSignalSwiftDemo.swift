//
//  RACSingalDemo.swift
//  TestApp
//
//  Created by 17track on 8/12/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

import Foundation
import ReactiveCocoa

@objc class RACSignalSwiftDemo : NSObject{
    static func test() {
        
        
        print("/*--------------测试1 RACSignal基本使用-------------------*/")
        
        let ocSignal = RACSignal.createSignal { (subscribe) -> RACDisposable! in
            print("RACSignal 被订阅")
            subscribe.sendNext(1)
            subscribe.sendNext(2)
            subscribe.sendCompleted()
            return RACDisposable.init(block: {
                print("信号销毁");
            });
        };
        ocSignal.subscribeNext { (number) in
            print("第一个订阅接受到信号 \(number)");
        };
        
        ocSignal.subscribeNext { (number) in
            print("第二个订阅接受到信号 \(number)");
        };
        
 
    }
}