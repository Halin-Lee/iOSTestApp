//
// Created by Halin Lee on 12/8/17.
// Copyright (c) 2017 me.halin. All rights reserved.
//

#import "CheckClientCertificationTest.h"

#import "AFNetworking.h"


@interface CustomSecurityPolicy:AFSecurityPolicy
@end

@interface NSData(Addition)
- (NSString *)hexadecimalString ;
@end

@implementation CheckClientCertificationTest


static AFHTTPSessionManager *sessionManager;

+ (void)test{

    if (!sessionManager) {
        sessionManager = [AFHTTPSessionManager manager];
//        sessionManager.securityPolicy = [[CustomSecurityPolicy alloc] init];
        [sessionManager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session,
                                                                                                               NSURLAuthenticationChallenge * _Nonnull challenge,
                                                                                                               NSURLCredential *__autoreleasing  _Nullable * _Nullable credential) {
            
            SecKeyRef keyref = SecTrustCopyPublicKey(challenge.protectionSpace.serverTrust);
            size_t keySize = SecKeyGetBlockSize(keyref);
            NSData *keyData = [NSData dataWithBytes:keyref length:keySize];
            
            CFErrorRef *error = nil;
            CFDataRef cfData = SecKeyCopyExternalRepresentation(keyref, error);
            NSData * data1 = (__bridge NSData *)cfData;
            
            
            
            NSLog(@"key:%@",[data1 base64EncodedDataWithOptions:0]);
            return NSURLSessionAuthChallengeCancelAuthenticationChallenge;
        }];
        
        
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [sessionManager GET:@"https://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@",string);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {

        }];


    }

}



@end


@implementation CustomSecurityPolicy

- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust forDomain:(nullable NSString *)domain {
    return [super evaluateServerTrust:serverTrust forDomain:domain];
}

@end



@implementation NSData(Addition)

- (NSString *)hexadecimalString {
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    if (!dataBuffer) return [NSString string];
    
    NSUInteger          dataLength  = [self length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%ld", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}
@end

