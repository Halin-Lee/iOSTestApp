//
//  LoggerInitialization.h
//  Pods
//
//  Created by Halin on 3/18/16.
//
//

#import <Foundation/Foundation.h>
#import "InitializableProtocol.h"

@interface LoggerConfiguration : NSObject<InitializableProtocol>

@property (nonatomic,copy) NSString *gaiID;
@property (nonatomic,copy) NSString *appID;
@property (nonatomic,copy) NSString *appChannel;
@property (nonatomic,assign) BOOL isDebug;

@end
