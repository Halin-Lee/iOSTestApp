//
//  RACSampleViewController.m
//  TestApp
//
//  Created by Halin Lee on 3/5/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import "RACSampleViewController.h"
#import "RACSampleSignalManager.h"

@interface RACSampleViewController ()

@end

@implementation RACSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    RACSampleSignalManager *manager = [[RACSampleSignalManager alloc] initWithViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
