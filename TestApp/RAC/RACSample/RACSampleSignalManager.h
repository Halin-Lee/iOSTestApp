//
//  RACSampleSignalManager.h
//  TestApp
//
//  Created by Halin Lee on 3/5/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RACSampleViewController.h"

/**
 负责管理页面的所有信号
 */
@interface RACSampleSignalManager : NSObject


- (instancetype)initWithViewController:(RACSampleViewController *)viewController;

/**
 查询入口
 */
@property (nonatomic,strong) RACCommand *trackCommand;


/**
 翻译入口
 */
@property (nonatomic,strong) RACCommand *translateCommand;

@end
