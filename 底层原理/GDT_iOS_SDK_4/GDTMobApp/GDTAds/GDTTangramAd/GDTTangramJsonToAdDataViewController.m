//
//  GDTTangramJsonToAdDataViewController.m
//  GDTTangramSample
//
//  Created by yilerwang on 2019/9/6.
//  Copyright © 2019 Tencent. All rights reserved.
//

#import "GDTTangramJsonToAdDataViewController.h"
#import "GDTTangramUtils.h"
#import "GDTTangramClickManager.h"
#import "UnifiedNativeAdFeedVideoCell.h"
#import "GDTTangramUtils.h"
@interface GDTTangramJsonToAdDataViewController ()
@property (strong, nonatomic) IBOutlet UITextView *jsonStr;
@property (strong, nonatomic) IBOutlet UITextView *errorInfo;
@property (strong, nonatomic) IBOutlet UIButton *preloadBtn;

@property (nonatomic, strong) GDTUnifiedNativeAdDataObject *adData;
@end

@implementation GDTTangramJsonToAdDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)jsonToAdDataAndJump:(id)sender {
    self.adData = [GDTTangramUtils nativeAdjsonStrToAdData:self.jsonStr.text];
    if(!self.adData) {
        self.errorInfo.text = @"json数据不合法，转换失败";
        return;
    }
    self.errorInfo.text = @"json数据转换GDTUnifiedNativeAdDataObject成功，开始跳转";
    
    [GDTTangramClickManager handleTangramClick:self.adData viewController:self];
}
- (IBAction)preloadAppstore:(id)sender {
    self.adData = [GDTTangramUtils nativeAdjsonStrToAdData:self.jsonStr.text];
    if(!self.adData) {
        self.errorInfo.text = @"json数据不合法，预加载失败";
        return;
    }
    if([GDTTangramUtils preLoadStoreProductViewControllerWithAdData:self.adData]){
        self.errorInfo.text = @"Appstore预加载成功";
    }else{
        self.errorInfo.text = @"Appstore预加载失败";
    }
    
}
- (IBAction)exposureAd:(id)sender {
    self.adData = [GDTTangramUtils nativeAdjsonStrToAdData:self.jsonStr.text];
    if(!self.adData) {
        self.errorInfo.text = @"json数据不合法，曝光失败";
        return;
    }
    [GDTTangramUtils exposureAdWithAdData:self.adData success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.errorInfo.text = @"曝光上报成功";
        });
    } failure:^(NSError * _Nonnull error) {
        NSError *e = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.errorInfo.text = @"曝光上报失败";
        });
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/*自渲染2.0图文广告json格式
 {"sdk_proto_type":1,
 "cl":"152255719",
 "img":"https://pgdt.ugdtimg.com/gdt/0/DAAfWMmAUAALQABiBdU3QeDQYpRb4P.jpg/0?ck=f1d5b17ba427cd2379af1d36e9b31884",
 "img_s":"",
 "img2":"https://pgdt.ugdtimg.com/gdt/0/DAAfWMmAEsAEsAAJBc7NrwB8_HpfWh.png/0?ck=0231e450cd31bd847cf8ef552df47c97",
 "video":"",
 "price":"-",
 "reltarget":0,
 "last_modify_time":1565866796,
 "txt":"携程旅行",
 "desc":"旅游订酒店没特色？别选了来这家，马上出发体验~",
 "button_txt":"",
 "customized_invoke_url":"ctrip://wireless/h5?guidtype=base&type=2&url=aHR0cHM6Ly9tLmN0cmlwLmNvbS93ZWJhcHAveW91L2xpdmVzdHJlYW0vcGFpcGFpL2RldGFpbC5odG1sP0lkPTUxMjU4MDQmZnJvbWNybj0xJmF1dG9hd2FrZW49Y2xvc2UmcG9wdXA9Y2xvc2UmaXNoaWRlaGVhZGVyPXRydWUmaXNIaWRlTmF2QmFyPVlFUyZhbGxpYW5jZWlkPTg2NDgzNCZzaWQ9MTQzMzA4MCZvdWlkPUdkdF96eXpfbHZwYWk=&allianceid=864834&ouid=Gdt_zyz_lvpai&needguid=1&sid=1433080",
 "corporation_name":"上海华程西南国际旅行社有限公司",
 "ad_industry_id":706,
 "edid":"cc992d9ecb56d0feae01f9ad9213ebc1",
 "rl":"https://sc.gdt.qq.com/gdt_mclick.fcg?viewid=IdEMvTJI4yqM9H!yFakt6jVtyC9FNNkqaEJwdr6Bu6WaV_iK7RKdX7LAvgU0ADEonhGqVB9mds6G74kWonJlCKcs!NCZ1Wu8zJukJNXSYfijNUvnY50Fn0N7vSndDUmJ2EIKsxfPrFFy_RPS8u6zugus4!sI85XfL7DdYKmFxSY023vIFSkeH0FaHmLg!N4p7nosRPUks9IGrRsFpR2Ok8vbizkAbp9lJhUqev!mAIkVZy8BDHjSN3StLzSZz!sBIOgwCdN10kUglDPUsMupcQ&jtype=0&i=1&os=1&ase=1&clklpp=__CLICK_LPP__&cdnxj=1&xp=3",
 "targetid":"379395415",
 "apurl":"https://v2.gdt.qq.com/gdt_stats.fcg?viewid=IdEMvTJI4yqM9H!yFakt6jVtyC9FNNkqaEJwdr6Bu6WaV_iK7RKdX7LAvgU0ADEonhGqVB9mds6G74kWonJlCKcs!NCZ1Wu8zJukJNXSYfijNUvnY50Fn0N7vSndDUmJ2EIKsxfPrFFy_RPS8u6zugus4!sI85XfL7DdYKmFxSY023vIFSkeH0FaHmLg!N4p7nosRPUks9IGrRsFpR2Ok8vbizkAbp9lJhUqev!mAIkVZy8BDHjSN3StLzSZz!sBIOgwCdN10kUglDPUsMupcQ&i=1&os=1&xp=3",
 "apptrace":"",
 "appclick":"",
 "traceid":"ks4t4j2cfvcvy01",
 "netlog_traceid":"ks4t4j2cfvcvy01",
 "linktype":0,
 "productid":"379395415",
 "producttype":19,
 "inner_adshowtype":0,
 "imagetype":2,
 "negative_feedback_url":"https://nc.gdt.qq.com/gdt_report.fcg?viewid=IdEMvTJI4yqM9H!yFakt6jVtyC9FNNkqaEJwdr6Bu6WaV_iK7RKdX7LAvgU0ADEonhGqVB9mds6G74kWonJlCKcs!NCZ1Wu8zJukJNXSYfijNUvnY50Fn0N7vSndDUmJ2EIKsxfPrFFy_RPS8u6zugus4!sI85XfL7DdYKmFxSY023vIFSkeH0FaHmLg!N4p7nosRPUks9IGrRsFpR2Ok8vbizkAbp9lJhUqev!mAIkVZy8BDHjSN3StLzSZz!sBIOgwCdN10kUglDPUsMupcQ&acttype=__ACT_TYPE__&s=15",
 "buyingtype":1,
 "real_adtype":1,
 "domain":"itunes.apple.com",
 "appcategoryname":"",
 "acttype":1,
 "pic_width":1280,
 "pic_height":720,
 "ext":{"alist":{"2022":{"aid":"ctrip.com",
 "atype":2025
 },"2025":{"aid":{"iconurl":"https://pgdt.ugdtimg.com/gdt/0/DAAfWMmAA8AA8AACBdU6eAChLdeqSg.jpg/0?ck=cb9f29cc08f5bbd0816625b9b24516df"
 }}},"appclass":0,
 "appclass3":0,
 "appid":"379395415",
 "appname":"携程旅行",
 "appscore":8,
 "appstoreurl":"https://itunes.apple.com/cn/app/%E6%90%BA%E7%A8%8B%E6%97%85%E8%A1%8C-%E8%AE%A2%E9%85%92%E5%BA%97%E6%9C%BA%E7%A5%A8%E7%81%AB%E8%BD%A6%E7%A5%A8/id379395415?uo=4&mt=8",
 "appver":"8.9.0",
 "creative_finger_print_productid":"0",
 "desttype":11,
 "mappid":379395415,
 "packagename":"ctrip.com",
 "quality_productid":"1244666978",
 "qzoneliked":0
 },"advertiser_id":8217382,
 "cfg":{"pt":11
 }}
 */

