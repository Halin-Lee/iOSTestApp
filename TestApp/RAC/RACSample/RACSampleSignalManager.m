//
//  RACSampleSignalManager.m
//  TestApp
//
//  Created by Halin Lee on 3/5/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import "RACSampleSignalManager.h"
#import "RACSampleService.h"

@interface RACSampleSignalManager ()

@property (weak,nonatomic) RACSampleViewController *viewController;

@property (strong,nonatomic) RACSignal *validSignal;

@end


@implementation RACSampleSignalManager

//入口，出口，节点，开关
//入口对应于 command
//出口对应 subscribe(error,completed）
//节点对应于 onNext
//开关 subject?


- (instancetype)initWithViewController:(RACSampleViewController *)viewController {
    self = [super init];
    if (self) {
        
        
        self.viewController = viewController;
        
        [self setupTrackablePipeline];
        [self setupTrackButtonPipeline];
        [self setupTrackPipeline];
        //问题：modelSignal 有两个入口，一个是按键点击，一个是加载的时候，而出口是相同的，
        
        
        //入口，下拉，出口，成功，失败，单号完成
        
        //入口，页面打开查询，下拉查询，
        
    }
    return self;
}

#pragma mark - 查询主线


- (void)setupTrackPipeline{
    [RACObserve([RACSampleService sharedSingleton], isTracking) subscribeNext:^(id x) {
        NSLog(@"isTracking %@",x);
    }];
    [RACSampleService sharedSingleton].isTracking = YES;
    
//两种启动，实际启动，初始化设置为启动

    
}

- (RACSignal *)trackSignal{

    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACSampleService sharedSingleton] trackWithNo:self.viewController.vTrackNoInput.text callback:^(NSString *result) {
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        }];
        return nil;
    }];

}


- (void)setupTrackButtonPipeline{
    RACCommand *clickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal empty];
    }];
    self.viewController.vTrack.rac_command = clickCommand;
    
    
    
    
   [[[clickCommand.executionSignals flattenMap:^RACStream *(id value) {
       //当按键点击，转换成valid信号
       return self.validSignal;
   }] flattenMap:^RACStream *(NSNumber * value) {
       return value.boolValue?[RACSignal error:[NSError new]]: [RACSignal empty];
   }]
    subscribeError:^(NSError *error) {
       self.viewController.vTrack.backgroundColor = [UIColor redColor];
   } completed:^{
       [[RACSampleService sharedSingleton] trackWithNo:self.viewController.vTrackNoInput.text callback:nil];
   }];
    
    
//    self.validSignal subscribeNext:<#^(id x)nextBlock#> error:<#^(NSError *error)errorBlock#> completed:<#^(void)completedBlock#>
   
    
    
    
}


#pragma mark 输入框支线

- (void)setupTrackablePipeline{
    
    @weakify(self)
    _validSignal =  [self.viewController.vTrackNoInput.rac_textSignal
                     map:^id(id value) {
        @strongify(self)
        return @([self validInputValid:value]);
    }];
    
    RAC(self.viewController.vTrack,backgroundColor) = [_validSignal map:^id(NSNumber *value) {
        return value.boolValue? [UIColor clearColor] : [UIColor yellowColor];
    }];
}


- (BOOL)validInputValid:(NSString *)input{
    return input && input.length > 6;
}

#pragma mark - 翻译主线

@end
