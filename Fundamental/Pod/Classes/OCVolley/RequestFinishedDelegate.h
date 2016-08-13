//
//  RequestFinishedDelegate.h
//  Pods
//
//  Created by 17track on 7/4/16.
//
//

@protocol RequestFinishedDelegate <NSObject>

- (void)didFinishedRequest:(VolleyRequest *)request;

@end