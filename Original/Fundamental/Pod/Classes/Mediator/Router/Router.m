//
//  Router.m
//  Pods
//
//  Created by Halin on 3/22/16.
//
//

#import "Router.h"
#import "DDXML.h"
#import "NSString+addition.h"
#import "Logger.h"
#import "Mediator.h"

static NSString *const KEY_APP_URL = @"appUrl";
static NSString *const KEY_WEB_URL = @"webUrl";
static NSString *const TAG = @"Router";

@interface Router ()

@property (nonatomic,strong) NSMutableDictionary *routerDictionary;

@end


@implementation Router
SINGLETON_FOR_CLASS(Router)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _routerDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setupWithResourcePath:(NSString *)path{
    
    //加载路由文件
    NSData *configData = [NSData dataWithContentsOfFile:path];
    NSError *error;
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:configData options:0 error:&error];
    if (error) {
        [Logger logEWithTag:TAG format:@"解析路由文件出错 : Error:%@",error];
        return;
    }
    DDXMLElement *root = [doc rootElement];
    
    //解析Golbal配置
    NSArray *items = [root elementsForName:@"item"];
    
    
    for(DDXMLElement *item in items){
        NSString *appUrl = [item attributeForName:KEY_APP_URL].stringValue;
        NSString *webUrl = [item attributeForName:KEY_WEB_URL].stringValue;
        
        _routerDictionary[webUrl.lowercaseString] = appUrl;
    }
    
    [Logger logWithTag:TAG format:@"加载路由转换成功,转换表 %@",_routerDictionary];

}

- (NSString *)appUrlFromWebUrl:(NSString *)webUrl{
    
    if ([NSString isEmpty:webUrl]) {
        [Logger logEWithTag:TAG format:@"传入空URL"];
        return nil;
    }
    
    NSString *path,*query;
    NSArray *parts = [webUrl componentsSeparatedByString:@"?"];
    path = parts[0];
    if (parts.count > 1) {
        query = parts[1];
    }
    
    if ([NSString isEmpty:path]) {
        [Logger logEWithTag:TAG format:@"无法解析URL %@",webUrl];
        return nil;
    }
    
    NSString *convertedPath = _routerDictionary[path];
    if ([NSString isEmpty:convertedPath]) {
        
        [Logger logEWithTag:TAG format:@"路由解析失败 %@",webUrl];
        return nil;
    }
    
    NSString *appUrl = query?[NSString stringWithFormat:@"%@?%@",convertedPath,query]:convertedPath;
    
    [Logger logWithTag:TAG format:@"路由转换成功 webUrl:%@  appUrl:%@",webUrl,appUrl];
    return appUrl;
}

@end
