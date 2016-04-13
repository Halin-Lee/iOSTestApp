//
//  TrackEventItem.h
//  TestApp
//
//  Created by 17track on 4/12/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, EventType){
    EventTypeSwipe = 0x02,
    EventTypeTap = 0x04,
    EventTypeLongPress = 0x08,
};

@interface TrackEventItem : NSObject

/**
 * 事件名称
 */
@property (nonatomic,copy) NSString *name;

/**
 * 跟踪类型(点击,滑动,长按之类的)
 */
@property (nonatomic,assign) EventType type;

/**
 * 跟踪的view id
 */
@property (nonatomic,copy) NSString *trackingID;

/**
 * 父view id
 */
@property (nonatomic,copy) NSString *parent;

/**
 * 是否忽略
 */
@property (nonatomic,assign) BOOL ignored;


/**
 * 标签
 */
@property (nonatomic,copy) NSString *tag;

@end
