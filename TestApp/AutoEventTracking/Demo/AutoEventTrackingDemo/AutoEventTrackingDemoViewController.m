//
//  AutoEventTrackingDemoViewController.m
//  TestApp
//
//  Created by 17track on 4/11/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "AutoEventTrackingDemoViewController.h"
#import "AutoEventTrackingXMLLoader.h"
#import "AutoEventTracking.h"
#import "UIView+AutoEventTracking.h"
#import "AutoEventTrackingDemoTableViewCell.h"

#pragma mark - 定义子view


static NSString *tableViewCellIndentifier = @"tableViewCellIndentifier";

@interface AutoEventTrackingDemoViewController ()

@property (nonatomic,strong) AutoEventTracking *autoEventTracking;

@property (weak, nonatomic) IBOutlet UITableView *vTable;

@end

@implementation AutoEventTrackingDemoViewController

- (IBAction)tap:(id)sender {
        //两个gestureRecognizer不互相冲突
        NSLog(@"Tap");
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //避免顶部被Navigation遮挡
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化table
    UINib *nib = [UINib nibWithNibName:@"AutoEventTrackingDemoTableViewCell" bundle:[NSBundle mainBundle]];
    [_vTable registerNib:nib forCellReuseIdentifier:tableViewCellIndentifier];
    
    //加载xml资源,初始化自动化跟踪
    NSString *path = [[NSBundle mainBundle] pathForResource:@"event_tracker_demo_list" ofType:@"xml"];
    AutoEventTrackingXMLLoader *loader = [AutoEventTrackingXMLLoader sharedSingleton];
    [loader loadFromPath:path];
    _autoEventTracking = [[AutoEventTracking alloc] initWithController:self delegate:self];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    AutoEventTrackingDemoTableViewCell *cell = [_vTable dequeueReusableCellWithIdentifier:tableViewCellIndentifier];
    NSString *trackingID = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    cell.vSubView.vLable.trackingID = trackingID;
    cell.vSubView.vLable.text = trackingID;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0f;
}


- (ViewControllerPresentType)viewControllerPresentType{
    return ViewControllerPresentTypePush;
}

//允许删除
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //add code here for when you hit delete
//    }
//}

- (void)onEventScreen:(NSString *)screen prefix:(NSString *)prefix trackEventItem:(TrackEventItem *)trackEventItem name:(NSString *)name{

    if(trackEventItem.tag && [trackEventItem.tag isEqualToString:@"add_cell_count"]){
        
        NSLog(@"页面:%@ %@ 事件:%@ 当前cell数量:%d",screen,prefix,name,10);
    }else{
        NSLog(@"页面:%@ %@ 事件:%@",screen,prefix,name);
    }
    
    
}

@end
