//
//  MessageUITestViewController.m
//  TestApp
//
//  Created by Halin on 9/15/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "MessageUITestViewController.h"
#import <MessageUI/MessageUI.h>

@interface MessageUITestViewController ()<MFMessageComposeViewControllerDelegate,UIAlertViewDelegate>

@end

@implementation MessageUITestViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    if( [MFMessageComposeViewController canSendText] ){
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
//        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = @"Halin For Test";
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"Halin"];//修改短信界面标题
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (ViewControllerPresentType)viewControllerPresentType{
    return ViewControllerPresentTypePush;
}
@end
