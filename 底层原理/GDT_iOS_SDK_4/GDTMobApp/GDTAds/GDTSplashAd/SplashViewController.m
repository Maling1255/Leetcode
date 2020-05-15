//
//  SplashViewContronller.m
//  GDTMobApp
//
//  Created by GaoChao on 15/8/21.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import "SplashViewController.h"
#import "GDTSplashAd.h"
#import "GDTAppDelegate.h"
#import "Aspects.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface SplashViewController () <GDTSplashAdDelegate>

@property (nonatomic, strong) GDTSplashAd *splashAd;
@property (nonatomic, strong) UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextField *placementIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *logoHeightTextField;
@property (weak, nonatomic) IBOutlet UILabel *logoDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (nonatomic, assign) BOOL isParallelLoad;

@end

@implementation SplashViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.logoHeightTextField.text = [NSString stringWithFormat:@"%@", @([[UIScreen mainScreen] bounds].size.height * 0.25)] ;
    self.logoDescLabel.text = [NSString stringWithFormat:@"底部logo高度上限：\n %@(屏幕高度) * 25%% = %@", @([[UIScreen mainScreen] bounds].size.height), @([[UIScreen mainScreen] bounds].size.height * 0.25)];
//    [self loadAd];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (IBAction)clickLoad:(id)sender {
    self.tipsLabel.text = nil;
    self.isParallelLoad = NO;
    [self loadAd];
}

- (IBAction)preloadContractSplashAd:(id)sender {
    self.isParallelLoad = NO;
    self.tipsLabel.text = nil;
    NSString *placementId = self.placementIdTextField.text.length > 0?self.placementIdTextField.text:self.placementIdTextField.placeholder;
    [GDTSplashAd preloadSplashOrderWithAppId:kGDTMobSDKAppId placementId:placementId];
}

- (void)loadAd
{
    NSString *placementId = self.placementIdTextField.text.length > 0?self.placementIdTextField.text:self.placementIdTextField.placeholder;
    
    self.splashAd = [[GDTSplashAd alloc] initWithAppId:kGDTMobSDKAppId
                                           placementId:placementId];
    self.splashAd.delegate = self;
    self.splashAd.fetchDelay = 5;
    
    UIImage *splashImage = [UIImage imageNamed:@"SplashNormal"];
    if (isIPhoneXSeries()) {
        splashImage = [UIImage imageNamed:@"SplashX"];
    } else if ([UIScreen mainScreen].bounds.size.height == 480) {
        splashImage = [UIImage imageNamed:@"SplashSmall"];
    }
    
    self.splashAd.backgroundImage = splashImage;
    self.splashAd.backgroundImage.accessibilityIdentifier = @"splash_ad";

    // 底部半瓶广告
    CGFloat logoHeight = [self.logoHeightTextField.text floatValue];
    if (logoHeight > 0 && logoHeight <= [[UIScreen mainScreen] bounds].size.height * 0.25) {
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, logoHeight)];
        self.bottomView.backgroundColor = [UIColor whiteColor];
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
        logo.accessibilityIdentifier = @"splash_logo";
        logo.frame = CGRectMake(0, 0, 311, 47);
        logo.center = self.bottomView.center;
        [self.bottomView addSubview:logo];
        
    } else {
        return;
    }

    UIWindow *fK = [[UIApplication sharedApplication] keyWindow];
    
    [self.splashAd loadAdAndShowInWindow:fK withBottomView:self.bottomView skipView:nil];
    
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"\n\n\n");
        UIView *view =  fK.subviews.firstObject;
        UIView *view1 = view.subviews.firstObject;
        
        for (UIView *v2 in view1.subviews) {
               NSLog(@">>>>>1 %@\n", v2);
           }
        
        
        UIView *view00 = view1.subviews.firstObject;
        
        for (UIView *v2 in view00.subviews) {
            NSLog(@">>>>>2 %@\n", v2);
        }
        
        
        UIImageView *imageView = view00.subviews.firstObject;
        
        for (UIView *v2 in imageView.subviews) {
            NSLog(@">>>>>2 %@\n", v2);
        }
        
        NSLog(@">>>>>imageView::::: %@", imageView);
        
        // handleSingleTapGesture
        for (UIGestureRecognizer *ges in imageView.gestureRecognizers) {
            NSLog(@">>>>>>>>>>>>>>>>  %@", ges);
        }
        
        [self runTests:imageView];
        
        
