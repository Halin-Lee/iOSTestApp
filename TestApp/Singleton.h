//
//  PrefixHeader.pch
//  PlaceHolderView
//
//  Created by Halin on 8/13/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//


#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)sharedSingleton;

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

