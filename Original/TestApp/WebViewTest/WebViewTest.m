//
//  WebViewTest.m
//  TestApp
//
//  Created by Halin Lee on 5/4/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import "WebViewTest.h"
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewTest ()<UIWebViewDelegate>


@end

@implementation WebViewTest

static UIWebView *webView;
static WebViewTest *delegate;

+ (void)test{
    webView = [[UIWebView alloc] init];
    delegate =  [[WebViewTest alloc] init];
    webView.delegate = delegate;

    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"translator" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
    NSLog(@"test");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *ctx = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    ctx[@"window"][@"alert"] = ^(JSValue *message) {
        NSLog(@"Alert %@",message.toString);
    };
    NSLog(@"webViewDidFinishLoad");
    [webView stringByEvaluatingJavaScriptFromString:@"javascript:YQTranslate();"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error);
}
@end
