//
//  RouterConfiguration.h
//  Pods
//
//  Created by Halin on 3/22/16.
//
//

#import <Foundation/Foundation.h>
#import "InitializableProtocol.h"

@interface RouterConfiguration : NSObject<InitializableProtocol>


@property (nonatomic,copy) NSString *resourceName;


@end
