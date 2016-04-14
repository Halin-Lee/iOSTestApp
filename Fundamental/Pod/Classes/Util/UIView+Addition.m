//
//  UIView+Addition.m
//  Halin
//
//  Created by Halin on 15-6-11.
//  Copyright (c) 2015年 Halin All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView(Addition)

- (void)setBorderColor:(UIColor*)color {
    self.layer.borderColor = color.CGColor;
}

- (UIColor*)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBoarderWidth:(CGFloat)boarderWidth{
    self.layer.borderWidth = boarderWidth;
}

- (CGFloat)boarderWidth{
    return self.layer.borderWidth;
}


- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}

- (BOOL)masksToBounds{
    return self.layer.masksToBounds;
}


@end
