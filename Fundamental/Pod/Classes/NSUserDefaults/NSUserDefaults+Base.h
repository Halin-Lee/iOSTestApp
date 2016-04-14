//
//  NSUserDefaults+Base.h
//  Pods
//
//  Created by Halin on 2/18/16.
//
//

#import <Foundation/Foundation.h>


/**存放全局需要使用到的UserDefault*/
@interface NSUserDefaults(Base)

/**app语言(使用 language code 如:en)*/
@property (nonatomic) NSString *userLanguage;

/**用户uid*/
@property (nonatomic) NSString *uid;

/**widget上次请求事件*/
@property (nonatomic,strong)NSDate *lastRequestTime;

/**NSUserDefaults的版本*/
@property (nonatomic,readonly) NSInteger version;


+ (void)updateUserDefaults;

+ (instancetype)halinUserDefaults;

@end
