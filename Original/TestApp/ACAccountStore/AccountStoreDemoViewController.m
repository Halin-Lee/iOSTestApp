//
//  AccountStoreDemoViewController.m
//  TestApp
//
//  Created by 17track on 4/19/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "AccountStoreDemoViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

static NSString *tableViewCellIndentifier = @"tableViewCellIndentifier";

@interface AccountStoreDemoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *vTable;
@property (nonatomic,strong) NSArray *accountArray;
@end

@implementation AccountStoreDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_vTable registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellIndentifier];
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    NSArray *accountTypeIdArray = @[ACAccountTypeIdentifierTwitter];
    NSDictionary *facebookOptions = @{
                              ACFacebookAppIdKey : @"993773287339223",
                              ACFacebookPermissionsKey : @[@"email"],
                              ACFacebookAudienceKey : ACFacebookAudienceOnlyMe};
    
    //申请访问账号
    for (NSString *accountTypeId in accountTypeIdArray) {
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:accountTypeId];
        
        NSDictionary *options;
        if ([accountTypeId isEqualToString:ACAccountTypeIdentifierFacebook]) {
            options = facebookOptions;
        }
        
        [accountStore requestAccessToAccountsWithType:accountType options:options completion:^(BOOL granted, NSError *error) {
            if (granted) {
                NSArray *accounts = [accountStore accountsWithAccountType:accountType];
                ACAccount *account = accounts.firstObject;
                
                NSDictionary *message = @{@"status": @"My First Twitter post from iOS6"};
                
                NSURL *requestURL = [NSURL
                                     URLWithString:@"http://api.twitter.com/1/statuses/update.json"];
                
                SLRequest *postRequest = [SLRequest
                                          requestForServiceType:SLServiceTypeTwitter
                                          requestMethod:SLRequestMethodPOST
                                          URL:requestURL parameters:message];
                
                postRequest.account = account;
                
                [postRequest
                 performRequestWithHandler:^(NSData *responseData,
                                             NSHTTPURLResponse *urlResponse, NSError *error)
                 {
                     NSLog(@"Twitter HTTP response: %li", 
                           (long)[urlResponse statusCode]);
                 }];
                _accountArray = accountStore.accounts;
                [_vTable reloadData];
            }else{
                NSLog(@"授权失败:%@",error);
            }
        }];
    }
    _accountArray = accountStore.accounts;
    [_vTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIndentifier];
    ACAccount *account = _accountArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Name:%@ Credential%@",account.username,account.credential];
    NSLog(@"账号信息:%@ Type:%@ Name:%@ Credential:%@ oauthToken:%@",account,account.accountType,account.username,account.credential,account.credential.oauthToken);

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _accountArray.count;
}



@end
