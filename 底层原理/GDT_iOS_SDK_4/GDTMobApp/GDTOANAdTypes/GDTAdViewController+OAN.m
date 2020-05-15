//
//  GDTAdViewController+Sample.m
//  GDTMobApp
//
//  Created by royqpwang on 2019/3/26.
//  Copyright © 2019 Tencent. All rights reserved.
//

#import "GDTAdViewController+OAN.h"

@implementation GDTAdViewController (OAN)

- (void)loadView
{
    [super loadView];
    self.demoArray = [@[
                        @[@"自渲染2.0", @"UnifiedNativeAdViewController"],
                        @[@"开屏广告", @"SplashViewController"],
                        @[@"激励视频广告", @"RewardVideoViewController"],
                        @[@"插屏2.0", @"UnifiedInterstitialViewController"],
                        @[@"获取IDFA", @(1)],
                        ] mutableCopy];
}

@end
