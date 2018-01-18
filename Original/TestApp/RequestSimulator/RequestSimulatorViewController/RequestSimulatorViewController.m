//
//  RequestSimulatorViewController.m
//  TestApp
//
//  Created by 17track on 8/2/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RequestSimulatorViewController.h"
#import "RequestSimulatorViewModel.h"
#import "DataBindingLib.h"
#import "PlaceHolderView.h"

PlaceHolderViewClass(RequestSimulatorCheckBox)
@interface RequestSimulatorViewController ()
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *getGestureRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *postGestureRecognizer;
@property (nonatomic,strong) RequestSimulatorViewModel *viewModel;
@end

@implementation RequestSimulatorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    _viewModel = [[RequestSimulatorViewModel alloc] init];
    [[DataBindingUtil dataBindingUtil] bindModel:_viewModel forView:self.view];
    
    _viewModel.delegate = self;
    _viewModel.url = @"http://userapi.17track.net/api/user/setcookie";

    
    
    
}

- (IBAction)tap:(UIGestureRecognizer *)sender {
    _viewModel.method = sender == _getGestureRecognizer? RequestMethodGet:RequestMethodPost;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
