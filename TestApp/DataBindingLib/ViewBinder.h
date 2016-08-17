//
//  ViewBinder.h
//  TestApp
//
//  Created by Halin on 11/11/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**与view一一对应的binding,保存所有绑定信息,实现绑定*/
@interface ViewBinder : NSObject

/**要set的view*/
@property (nonatomic,weak) UIView *view;

/**用于判断model是否被回收*/
@property (nonatomic,assign,readonly) id model;

/**要监听的类型*/
@property (nonatomic,copy) NSString *modelType;

/**识别id*/
@property (nonatomic,copy) NSString *identifier;

/**正向field绑定 key:field,监听哪个属性 value:method,属性变化时执行的方法 保存监听的field和method的字典*/
@property (nonatomic,strong) NSMutableDictionary *fieldMethodDictionary;

/**反向field绑定 key:field,监听哪个属性 value:method,属性变化时执行的方法 保存监听的field和method的字典*/
@property (nonatomic,strong) NSMutableDictionary *reverseFieldMethodDictionary;

/**正向signal绑定 key:field,监听哪个属性 value:signal,监听哪个signal 保存监听的field和method的字典*/
@property (nonatomic,strong) NSMutableDictionary *signalMethodDictionary;

/**反向signal绑定 key:field,监听哪个属性 value:signal,监听哪个signal 保存监听的field和method的字典*/
@property (nonatomic,strong) NSMutableDictionary *reverseSignalMethodDictionary;

/**所有绑定上的对象*/
@property (nonatomic,strong) NSMutableArray *observers;



/**绑定*/
- (void)bind:(id)model;

/**解绑*/
- (void)unbind;

@end

