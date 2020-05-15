//
//  GDTTGOuterWebviewDemoViewController.m
//  GDTMobApp
//
//  Created by yilerwang on 2019/10/31.
//  Copyright © 2019 Tencent. All rights reserved.
//

#import "GDTTGOuterWebviewDemoViewController.h"
#import "GDTTGOuterWKWebviewViewController.h"
@interface GDTTGOuterWebviewDemoViewController ()
@property (strong, nonatomic) IBOutlet UITextField *urlText;

@end

@implementation GDTTGOuterWebviewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)openOuterWebview:(id)sender {
    GDTTGOuterWKWebviewViewController *webviewDemoVC = [[GDTTGOuterWKWebviewViewController new] init];
    webviewDemoVC.urlStr = self.urlText.text;
    [self.navigationController pushViewController:webviewDemoVC animated:YES];
}

@end
