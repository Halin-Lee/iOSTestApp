//
//  AFNetworkingTests.m
//  
//
//  Created by 17track on 6/1/16.
//
//

#import <XCTest/XCTest.h>

#import "AFNetworking.h"
#import "Kiwi.h"
#import "OCVolley.h"

SPEC_BEGIN(AFNetworkingTests)

describe(@"Network测试", ^{
    context(@"AFNetworking测试", ^{
        
        xit(@"测试回调", ^{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            [manager setTaskDidCompleteBlock:^(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSError * _Nullable error) {
                
            }];
            
            [manager setDataTaskDidReceiveResponseBlock:^NSURLSessionResponseDisposition(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSURLResponse * _Nonnull response) {
                return NSURLSessionResponseAllow;
            }];
            
            
            [manager setDataTaskDidReceiveDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSData * _Nonnull data) {
                ;
            }];
            
            __block BOOL isSucceed = NO;
            [manager GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[responseObject should] equal:@"ABC"];
                isSucceed = YES;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [[error should] beNil];
                NSLog(@"Error %@",error.description);
                isSucceed = NO;
            }];
            
            [[expectFutureValue(theValue(isSucceed)) shouldEventuallyBeforeTimingOutAfter(3.0)] beYes];
        });
        
        xit(@"测试取消", ^{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            /**测试总时间*/
            float timeout = 60 * 1.0;
            //每个请求发送间隔
            double delayInSeconds = 0.001;
            //请求发送结束后,等待所有请求结束延时
            float postDelay = 5.0f;
            
            //测试记录项
            /**完成请求计数*/
            __block NSInteger finishCount = 0;
            /**发送请求计数*/
            __block NSInteger sentCount = 0;
            
            //主进程队列
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            //计时器
            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainQueue);
            //启动时间
            dispatch_time_t timerStartTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
            //计时间隔
            uint64_t interval = (uint64_t)(delayInSeconds * NSEC_PER_SEC);
            //计时器
            dispatch_source_set_timer(timer, timerStartTime, interval, 0);
            //请求结束时间
            dispatch_time_t finishTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeout * NSEC_PER_SEC));
            
            dispatch_source_set_event_handler(timer, ^{
                VolleyRequest *request = [[VolleyRequest alloc] init];
                request.task = [manager GET:@"http://192.168.1.13/~17track/index.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSAssert(!request.isCanceled, @"任务取消回调仍被调用");
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSAssert((request.isCanceled || error.code == -999), @"任务取消回调仍被调用");
                }];
                
                dispatch_async(mainQueue, ^{
                    [request cancel];
                    finishCount++;
                });
                
                if( finishTime < dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC))){
                    dispatch_source_cancel(timer);
                }
            });
            
            // 启动定时器
            dispatch_resume(timer);
            
            BOOL delay = NO;
            //延时,让所有请求跑完
            [[theValue(delay) shouldNotEventuallyBeforeTimingOutAfter(timeout + postDelay)] beYes];
        });
    });
    
    
    context(@"OCVolley测试", ^{
        xit(@"OCVolley压力测试,超过60000个请求后开始异常,请求不执行", ^{
            
            VolleyQueue *queue = [[VolleyQueue alloc] init];
            __block NSInteger finishCount = 0;
            NSInteger successCount = 10000;
            NSInteger failureCount = 10000;
            double delayInSeconds = 0.001;
            
            dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(globalQueue, ^{
                for(NSInteger i = 0 ; i < successCount;i++){
    
                    VolleyRequest *request = [VolleyRequest requestWithMehtod:RequestMethodGet url:@"http://192.168.1.13/~17track/index.html" param:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSString *responseString =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        [[responseString should] equal:@"Hello World!\n"];
                        finishCount++;
                    }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        fail(@"不应该失败");
                    }];
                    request.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
                    
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                    dispatch_after(popTime, mainQueue, ^(void){
                        [queue add:request];
                    });
                    
                   
                   
                }
            });
            
            dispatch_async(globalQueue, ^{
                for(NSInteger i = 0 ; i < failureCount;i++){
                    
                    VolleyRequest *request = [VolleyRequest requestWithMehtod:RequestMethodGet url:@"http://192.168.1.13/~17track/notFound.html" param:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        fail(@"不应该有返回");
                    }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        finishCount++;
                    }];
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                    dispatch_after(popTime, mainQueue, ^(void){
                        [queue add:request];
                    });
                    
                    
                }
            });
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC));
            dispatch_after(popTime, mainQueue, ^(void){
                //方便观察
            });
           
            
            BOOL delay = NO;
            NSInteger totalCount = successCount + failureCount;
            float timeout =totalCount * 0.005;
            [[theValue(delay) shouldNotEventuallyBeforeTimingOutAfter(timeout)] beYes];
            [[theValue(finishCount) should] equal:theValue(totalCount)];
        });
        
        xit(@"稳定性测试", ^{
            VolleyQueue *queue = [[VolleyQueue alloc] init];
            
            //可配置项
       
            /**测试总时间*/
            float timeout = 10 * 1.0;
            //每个请求发送间隔
            double delayInSeconds = 0.001;
            //请求发送结束后,等待所有请求结束延时
            float postDelay = 5.0f;
            
            //测试记录项
            /**完成请求计数*/
            __block NSInteger finishCount = 0;
            /**发送请求计数*/
            __block NSInteger sentCount = 0;
            
            //主进程队列
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            //计时器
            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainQueue);
            //启动时间
            dispatch_time_t timerStartTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
            //计时间隔
            uint64_t interval = (uint64_t)(delayInSeconds * NSEC_PER_SEC);
            //计时器
            dispatch_source_set_timer(timer, timerStartTime, interval, 0);
            //请求结束时间
            dispatch_time_t finishTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeout * NSEC_PER_SEC));
            
            // 设置回调
            dispatch_source_set_event_handler(timer, ^{
                
                if(queue.requestCount > 100){
                    //并发请求超过100个,不再发送
                    return;
                }
                
                //创建一个成功请求
                VolleyRequest *successRequest = [VolleyRequest requestWithMehtod:RequestMethodGet url:@"http://192.168.1.13/~17track/index.html" param:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSString *responseString =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    [[responseString should] equal:@"Hello World!\n"];
                    finishCount++;
                }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    fail(@"不应该失败");
                }];
                successRequest.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
                [queue add:successRequest];
                sentCount++;
            

                //创建一个失败请求
                VolleyRequest *failureRequest = [VolleyRequest requestWithMehtod:RequestMethodGet url:@"http://192.168.1.13/~17track/notFound.html" param:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    fail(@"不应该有返回");
                }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    finishCount++;
                }];
            
                [queue add:failureRequest];
                sentCount++;
                
                if( finishTime < dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC))){
                    dispatch_source_cancel(timer);
                }
                
            });
            
            // 启动定时器
            dispatch_resume(timer);
            
        
            
            
            BOOL delay = NO;
            //延时5s,让所有请求跑完
            [[theValue(delay) shouldNotEventuallyBeforeTimingOutAfter(timeout + postDelay)] beYes];
            [[theValue(sentCount) should] equal:theValue(finishCount)];
        });
    });
    
    
    xit(@"单个取消测试", ^{
        
        VolleyQueue *queue = [[VolleyQueue alloc] init];
        VolleyRequest *successRequest = [VolleyRequest requestWithMehtod:RequestMethodGet url:@"http://192.168.1.13/~17track/index.html" param:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            fail(@"不应该有返回");
        }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail(@"不应该有返回");
        }];
        [queue add:successRequest];
        
        [successRequest cancel];
        BOOL delay = NO;
        //延时,让所有请求跑完
        [[theValue(delay) shouldNotEventuallyBeforeTimingOutAfter(1.0)] beYes];
        [[theValue(queue.requestCount) should] equal:theValue(0)];
    });
    
    it(@"取消测试", ^{
        VolleyQueue *queue = [[VolleyQueue alloc] init];
        
        //可配置项
        
        /**测试总时间*/
        float timeout = 60 * 1.0;
        //每个请求发送间隔
        double delayInSeconds = 0.001;
        //请求发送结束后,等待所有请求结束延时
        float postDelay = 10.0f;
        
        //测试记录项
        /**完成请求计数*/
        __block NSInteger finishCount = 0;
        /**发送请求计数*/
        __block NSInteger sentCount = 0;
        
        //主进程队列
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        //计时器
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainQueue);
        //启动时间
        dispatch_time_t timerStartTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
        //计时间隔
        uint64_t interval = (uint64_t)(delayInSeconds * NSEC_PER_SEC);
        //计时器
        dispatch_source_set_timer(timer, timerStartTime, interval, 0);
        //请求结束时间
        dispatch_time_t finishTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeout * NSEC_PER_SEC));
        
        // 设置回调
        dispatch_source_set_event_handler(timer, ^{
            
            if(queue.requestCount > 100){
                //并发请求超过100个,不再发送
                return;
            }
            
            //创建一个成功请求
            VolleyRequest *successRequest = [VolleyRequest requestWithMehtod:RequestMethodGet url:@"http://192.168.1.13/~17track/index.html" param:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *responseString =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                [[responseString should] equal:@"Hello World!\n"];
                finishCount++;
            }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    fail(@"不应该有返回");
            }];
            successRequest.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            [queue add:successRequest];
            sentCount++;
            dispatch_async(mainQueue, ^{
                if(!successRequest.isFinished){
                    [successRequest cancel];
                    finishCount++;
                }
            });
            
            
            //创建一个失败请求
            VolleyRequest *failureRequest = [VolleyRequest requestWithMehtod:RequestMethodGet url:@"http://192.168.1.13/~17track/notFound.html" param:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                fail(@"不应该有返回");
            }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                finishCount++;
            }];
            
            [queue add:failureRequest];
            sentCount++;
            
            dispatch_async(mainQueue, ^{
                if(!failureRequest.isFinished){
                    [failureRequest cancel];
                    finishCount++;
                }
            });
            
            
            if( finishTime < dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC))){
                dispatch_source_cancel(timer);
            }
            
        });
        
        // 启动定时器
        dispatch_resume(timer);
        
        
        
        
        BOOL delay = NO;
        //延时,让所有请求跑完
        [[theValue(delay) shouldNotEventuallyBeforeTimingOutAfter(timeout + postDelay)] beYes];
        [[theValue(queue.requestCount) should] equal:theValue(0)];
        [[theValue(sentCount) should] equal:theValue(finishCount)];
        NSLog(@"总请求数量:%ld",(long)sentCount);
    });
    
    
    
});

SPEC_END