//
//  GolbalConfiguration.h
//  Pods
//
//  Created by 17track on 3/18/16.
//
//

#import <Foundation/Foundation.h>
#import "ConfigurableProtocol.h"

/**全局配置,可从xml加载,readonly的是不可配置项*/
@interface GolbalConfiguration : NSObject 

+ (instancetype)shareInstance;

@property (nonatomic,copy) NSString *appGroupID;

@property (nonatomic,copy,readonly) NSString *appFilePath;
@property (nonatomic,copy,readonly) NSString *moduleConfigurationFileName;
@end
