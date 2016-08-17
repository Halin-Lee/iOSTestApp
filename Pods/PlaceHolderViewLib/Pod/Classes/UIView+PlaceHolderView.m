//
//  UIView+PlaceHolderView.m
//  Pods
//
//  Created by 17track on 8/3/16.
//
//

#import "UIView+PlaceHolderView.h"
#import <objc/runtime.h>

@implementation UIView(PlaceHolderView)

#pragma mark - PHID

+ (void)load{
    Method overridedMethod = class_getInstanceMethod([UIView class], @selector(overridedValueForUndefinedKey:));
    Method originalMehtod = class_getInstanceMethod([UIView class], @selector(valueForUndefinedKey:));
    method_exchangeImplementations(overridedMethod, originalMehtod);
}

- (id)overridedValueForUndefinedKey:(NSString *)key{

    if ([key hasPrefix:@"PH"]) {
        NSString *phid = [key stringByReplacingOccurrencesOfString:@"PH" withString:@""];
        UIView *phidView = [UIView view:self forPHID:phid];
        if (phidView) {
            return phidView;
        }
    }
    return [self overridedValueForUndefinedKey:key];
    
}

+ (UIView *)view:(UIView *)view forPHID:(NSString *)phid{
    for (UIView *subView in view.subviews) {
        if ([phid isEqualToString:subView.PHID]) {
            return subView;
        }
        UIView *phidView = [self view:subView forPHID:phid];
        if (phidView) {
            return phidView;
        }
    }
    return nil;
}


static const char * PHIDKey;
- (void)setPHID:(NSString *)PHID{
    objc_setAssociatedObject(self, &PHIDKey, PHID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)PHID{
    return objc_getAssociatedObject(self, &PHIDKey);
}




@end
