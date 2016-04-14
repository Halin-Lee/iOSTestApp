//
//  AutoEventTracking.m
//  TestApp
//
//  Created by 17track on 4/11/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "AutoEventTracking.h"
#import "AutoEventTrackingXMLLoader.h"
#import "UIView+AutoEventTracking.h"
#import "NSString+Addition.h"
#import "DefaultAutoEventTrackingDelegate.h"
#import "Logger.h"

static NSString *const TAG = @"AutoEventTracking";
@interface AutoEventTracking ()

/**
 * ViewController的view
 */
@property (nonatomic,weak) UIView *rootView;

/*
 * 被点中的view
 */
@property (nonatomic,weak) UIView *viewOnTouch;

/**
 * 事件解析表,<对应的view ID,NSArray<事件>>
 */
@property (nonatomic,strong) NSMutableDictionary<NSString *,NSMutableArray<TrackEventItem *>*> *itemDictionary;

@property (nonatomic,strong) NSArray<TrackEventItem *> *itemList;

/**
 * 长按触发表示位,长按事件会多次触发,为避免一次滚动多次触发,增加这个标志位
 */
@property (nonatomic,assign) BOOL isLongPressHappen;


@end

@implementation AutoEventTracking

#pragma mark - 初始化

- (instancetype)initWithController:(UIViewController *)viewController delegate:(id<AutoEventTrackingDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        _prefixString = @"";
        
        //增加View监听
        _rootView = viewController.view;
        _rootView.userInteractionEnabled = YES;
        
        //点击事件添加
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapGestureRecognizer.delegate = self;
        tapGestureRecognizer.cancelsTouchesInView = NO;             //一个事件不止由一个GestureRecognizer接收
        [_rootView addGestureRecognizer:tapGestureRecognizer];
        
        //水平滑动事件添加
        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        swipeGestureRecognizer.delegate = self;
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
        swipeGestureRecognizer.cancelsTouchesInView = NO;
        [_rootView addGestureRecognizer:swipeGestureRecognizer];
        
        
        //垂直滑动事件添加
        swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        swipeGestureRecognizer.delegate = self;
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown;
        swipeGestureRecognizer.cancelsTouchesInView = NO;
        [_rootView addGestureRecognizer:swipeGestureRecognizer];
        
        //长按事件添加
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPressGestureRecognizer.delegate = self;
        longPressGestureRecognizer.cancelsTouchesInView = NO;
        [_rootView addGestureRecognizer:longPressGestureRecognizer];
        
        //保存delegate
        self.delegate = delegate?delegate:[[DefaultAutoEventTrackingDelegate alloc] init];
        
        //获得监听事件,保存
        _itemDictionary = [NSMutableDictionary dictionary];
        NSString *viewControllerName = NSStringFromClass([viewController class]);
        AutoEventTrackingXMLLoader *loader = [AutoEventTrackingXMLLoader sharedSingleton];
        _screenName = [loader screenNameForViewController:viewControllerName];
        _itemList = [loader itemsForViewController:viewControllerName];
        
        for (TrackEventItem *item in _itemList) {
            NSMutableArray<TrackEventItem *> *items = _itemDictionary[item.trackingID];
            if(!items){
                items = [NSMutableArray array];
                _itemDictionary[item.trackingID] = items;
            }
            [items addObject:item];
        }
        
    }
    return self;
}

#pragma mark - 前置判断


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    //   允许多个UIGestureRecognizer共享一个点击
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //获得当前点中的view
    CGPoint touchPoint = [gestureRecognizer locationInView:_rootView];
    _viewOnTouch = [self viewAtPoint:touchPoint withView:_rootView];
    _isLongPressHappen = NO;
    if (_viewOnTouch) {
        return YES;
    }else{
        return NO;
    }
    
}


#pragma mark - 事件触发


