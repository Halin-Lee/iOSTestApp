//
//  PhotosPlayerViewController.m
//  TestApp
//
//  Created by Halin Lee on 3/23/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import "PhotosPlayerViewController.h"
#import "SCVideoPlayerView.h"

@interface PhotosPlayerViewController ()
@property (strong, nonatomic) IBOutlet SCVideoPlayerView *preview;
@property (copy,nonatomic) NSString *url;
@end

@implementation PhotosPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:self.url];
    AVAsset *asset = [AVAsset assetWithURL:url];
    [self.preview.player setItemByAsset:asset];
    [self.preview.player play];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)receiveStartParam:(NSDictionary *)dictionary{
    self.url = dictionary[@"url"];
}

@end
