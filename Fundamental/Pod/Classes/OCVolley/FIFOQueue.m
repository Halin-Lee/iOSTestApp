//
//  FIFOQueue.m
//  TestApp
//
//  Created by 17track on 6/1/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "FIFOQueue.h"

@interface FIFOQueue()

@property (nonatomic,strong,readonly) NSMutableArray *queue;

@end

@implementation FIFOQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = [NSMutableArray array];
    }
    return self;
}

// Queues are first-in-first-out, so we remove objects from the head
- (id) dequeue {
    if ([_queue count] == 0)
        return nil;
    id headObject = [_queue objectAtIndex:0];
    if (headObject != nil) {
        [_queue removeObjectAtIndex:0];
    }
    return headObject;
}

// Add to the tail of the queue (no one likes it when people cut in line!)
- (void) enqueue:(id)anObject {
    [_queue addObject:anObject];
    //this method automatically adds to the end of the array
}


- (void)clearAll{
    [_queue removeAllObjects];
}

@end
