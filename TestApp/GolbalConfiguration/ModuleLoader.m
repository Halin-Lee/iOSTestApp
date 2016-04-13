//
//  ModuleLoader.m
//  Pods
//
//  Created by Halin on 3/18/16.
//
//

#import "ModuleLoader.h"
#import "DDXML.h"
#import "Logger.h"
#import "GolbalConfiguration.h"
#import "InitializableProtocol.h"


static NSString *const KEY_NAME = @"iOSName";
static NSString *const TAG = @"Configuration";

@interface ModuleLoader ()

@property (nonatomic,strong) NSMutableDictionary *configDictionary;


@property (nonatomic,strong) NSString *configurationFilePath;


@end


@implementation ModuleLoader

SINGLETON_FOR_CLASS(ModuleLoader)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _configDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}



- (void)loadModuleWithName:(NSString *)name{
    
    //TODO:不适合带入Bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"xml"];
    //加载默认配置
    NSData *configData = [NSData dataWithContentsOfFile:path];
    NSError *error;
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:configData options:0 error:&error];
    if (error) {
        [Logger logEWithTag:TAG format:@"默认配置文件解析失败 Error:%@",error];
    }
    DDXMLElement *environmentElement = [doc rootElement];
    
    //解析Golbal配置
    NSArray *golbals = [environmentElement elementsForName:@"Golbal"];
    if (golbals.count > 1|| golbals.count == 0) {
        [Logger logEWithTag:TAG format:@"Golbal 数量异常 %ld",golbals.count];
    }
    GolbalConfiguration *golbalConfiguration = [GolbalConfiguration sharedSingleton];
    [self parserElement:golbals.firstObject toObject:golbalConfiguration];

    
    //解析模块配置
    [self parserConfiguration:environmentElement withBlock:^id<ConfigurableProtocol>(NSString *moduleName) {
        Class class = NSClassFromString(moduleName);
        id<ConfigurableProtocol> module = [[class alloc] initWithDefaultValue];
        if(!module){
            [Logger logEWithTag:TAG format:@"找不到指定Module %@",moduleName];
        }
        _configDictionary[moduleName] = module;
        return module;
    }];
    
    
    //从配置文件里加载配置
    NSFileManager *fileManager = [NSFileManager defaultManager];
    _configurationFilePath = [golbalConfiguration.appFilePath stringByAppendingPathComponent:golbalConfiguration.moduleConfigurationFileName];
    if ([fileManager fileExistsAtPath:_configurationFilePath]) {
        NSData *localFileData = [NSData dataWithContentsOfFile:_configurationFilePath];
        doc = [[DDXMLDocument alloc] initWithData:localFileData options:0 error:&error];
        if (error) {
            [Logger logEWithTag:TAG format:@"本地配置文件解析失败 Error:%@",error];
            //加载失败,删除文件
            [fileManager removeItemAtPath:_configurationFilePath error:nil];
        }
        //覆盖配置里有的节点
        [self parserConfiguration:[doc rootElement] withBlock:^id<ConfigurableProtocol>(NSString *moduleName) {
            return _configDictionary[moduleName];
        }];
    }
    

    //调用初始化方法
    for(id module in _configDictionary.allValues){
        if ([module conformsToProtocol:@protocol(InitializableProtocol) ]) {
            [(id<InitializableProtocol>)module setup];
        }
    }
}


- (BOOL)update:(NSData *)xmlData{

    
    //重新解析xml,还原默认值
    NSError *error;
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (error) {
        [Logger logEWithTag:TAG format:@"配置文件解析失败 Error:%@",error];
    }
    [_configDictionary removeAllObjects];
    DDXMLElement *environmentElement = [doc rootElement];
    [self parserConfiguration:environmentElement withBlock:^id<ConfigurableProtocol>(NSString *moduleName) {
        Class class = NSClassFromString(moduleName);
        id<ConfigurableProtocol> module = [[class alloc] initWithDefaultValue];
        if(!module){
            [Logger logEWithTag:TAG format:@"找不到指定Module %@",moduleName];
        }
        _configDictionary[moduleName] = module;
        return module;
    }];
    

    //解析传入的data
    doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (error) {
        [Logger logEWithTag:TAG format:@"配置文件解析失败 Error:%@",error];
        return NO;
    }
    
    //覆盖配置里有的节点
    [self parserConfiguration:[doc rootElement] withBlock:^id<ConfigurableProtocol>(NSString *moduleName) {
        return _configDictionary[moduleName];
    }];
    
    //保存文件
    //保存由更新工具完成,这样可以让更新工具同时更新不同配置文件(如,app和小插件)
//    [xmlData writeToFile:_configurationFilePath atomically:YES];
    return YES;
}

//解析并写入参数
- (void)parserConfiguration:(DDXMLElement *)environmentElement withBlock:(id<ConfigurableProtocol> (^)(NSString *moduleName))block {

    NSArray *moduleElements = [environmentElement elementsForName:@"Module"];
    for (DDXMLElement *moduleElement in moduleElements) {
        
        NSString *moduleName = [moduleElement attributeForName:KEY_NAME].stringValue;
        moduleName = [moduleName  stringByAppendingString:@"Configuration"];
        id<ConfigurableProtocol> module = block(moduleName);
        if (module) {
            [self parserElement:moduleElement toObject:module];
        }
    }
}


- (void)parserElement:(DDXMLElement *)element toObject:(id)object{
    
    for (DDXMLElement *item in [element children]) {
    
        NSString *type = item.name ;
        //注释会被包含进来
        if ([type isEqualToString:@"comment"]) {
            continue;
        }
        
        
        NSString *name = [item attributeForName:KEY_NAME].stringValue;
        NSString *value = item.stringValue;
        
        if ([type isEqualToString:@"string"]) {
            [object setValue:value forKey:name];
        }else if([type isEqualToString:@"bool"]){
            if ([value isEqualToString:@"true"]) {
                [object setValue:@(YES) forKey:name];
            }else{
                [object setValue:@(NO) forKey:name];
            }
            
        }else if([type isEqualToString:@"integer"]){
            [object setValue:@(value.integerValue) forKey:name];
        }else if([type isEqualToString:@"float"]){
            [object setValue:@(value.floatValue) forKey:name];
        }
        
    }
}


- (id<ConfigurableProtocol>)configurationWithClass:(Class)clazz{
    
    id<ConfigurableProtocol> output = _configDictionary[NSStringFromClass(clazz)];
    if (!output) {
        [Logger logEWithTag:TAG format:@"找不到配置参数 %@",clazz];
    }
    
    return output;
}


@end


