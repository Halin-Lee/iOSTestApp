//
//  PhotosViewController.m
//  TestApp
//
//  Created by Halin Lee on 3/23/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import "PhotosViewController.h"
#import <Photos/Photos.h>
#import "PhotosTableViewCell.h"
#import "Mediator.h"
#import "PhotosPlayerViewController.h"
static NSString* kCellIdentifier = @"PhotosTableViewCell";

@interface PhotosViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *vTable;

@property (strong,nonatomic) NSMutableArray<AVURLAsset *> *assets;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.assets = [NSMutableArray array];
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.predicate =  [NSPredicate predicateWithFormat:@"mediaType = %d && duration < 30.0",PHAssetMediaTypeVideo];
    PHFetchResult *result = [PHAsset fetchAssetsWithOptions:fetchOptions];
    __weak __typeof(self) weakSelf = self;
    for (int i = 0 ; i < result.count; i ++) {
       PHAsset *asset = [result objectAtIndex:i];
     
        [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:nil resultHandler:^(AVAsset * avasset, AVAudioMix * audioMix, NSDictionary * info) {
            [weakSelf.assets addObject:avasset];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.vTable reloadData];
            });
        }];
    }
    
    
    [self.vTable registerNib:[UINib nibWithNibName:kCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.assets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    AVURLAsset *asset = self.assets[indexPath.row];
    cell.vImage.image = [self imageFromAssets:asset];
    cell.vLable.text = asset.URL.absoluteString.lastPathComponent;
    return cell;
}


- (UIImage *)imageFromAssets:(AVURLAsset *)asset{
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime duration = asset.duration;
    CGFloat durationInSeconds = duration.value / duration.timescale;
    CMTime time = CMTimeMakeWithSeconds(durationInSeconds * 0.1, (int)duration.value);
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbnail;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AVURLAsset *asset = self.assets[indexPath.row];
    UIViewController<ConfigurableViewControllerDelegate> *controller = [[PhotosPlayerViewController alloc] init];
    [[Mediator sharedSingleton] presentViewController:controller withParamDictionary:@{@"url":asset.URL.absoluteString} animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
