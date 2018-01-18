//
//  UIView+Addition.h
//  Halin
//
//  Created by Halin on 15-6-11.
//  Copyright (c) 2015年 Halin All rights reserved.
//

#import <UIKit/UIKit.h>
//IB_DESIGNABLE
@interface UIView(Addition)

@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@property (nonatomic, assign) IBInspectable CGFloat boarderWidth;

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic, assign) IBInspectable BOOL masksToBounds;
@end