//        for (UIView *v0000 in view00.subviews) {
//
//               NSLog(@"\n!!!!!!!! %@\n", v0000);
//           }
//
//        UIView *view2 = view1.subviews.lastObject;
//        NSLog(@"\nview00: %@  \nview1: %@ \nview2: %@", view00, view1, view2);
//
//
        [imageView aspect_hookSelector:@selector(touchesBegan:withEvent:) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo> aspectInfo, NSDictionary *dict){

            NSLog(@"******************************测试点击拦截******************************");


        } error:NULL];
        
        
        [imageView performSelector:@selector(touchesBegan:withEvent:) withObject:nil];
        [imageView performSelector:@selector(touchesMoved:withEvent:) withObject:nil];
        [imageView performSelector:@selector(touchesEnded:withEvent:) withObject:nil];
        
    });
    
    self.tipsLabel.text = @"拉取中...";
}

- (void)handleSingleTapGesture:(UIGestureRecognizer *)rec
{
    NSLog(@"主动触发了：：：：：：：：：：：：：：：：：：：：：");
}


- (void)runTests:(UIView *)view
{
    unsigned int count;
    Method *methods = class_copyMethodList([view class], &count);
    for (int i = 0; i < count; i++)
    {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);

        NSLog(@"方法 名字 ==== %@",name);
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"KKKKK  %@", change);
}


/**
 typedef NS_ENUM(NSInteger, UIGestureRecognizerState) {//手势识别器状态(由UIGestureRecognizer识别器接收识别), 枚举类型
          UIGestureRecognizerStatePossible,   // 识别器还没有识别出它的手势(状态)(Possible)，但是可能计算触摸事件。这是默认状态
           
          UIGestureRecognizerStateBegan,      // 识别器已经接收识别为此手势(状态)的触摸(Began)。在下一轮run循环中，响应方法将会被调用。
          UIGestureRecognizerStateChanged,    // 识别器已经接收到触摸，并且识别为手势改变(Changed)。在下一轮run循环中，响应方法将会被调用。
          UIGestureRecognizerStateEnded,      // 识别器已经接收到触摸，并且识别为手势结束(Ended)。在下一轮run循环中，响应方法将会被调用并且识别器将会被重置到UIGestureRecognizerStatePossible状态。
          UIGestureRecognizerStateCancelled,  // 识别器已经接收到触摸，这种触摸导致手势取消(Cancelled)。在下一轮run循环中，响应方法将会被调用。识别器将会被重置到UIGestureRecognizerStatePossible状态。
           
          UIGestureRecognizerStateFailed,     // 识别器已经接收到一个触摸序列，不能识别为手势(Failed)。响应方法将不会被调用，并且识别器将会重置到UIGestureRecognizerStatePossible。
           
          // 离散手势 - 手势识别器识别一个离散事件，但是不会报告改变（例如，一个轻击）不会过度到Began和Changed状态，并且不会失败(fail)或者被取消(cancell)
          UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded // 识别器接收触摸，并且识别为此手势。在下一轮run循环中，响应方法将会被调用，并且识别将会重置至UIGestureRecognizerStatePossible。
      };
 
 for (UIView *v2 in view1.subviews) {
        
        NSLog(@"!!! %@", v2);
    }
 */

