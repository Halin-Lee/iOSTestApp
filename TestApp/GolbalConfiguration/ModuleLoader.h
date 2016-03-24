//
//  ModuleLoader.h
//  Pods
//
//  Created by 17track on 3/18/16.
//
//

#import <Foundation/Foundation.h>
#import "ConfigurableProtocol.h"


/**所有配置必须以Configuration为后缀命名(否则找不到),所有Configuration必须继承ConfigurableProtocol*/
@interface ModuleLoader : NSObject

+ (instancetype)shareInstance;

- (void)loadModuleWithName:(NSString *)name;

- (BOOL)update:(NSData *)xmlData;

- (id<ConfigurableProtocol>)configurationWithClass:(Class)clazz;

@end