- (void)tap:(UIGestureRecognizer *)gestureRecognizer {
    [self uploadEventWithView:_viewOnTouch eventType:EventTypeTap];
}

- (void)swipe:(UIGestureRecognizer *)gestureRecognizer {
    [self uploadEventWithView:_viewOnTouch eventType:EventTypeSwipe];
}

- (void)longPress:(UIGestureRecognizer *)gestureRecognizer {
    if (!_isLongPressHappen) {
        _isLongPressHappen = YES;
        [self uploadEventWithView:_viewOnTouch eventType:EventTypeLongPress];
    }
}



- (void)uploadEventWithView:(UIView *)view eventType:(EventType)eventType{
    NSString *identifier = view.trackingID;
    
    NSArray<TrackEventItem *> *items = _itemDictionary[identifier];
    if (items) {
        for (TrackEventItem *item in items) {
            if (item.type == eventType) {
                //找到对应item,且事件类型相同
                
                if(item.ignored){
                    //忽略的项,不作处理
                    return;
                }
                
                NSString *parentID = item.parent;
                if ([NSString isEmpty:parentID] || [self isView:view containsParentWithID:parentID]) {
                    //没有指定的parent或者,view包含有指定的parent,匹配完成,上报
                    [_delegate onEventScreen:_screenName prefix:_prefixString trackEventItem:item name:item.name];
                    return;
                }
            }
        }
    }
    
    UIView *parent = view.superview;
    
    if (parent && parent != _rootView) {
        //有父类,往父类找
        [self uploadEventWithView:parent eventType:eventType];
    }else{
        //没有父类了,当前事件没有响应者,找出有没有view的id
        NSString *identifier = [self lastParentViewIDForView:_viewOnTouch];
        if (identifier != nil) {
            //找到父类有id,上报,以后或许有帮助
            NSString *name = [NSString stringWithFormat:@"type:%ld,id:%@",(long)eventType,identifier];
            [_delegate onEventScreen:_screenName prefix:_prefixString trackEventItem:nil name:name];
        }
        return;
    }
    
    
}

#pragma mark - 辅助方法

/*
 *根据点击位置及根view,获得点所对应的view
 */
- (UIView *)viewAtPoint:(CGPoint)point withView:(UIView *)view{
    if ( view.isHidden || view.alpha <= 0.01) {
        //看不到不处理
        return nil;
    }
    
    if ([view pointInside:point withEvent:nil]) {
        for (UIView *subview in [view.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subview convertPoint:point fromView:view];
            UIView *hitTestView = [self viewAtPoint:convertedPoint withView:subview];
            if (hitTestView) {
                return hitTestView;
            }
        }
        return view;
    }
    return nil;
}


/**
 * 寻找父类,确定是否包含指定id
 */
- (BOOL)isView:(UIView *)view containsParentWithID:(NSString *)parentID{
    
    if (!parentID) {
        [Logger logEWithTag:TAG format:@"传入空父类ID"];
        return NO;
    }
    
    NSString *identifier = view.trackingID;
    if ([parentID isEqualToString:identifier]) {
        //id相同,找到包含这个ID的父类,返回YES
        return YES;
    } else{
        //id不同,向父类寻找
        UIView *parent = view.superview;
        if (parent && parent!= _rootView) {
            return [self isView:parent containsParentWithID:parentID];
        }else{
            //到达顶层了,返回NO
            return NO;
        }
    }
}

/**找出带id的父类*/
- (NSString *)lastParentViewIDForView:(UIView *)view{
    UIView *parent = view.superview;
    if (parent && parent != _rootView) {
        //未到达顶层容器,寻找parentID
        NSString *parentID = parent.trackingID;
        
        if (parentID != nil) {
            //存在parentID,返回
            return parentID;
        }else{
            //不存在parentID,往上级寻找
            return [self lastParentViewIDForView:parent];
        }
        
    }else{
        //已经到达顶层view,返回空
        return nil;
    }
    
    
    
}

@end
