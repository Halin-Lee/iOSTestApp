//
//  GolbalConfiguration.h
//  Pods
//
//  Created by Halin on 3/18/16.
//
//

#import <Foundation/Foundation.h>
#import "ConfigurableProtocol.h"
#import "Singleton.h"

/**全局配置,可从xml加载,readonly的是不可配置项*/
@interface GolbalConfiguration : NSObject 

SINGLETON_FOR_HEADER(GolbalConfiguration)

@property (nonatomic,copy) NSString *appGroupID;

@property (nonatomic,copy,readonly) NSString *appFilePath;
@property (nonatomic,copy,readonly) NSString *moduleConfigurationFileName;
@end
