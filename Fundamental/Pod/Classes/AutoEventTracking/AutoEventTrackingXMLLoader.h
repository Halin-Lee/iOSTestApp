//
//  AutoEventTrackingXMLLoader.h
//  TestApp
//
//  Created by Halin on 4/12/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonMarco.h"

@interface AutoEventTrackingXMLLoader : NSObject

SINGLETON_FOR_HEADER(AutoEventTrackingXMLLoader)

- (void)loadFromPath:(NSString *)path;

- (NSArray *)itemsForViewController:(NSString *)viewControllerClass;

- (NSString *)screenNameForViewController:(NSString *)viewControllerClass;


@end
