//
//  GDTTangramAdViewController.m
//  GDTTangramSample
//
//  Created by yilerwang on 2019/9/5.
//  Copyright © 2019 Tencent. All rights reserved.
//

#import "GDTTangramAdViewController.h"
#import "GDTUnifiedNativeAdDataObject.h"
#import "GDTTangramDeviceManager.h"
#import "GDTTangramUnifiedNativeAdService.h"
#import "GDTTangramClickManager.h"
#import "GDTUnifiedNativeAdDataObject+XQ.h"
#import "GDTLoadAdParams.h"
#import "GDTTGOuterWKWebviewViewController.h"

@interface GDTTangramAdViewController ()
@property (strong, nonatomic) IBOutlet UITextField *placementId;
@property (strong, nonatomic) IBOutlet UITextField *appId;
@property (strong, nonatomic) IBOutlet UITextView *adcontent;
@property (nonatomic, strong) GDTUnifiedNativeAdDataObject *adData;
@end

@implementation GDTTangramAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.placementId.text = @"6030681077562763";//3050349752532954";//@"9040366827427453";//@"2000566593234845";//2000566593234845是容器自渲染广告位，6030681077562763为普通自渲染广告位
    self.appId.text = @"1105344611";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loadAd:(id)sender {
    GDTLoadAdParams *loadAdParams = [[GDTLoadAdParams alloc] init];
    loadAdParams.dictionary = [NSDictionary dictionaryWithObjects:@[@(88888), @(9999)] forKeys:@[@"puin", @"atid"]];
    
    [GDTTangramUnifiedNativeAdService fetchTangramAdDataWithPlacementId:self.placementId.text
                                                                  appId:self.appId.text
                                                                  count:1
                                                            loadAdParams:loadAdParams
                                                                success:^(NSArray<GDTUnifiedNativeAdDataObject *> * _Nonnull adArray) {
                                                                    
                                                                    for(GDTUnifiedNativeAdDataObject *adData in adArray){
                                                                        self.adData = adData;
                                                                        NSString *adText = [NSString stringWithFormat:@"title:%@\n\n desc:%@\n\n imageUrl(视频封面）:%@\n\n iconUrl:%@ \n\n imageWidth:%d\n\n imageHeight:%d\n\n videoUrl：%@\n\n videoDuration:%lf\n\n  adId:%@", adData.title, adData.desc, adData.imageUrl, adData.iconUrl, adData.imageWidth, adData.imageHeight, adData.videoUrl, adData.duration, adData.adId ];
                                                                        
                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                            self.adcontent.text = adText;
                                                                        });
                                                                        
                                                                    }
                                                                }
                                                                 notice:^(NSInteger ret, id responseObject) {
                                                                     
                                                                 } failure:^(NSError *error) {
                                                                     
                                                                 }];
}
- (IBAction)clickhandler:(id)sender {
     [GDTTangramClickManager handleTangramClick:self.adData viewController:self];
}
- (IBAction)getDeviceInfo:(id)sender {
    NSMutableDictionary *deviceInfo = [NSMutableDictionary dictionary];
    deviceInfo = [GDTTangramDeviceManager getTangramDeviceInfo];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:deviceInfo options:NSJSONWritingPrettyPrinted error:&error];
    self.adcontent.text = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (IBAction)getQAID:(id)sender {
    self.adcontent.text =[GDTTangramDeviceManager getQAID];
}
- (IBAction)setDeviceInfo:(id)sender {
    [GDTTangramDeviceManager setDeviceInfoWith:self.adcontent.text];
    self.adcontent.text = @"设置完毕";
}

@end