- (IBAction)parallelLoadAd:(id)sender {
    self.tipsLabel.text = nil;
    self.isParallelLoad = YES;
    
    NSString *placementId = self.placementIdTextField.text.length > 0?self.placementIdTextField.text:self.placementIdTextField.placeholder;
    self.splashAd = [[GDTSplashAd alloc] initWithAppId:kGDTMobSDKAppId
                                           placementId:placementId];
    self.splashAd.delegate = self;
    self.splashAd.fetchDelay = 5;
    UIImage *splashImage = [UIImage imageNamed:@"SplashNormal"];
    if (isIPhoneXSeries()) {
        splashImage = [UIImage imageNamed:@"SplashX"];
    } else if ([UIScreen mainScreen].bounds.size.height == 480) {
        splashImage = [UIImage imageNamed:@"SplashSmall"];
    }
    self.splashAd.backgroundImage = splashImage;
    self.splashAd.backgroundImage.accessibilityIdentifier = @"splash_ad";
    [self.splashAd loadAd];
    self.tipsLabel.text = @"拉取中...";
}

- (IBAction)parallelShowAd:(id)sender {
    if (self.isParallelLoad) {
        CGFloat logoHeight = [self.logoHeightTextField.text floatValue];
        if (logoHeight > 0 && logoHeight <= [[UIScreen mainScreen] bounds].size.height * 0.25) {
            self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, logoHeight)];
            self.bottomView.backgroundColor = [UIColor whiteColor];
            UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
            logo.accessibilityIdentifier = @"splash_logo";
            logo.frame = CGRectMake(0, 0, 311, 47);
            logo.center = self.bottomView.center;
            [self.bottomView addSubview:logo];
        } else {
            return;
        }
        
        UIWindow *fK = [[UIApplication sharedApplication] keyWindow];
        [self.splashAd showAdInWindow:fK withBottomView:self.bottomView skipView:nil];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
             UIView *view =  fK.subviews.firstObject;
             UIView *view1 = view.subviews.firstObject;
             
             
             for (UIView *view in view1.subviews) {
                 NSLog(@">>>>111 %@", view);
             }
             
             
             UIView *view00 = view1.subviews.firstObject;
            
             for (UIView *view in view00.subviews) {
                 NSLog(@">>>>2222 %@", view);
             }
             
             UIView *view000 = view00.subviews.firstObject;
            
            NSLog(@">>>>>>>>>>>>>>>  %@", view000);
            
//             for (UIView *view in view000.subviews) {
//                 NSLog(@">>>>333 %@", view);
//             }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                NSLog(@"sssss");

                [view000 performSelector:@selector(touchesBegan:withEvent:) withObject:nil];
                [view000 performSelector:@selector(touchesMoved:withEvent:) withObject:nil];
                [view000 performSelector:@selector(touchesEnded:withEvent:) withObject:nil];
            });
            
        });
        
        
//        UIImageView *imageView = view00.subviews.firstObject;
//
//        NSLog(@"ssss:: %@", imageView);
//
//

        
        
    }
}

#pragma mark - GDTSplashAdDelegate

- (void)splashAdDidLoad:(GDTSplashAd *)splashAd {
//    NSLog(@"%s", __func__);
    self.tipsLabel.text = @"广告拉取成功";
}

- (void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
{
//    NSLog(@"%s",__FUNCTION__);
    self.tipsLabel.text = @"广告展示成功";
}

- (void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
{
    NSLog(@"%s%@",__FUNCTION__,error);
    if (self.isParallelLoad) {
        self.tipsLabel.text = @"广告展示失败";
    }
    else {
        self.tipsLabel.text = @"广告拉取失败";
    }
}

- (void)splashAdExposured:(GDTSplashAd *)splashAd
{
//    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdClicked:(GDTSplashAd *)splashAd
{
//    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdApplicationWillEnterBackground:(GDTSplashAd *)splashAd
{
//    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdWillClosed:(GDTSplashAd *)splashAd
{
//    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdClosed:(GDTSplashAd *)splashAd
{
//    NSLog(@"%s",__FUNCTION__);
   self.splashAd = nil;
}

- (void)splashAdWillPresentFullScreenModal:(GDTSplashAd *)splashAd
{
//    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdDidPresentFullScreenModal:(GDTSplashAd *)splashAd
{
//     NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdWillDismissFullScreenModal:(GDTSplashAd *)splashAd
{
//     NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdDidDismissFullScreenModal:(GDTSplashAd *)splashAd
{
//    NSLog(@"%s",__FUNCTION__);
}




@end
