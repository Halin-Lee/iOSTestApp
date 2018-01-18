//
//  RACSampleViewController.h
//  TestApp
//
//  Created by Halin Lee on 3/5/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface RACSampleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *vTrackNoInput;

@property (weak, nonatomic) IBOutlet UIButton *vTrack;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *vTracking;
@property (weak, nonatomic) IBOutlet UILabel *vTrackResult;
@property (weak, nonatomic) IBOutlet UIButton *vTranslate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *vTranslating;

@end
