//
//  AutoEventTrackingXMLLoader.m
//  TestApp
//
//  Created by 17track on 4/12/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "AutoEventTrackingXMLLoader.h"
#import "DDXML.h"
#import "Logger.h"
#import "TrackEventItem.h"
#import "NSString+Addition.h"


static NSString *const TAG = @"AutoEventTrackingXMLLoader";


@interface AutoEventTrackingXMLLoader ()

@property (nonatomic,strong) NSMutableDictionary *itemDictionary;
@property (nonatomic,strong) NSMutableDictionary *screenDictionary;

@end

@implementation AutoEventTrackingXMLLoader

SINGLETON_FOR_CLASS(AutoEventTrackingXMLLoader)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemDictionary = [NSMutableDictionary dictionary];
        _screenDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)loadFromPath:(NSString *)path{
    //加载默认配置
    NSData *configData = [NSData dataWithContentsOfFile:path];
    NSError *error;
   
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:configData options:0 error:&error];
    if (error) {
        [Logger logEWithTag:TAG format:@"事件跟踪列表 Error:%@",error];
    }
    DDXMLElement *rootElement = [doc rootElement];
    
    
    
    
    //解析Golbal配置
    NSArray *screens = [rootElement elementsForName:@"Screen"];
   
    for (DDXMLElement *screen in screens) {
        NSString *screenName = [screen attributeForName:@"name"].stringValue;
        NSString *className = [screen attributeForName:@"class"].stringValue;
        
        NSMutableArray *itemList = [NSMutableArray array];
        _itemDictionary[className] = itemList;
        _screenDictionary[className] = screenName;
        
        for (DDXMLElement *itemElement in [screen children]) {
            NSString *type = itemElement.name ;
            //注释会被包含进来
            if ([type isEqualToString:@"comment"]) {
                continue;
            }

            TrackEventItem *eventItem = [[TrackEventItem alloc] init];
            eventItem.name = [itemElement attributeForName:@"name"].stringValue;
            eventItem.trackingID = [itemElement attributeForName:@"trackingID"].stringValue;
            eventItem.parent = [itemElement attributeForName:@"parent"].stringValue;
            eventItem.tag = [itemElement attributeForName:@"tag"].stringValue;
            eventItem.ignored = [itemElement attributeForName:@"ignored"].stringValue.boolValue;
            NSString *eventTypeStr = [itemElement attributeForName:@"type"].stringValue;
            eventItem.type = [self typeFromString:eventTypeStr];
            
            
            if ([NSString isEmpty:eventItem.trackingID]) {
                [Logger logEWithTag:TAG format:@"获得无效id id:%@ name:%@",eventItem.trackingID,eventItem.name];
            }else{
                [itemList addObject:eventItem];
            }
            
        }
   
    }
}

- (EventType)typeFromString:(NSString *)type{
    if ([type isEqualToString:@"tap"]) {
        return EventTypeTap;
    }else if([type isEqualToString:@"swipe"]){
        return EventTypeSwipe;
    }else if([type isEqualToString:@"long press"]){
        return EventTypeLongPress;
    }else{
        return -1;
    }
}

- (NSArray *)itemsForViewController:(NSString *)viewControllerClass{
    NSArray *items = _itemDictionary[viewControllerClass];
    return items?[items copy]:[NSArray array];
}

- (NSString *)screenNameForViewController:(NSString *)viewControllerClass{
    NSString *screenName = _screenDictionary[viewControllerClass];
    return screenName?screenName:viewControllerClass;
}

@end
