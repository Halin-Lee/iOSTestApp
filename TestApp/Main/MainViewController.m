//
//  MainViewController.m
//  TestApp
//
//  Created by Halin on 9/15/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "MainViewController.h"
#import "MessageUITestViewController.h"


@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSArray *displayNames;
@property (nonatomic,strong) NSArray *classes;

@property (weak, nonatomic) IBOutlet UITableView *vTableView;

@end

@implementation MainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.displayNames = @[@"MessageUI测试"];
    self.classes = @[[MessageUITestViewController class]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.classes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";                        //cell标识
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];  //根据标识获得cell
    
    
    if ( ! cell) {
        //cell不存在,构建并初始化cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    cell.textLabel.text = self.displayNames[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *controller = [[self.classes[indexPath.row] alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
