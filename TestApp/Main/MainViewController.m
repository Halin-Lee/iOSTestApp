//
//  MainViewController.m
//  TestApp
//
//  Created by Halin on 9/15/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "MainViewController.h"
#import "MessageUITestViewController.h"
#import "TestItem.h"
#import "TestBuilder.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *testArray;

/**储存每个group第一个项的索引值*/
@property (nonatomic,strong) NSArray *indexArray;

@property (weak, nonatomic) IBOutlet UITableView *vTableView;

@property (nonatomic,assign) NSInteger sectionCount;

@end

@implementation MainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    _testArray = [[[TestBuilder alloc] init] build];
    [self setupData];
}


- (void)setupData{
    
    
    NSMutableArray *indexArray = [NSMutableArray array];
    NSInteger count = _testArray.count;
    NSString *lastSectionName  = @"";
    
    for (NSInteger i = 0 ; i < count ; i++) {
        TestItem *testItem = _testArray[i];
        NSString *localSectionName = testItem.testGroup;
        if (![lastSectionName isEqualToString:localSectionName]) {
            //当前的groupName与上一个groupName不同,到了新的group,保存groupName,添加新的index
            [indexArray addObject:@(i)];
            lastSectionName = localSectionName;
        }
    }

    _indexArray = indexArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _indexArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSInteger index = [_indexArray[section] integerValue];
    return ((TestItem *)_testArray[index]).testGroup;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //当前section第一个项目对应的index
    NSInteger localIndex = [_indexArray[section] integerValue];
    if(_indexArray.count - 1 != section){
        //不是最后一项,则取后面一项的index减去当前的index即是当前row的数量
        NSInteger nextIndex  = [_indexArray[section + 1] integerValue];
        return nextIndex - localIndex;
    }else{
        //最后一项,则row数量等于总row数量减去当前section的index
        return _testArray.count - localIndex;
    }
    
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
    
    NSInteger row = [self testArrayIndexForIndexPath:indexPath];
    cell.textLabel.text = ((TestItem *)_testArray[row]).testName;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [self testArrayIndexForIndexPath:indexPath];
    TestItem *testItem = _testArray[row];
    UIViewController *controller = [[testItem.clazz alloc] init];
//    [self presentViewController:controller animated:YES completion:nil];
    [self.navigationController pushViewController:controller animated:YES];
    NSLog(@"打开Controller:%@",[controller class]);
}


/**根据IndexPath获得testArray的index*/
- (NSInteger)testArrayIndexForIndexPath:(NSIndexPath *)indexPath{
    return [_indexArray[indexPath.section] integerValue] + indexPath.row;
}


@end
