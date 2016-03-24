//
//  LogUtilTestIn.h
//  Halin
//
//  Created by Halin on 11/6/15.
//  Copyright © 2015 Halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogUtil.h"

@interface LogUtilTestIn : NSObject <LogUtil>


- (instancetype)initWithAppid:(NSString *)appid channel:(NSString *)appCHannel;

@end
