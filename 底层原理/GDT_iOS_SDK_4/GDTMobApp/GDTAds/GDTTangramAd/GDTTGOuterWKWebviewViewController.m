//
//  GDTTGOuterWKWebviewViewController.m
//  GDTMobApp
//
//  Created by yilerwang on 2019/10/30.
//  Copyright © 2019 Tencent. All rights reserved.
//

#import "GDTTGOuterWKWebviewViewController.h"
#import <WebKit/WebKit.h>
#import "GDTTangramUtils.h"
#import "GDTTGJsBridgeProcessor.h"
#import "GDTSDKDefines.h"
#import "GDTAppDelegate.h"

@interface GDTTGOuterWKWebviewViewController ()<WKNavigationDelegate, GDTTGJsBridgeDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) GDTTGJsBridgeProcessor *processor;
@end

@implementation GDTTGOuterWKWebviewViewController

- (void)loadView {

    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    webConfiguration.dataDetectorTypes = WKDataDetectorTypePhoneNumber;
    
    WKPreferences *preference = [[WKPreferences alloc]init];
    preference.javaScriptEnabled = YES;
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    webConfiguration.preferences = preference;
    
    _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:webConfiguration];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.allowsBackForwardNavigationGestures = YES;
    
    //1.注入SDK需要的UA,注意：sdk会在初始化设置系统的UA，但如果app也会设置自己webview的UA，app设置ua的时候需要在原有的ua后面加上“ iOS GDTTangramMobSDK/4.10.23 GDTMobSDK/4.10.23”
    _webView.customUserAgent = [GDTTangramUtils getTangramUserAgent];//注意：这里是覆盖，app需要在设置ua的地方加上[GDTTangramUtils getTangramUserAgent]返回的字符串

    _webView.navigationDelegate = self;
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //2.用广告分配的appid初始化SDK
    _processor = [[GDTTGJsBridgeProcessor alloc] initWithAppId:kGDTMobSDKAppId delegate:self viewcontroller:self];
    self.title = @"外部webviewDemo";
    [self setupUI];
}


#pragma mark - Private Functions

- (void)setupUI {
    //测试页面
    //NSString *urlStr = @"http://h5.gdt.qq.com/testProxy/tangramTestPage/new/index.html?config=config39";
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSURL *url = navigationAction.request.URL;

    if ([url.absoluteString hasPrefix:@"http"]) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }else if ([url.absoluteString hasPrefix:GDTTangramSchemePrefix])
    {
        //3.处理SDK的scheme
        [_processor handleRequest:url];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyCancel);
    }
        
}
//4.SDK处理结果回调
- (void)gdt_handler_callback_with_js:(NSString *)js{
    NSLog(@"gdt_handler_callback_with_js=%@",js);
    dispatch_async(dispatch_get_main_queue(), ^{
         [_webView evaluateJavaScript:js completionHandler:nil];
    });
}
@end
