//
//  Router.h
//  Pods
//
//  Created by Halin on 3/22/16.
//
//

#import <Foundation/Foundation.h>
#import "CommonMarco.h"
@interface Router : NSObject
SINGLETON_FOR_HEADER(Router)

- (void)setupWithResourcePath:(NSString *)path;


- (NSString *)appUrlFromWebUrl:(NSString *)webUrl;
@end
