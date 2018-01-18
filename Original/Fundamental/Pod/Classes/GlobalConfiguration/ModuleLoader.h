//
//  ModuleLoader.h
//  Pods
//
//  Created by Halin on 3/18/16.
//
//

#import <Foundation/Foundation.h>
#import "CommonMarco.h"
#import "ConfigurableProtocol.h"


/**所有配置必须以Configuration为后缀命名(否则找不到),所有Configuration必须继承ConfigurableProtocol*/
@interface ModuleLoader : NSObject

SINGLETON_FOR_HEADER(ModuleLoader)

- (void)loadModuleWithName:(NSString *)name;

- (BOOL)update:(NSData *)xmlData;

- (id<ConfigurableProtocol>)configurationWithClass:(Class)clazz;

@end
