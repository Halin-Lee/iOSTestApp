//
//  GlobalConfiguration.m
//  Pods
//
//  Created by Halin on 3/18/16.
//
//

#import "GlobalConfiguration.h"
#import "Logger.h"

static NSString *const HALIN_APP_GROUP = @"group.me.halin";
static NSString *const HALIN_RESOURCE_PATH = @"halin";

@implementation GlobalConfiguration



SINGLETON_FOR_CLASS(GlobalConfiguration)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _appGroupID = [self defaultAppGroupID];
        _appFilePath = [self defaultFilePath];
        _moduleConfigurationFileName = @"SystemConfiguration";
    }
    return self;
}


/**获得App Group名称*/
- (NSString *)defaultAppGroupID{
    
    //获得archived-expanded-entitlements.xcent文件
    NSString* path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], @"archived-expanded-entitlements.xcent"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:path];
    //提取文件参数
    if (dict){
        //获得id
        NSArray *ids = [dict objectForKey:@"com.apple.security.application-groups"];
        NSString *groupsID = [ids firstObject];
        if (groupsID) {
            //id存在,返回
            return groupsID;
        }
    }
    //从文件获取id失败...使用普通id
    return HALIN_RESOURCE_PATH;
}



- (NSString *)defaultFilePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //从制定App Groups获得文件路径
    //    NSURL *fileManagerURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:HALIN_APP_GROUP];
    //    NSString *dbPath = [fileManagerURL.path stringByAppendingPathComponent:TRACK_RECORD_DB_NAME];
    
    //从plist获得appGroups 并转换为文件路径
    NSString *appGroups = [self appGroupID];
    NSURL *fileManagerURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:appGroups];
    
    
    if (fileManagerURL) {
        return fileManagerURL.path;
    }else {
        [Logger logEWithTag:NSStringFromClass([self class]) format:@"无法获得App路径 appGroups:%@ fileManagerURLPath:%@",appGroups,fileManagerURL];
        //使用本地路径代替App Group..可能导致部分用户的数据丢失..但能保证大部分用户正常使用我们的App
        NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        return documents.firstObject;
    }
}



@end