/*自渲染2.0视频广告json格式：
 {"sdk_proto_type":1,
 "cl":"163107343",
 "img":"https://pgdt.ugdtimg.com/gdt/0/DAAYVTIAUAALQACABdcOyyC3HogsQ5.jpg/0?ck=e40c204131532caa20a965f977edd6f6",
 "img_s":"",
 "img2":"https://pgdt.ugdtimg.com/gdt/0/EAAYVTIABQABQAAAAj4BdTSbaC_6Xc5e8.jpg/0?ck=1ef867162afef08cfa43ce4332f201b4",
 "video":"https://adsmind.apdcdn.tc.qq.com/adsmind.tc.qq.com/1050_000001003spu00zk0k00wospxjzgm03z.f32.mp4?vkey=2E40430F85AB3923207961E585E3E2C964E364607E024F916E438C68A96468DA69311A768A5BC6A7D9280B4D211575C56D5B017663A4B329735F4EB539AFB17730D8B3197C91A79D30F68BA55E45C78758CD686A9E02592E",
 "price":"-",
 "reltarget":0,
 "last_modify_time":1568015086,
 "txt":"途虎养车",
 "desc":"汽车氛围灯一夜爆红，万千司机争相安装，几十块钱让爱车大变样",
 "button_txt":"",
 "corporation_name":"上海阑途信息技术有限公司",
 "ad_industry_id":4107,
 "corporate_image_name":"途虎养车",
 "corporate_logo":"https://pgdt.ugdtimg.com/gdt/0/EAAYVTIABQABQAAAAj4BdTSbaC_6Xc5e8.jpg/0?ck=1ef867162afef08cfa43ce4332f201b4",
 "edid":"77a3ed8282777261d01d0de2c48aea16",
 "rl":"https://c2.gdt.qq.com/gdt_mclick.fcg?viewid=R3WSlnFZ1IlYn7zXSkn6DR9Ff2QTD_B!9!PhR11Rj5MjskmTlI5WZVaHcncNTWy_ZOQNNKvzPFaMjXPX0lqJQ2QTxuetY4Sx_talzsOGSYw9gjZ2Ng6S2KXGcoN0ihoaUOcMU!Q8IAB5aqsjWb_NnP4caNssjiH1NzVxQlJCKTvq9!HGfq6!jsR4jDBDGnnpB4idBBF3V7zI_GMD1mFEULdd95t0uKa655kzYOo0VUQVZy8BDHjSN3StLzSZz!sBIOgwCdN10kUglDPUsMupcQ&jtype=0&i=1&os=1&ase=1&clklpp=__CLICK_LPP__&cdnxj=1&xp=3",
 "begintime":1567958400,
 "targetid":"943708006",
 "apurl":"https://sv.gdt.qq.com/gdt_stats.fcg?viewid=R3WSlnFZ1IlYn7zXSkn6DR9Ff2QTD_B!9!PhR11Rj5MjskmTlI5WZVaHcncNTWy_ZOQNNKvzPFaMjXPX0lqJQ2QTxuetY4Sx_talzsOGSYw9gjZ2Ng6S2KXGcoN0ihoaUOcMU!Q8IAB5aqsjWb_NnP4caNssjiH1NzVxQlJCKTvq9!HGfq6!jsR4jDBDGnnpB4idBBF3V7zI_GMD1mFEULdd95t0uKa655kzYOo0VUQVZy8BDHjSN3StLzSZz!sBIOgwCdN10kUglDPUsMupcQ&i=1&os=1&xp=3",
 "apptrace":"",
 "appclick":"",
 "traceid":"taetx3dafajyi01",
 "netlog_traceid":"taetx3dafajyi01",
 "linktype":0,
 "productid":"943708006",
 "producttype":19,
 "inner_adshowtype":3,
 "imagetype":2,
 "pattern_type":3,
 "negative_feedback_url":"https://nc.gdt.qq.com/gdt_report.fcg?viewid=R3WSlnFZ1IlYn7zXSkn6DR9Ff2QTD_B!9!PhR11Rj5MjskmTlI5WZVaHcncNTWy_ZOQNNKvzPFaMjXPX0lqJQ2QTxuetY4Sx_talzsOGSYw9gjZ2Ng6S2KXGcoN0ihoaUOcMU!Q8IAB5aqsjWb_NnP4caNssjiH1NzVxQlJCKTvq9!HGfq6!jsR4jDBDGnnpB4idBBF3V7zI_GMD1mFEULdd95t0uKa655kzYOo0VUQVZy8BDHjSN3StLzSZz!sBIOgwCdN10kUglDPUsMupcQ&acttype=__ACT_TYPE__&s=15",
 "buyingtype":1,
 "video_duration":59,
 "video_file_size":7781376,
 "ecpm":877,
 "real_adtype":1,
 "domain":"itunes.apple.com",
 "appcategoryname":"",
 "acttype":1,
 "pic_width":1280,
 "pic_height":720,
 "ext":{"alist":{"2022":{"aid":"tuhu.cn.main","atype":2025},"2025":{"aid":{"iconurl":"https://pgdt.ugdtimg.com/gdt/0/EAAYVTIABQABQAAAAj4BdTSbaC_6Xc5e8.jpg/0?ck=1ef867162afef08cfa43ce4332f201b4"}}},"appclass":0,"appclass3":0,"appid":"943708006","appname":"途虎养车","appscore":10,"appstoreurl":"https://itunes.apple.com/cn/app/%E9%80%94%E8%99%8E%E5%85%BB%E8%BD%A6-%E4%B8%93%E4%B8%9A%E6%B1%BD%E8%BD%A6%E4%BF%9D%E5%85%BB%E5%B9%B3%E5%8F%B0/id943708006?uo=4&mt=8","appver":"5.6.5","creative_finger_print_productid":"0","desttype":11,"mappid":943708006,"packagename":"tuhu.cn.main","quality_productid":"2577335544","qzoneliked":0}
 ,
 "advertiser_id":6378696,
 "cfg":{
 "pt":16}
 }
 */
@end
