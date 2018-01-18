//
//  CommonMarco.h
//  Pods
//
//  Created by Halin on 2/18/16.
//
//

/**单例Header定义*/
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)sharedSingleton;

/**单例Class定义*/
#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)sharedSingleton { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}


/**NSStringFromSelector缩写*/
#define NAME_FOR_SEL(sel) NSStringFromSelector(@selector(sel))


/**防止NSError的description打印出乱码*/
#import "NSError+Addition.h"