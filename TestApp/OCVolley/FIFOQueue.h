//
//  FIFOQueue.h
//  TestApp
//
//  Created by 17track on 6/1/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**先进先出队列*/
@interface FIFOQueue : NSObject
- (id) dequeue;
- (void) enqueue:(id)obj;
@end
