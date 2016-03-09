//
//  JSPatch.h
//  JSPatch
//
//  Created by bang on 15/11/14.
//  Copyright (c) 2015 bang. All rights reserved.
//

#import <Foundation/Foundation.h>

const static NSString *rootUrl = @"http://192.168.1.60:8000/HelloWorld/JSPatch";
static NSString *publicKey = @"-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC8JM3/26Bgl/fWHE+tZwQnwMDMlqk2ZXdy9kea15gIbEh7zVyw+G2y5q9Y52afi57mJFPPmsa8uca3SJvGxWEbVAsq81/PfXsmZrogMxJleMFRFctIs+JywmmAYRjDvypjALxx6pv9T8qvhg01O3zMqIrnCNvcIpT+eDUe0+xZZwIDAQAB-----END PUBLIC KEY-----";

typedef void (^JPUpdateCallback)(NSError *error);

typedef enum {
    JPUpdateErrorUnzipFailed = -1001,
    JPUpdateErrorVerifyFailed = -1002,
} JPUpdateError;

@interface JPLoader : NSObject
+ (BOOL)run;
+ (void)updateToVersion:(NSInteger)version callback:(JPUpdateCallback)callback;
+ (void)runTestScriptInBundle;
+ (void)setLogger:(void(^)(NSString *log))logger;
+ (NSInteger)currentVersion;
@end