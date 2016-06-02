//
//  AutoEventTrackingTests.m
//  TestApp
//
//  Created by Halin on 4/12/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "Kiwi.h"
#import "AutoEventTrackingXMLLoader.h"


SPEC_BEGIN(AutoEventTrackingXMLLoaderTests)


describe(@"AutoEventTrackingXMLLoader Tests", ^{

    context(@"Test Load", ^{
        xit(@"Normal", ^{
            
            AutoEventTrackingXMLLoader *loader = [AutoEventTrackingXMLLoader sharedSingleton];
            NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"event_tracker_demo_list" ofType:@"xml"];
            [[path shouldNot] beEmpty];
            [loader loadFromPath:path];
            NSArray *array =[loader itemsForViewController:@"AutoEventTrackingDemoViewController"];
            [[array shouldNot] beEmpty];
        });
    });
    
});

SPEC_END