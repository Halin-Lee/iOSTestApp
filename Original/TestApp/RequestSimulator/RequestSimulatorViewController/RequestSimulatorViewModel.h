//
//  RequestSimulatorViewModel.h
//  TestApp
//
//  Created by 17track on 8/2/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VolleyRequest.h"

@interface RequestSimulatorViewModel : NSObject

@property (nonatomic,weak) id delegate;

@property(nonatomic,copy) NSString *url;
@property(nonatomic,assign) RequestMethod method;
@property(nonatomic,assign) BOOL trustAnyCertificate;
@property(nonatomic,assign) BOOL usingProxy;
@property(nonatomic,copy) NSString *param;
@property(nonatomic,copy) NSString *result;

- (BOOL)isGet;

- (BOOL)isPost;

@end
