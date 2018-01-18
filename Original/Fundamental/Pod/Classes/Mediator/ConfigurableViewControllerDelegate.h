//
//  ConfigurableViewControllerDelegate.h
//  TestApp
//
//  Created by Halin on 3/22/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ViewControllerPresentType){
    ViewControllerPresentTypePresent,
    ViewControllerPresentTypePush,
};

@protocol ConfigurableViewControllerDelegate <NSObject>


@optional
//指明ViewController展现方式
- (ViewControllerPresentType)viewControllerPresentType;

//启动时带进来的参数
- (void)receiveStartParam:(NSDictionary *)dictionary;

//返回时调用的回调
- (void)popWithParam:(NSDictionary *)dictionary;



@end
