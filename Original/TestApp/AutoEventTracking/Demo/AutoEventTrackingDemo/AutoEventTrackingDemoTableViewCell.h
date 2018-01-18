//
//  AutoEventTrackingDemoTableViewCell.h
//  TestApp
//
//  Created by Halin on 4/13/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlaceHolderView.h"

#pragma mark - 子view定义

@interface AutoEventTrackingDemoTableViewCellSubview : UIView
@property (weak, nonatomic) IBOutlet UILabel *vLable;
@end


@interface AutoEventTrackingDemoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *vScroll;

@property (weak, nonatomic) IBOutlet AutoEventTrackingDemoTableViewCellSubview *vSubView;
@end
