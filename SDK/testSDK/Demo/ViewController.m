//
//  ViewController.m
//  Demo
//
//  Created by maling  on 2020/4/21.
//  Copyright © 2020 maling . All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"maling");
    
   UIImage *image11 = [Person showName];
    
    NSLog(@"image11: %@", image11);
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(120, 200, 50, 50)];
    imageview.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:imageview];
    
//    [NSBundle bu]
    
    
        NSBundle *resourceBundle = [NSBundle bundleForClass:[Person class]]; // 获取类所在的bundle
    
       NSLog(@"resourceBundle: %@  \n %@", resourceBundle, [NSBundle mainBundle]);
    
    NSString *imgPath = [[resourceBundle bundlePath] stringByAppendingString:@"/testSDK.framework/SDK.bundle/black.png"];

    NSLog(@"imgPath: %@", imgPath);
    
   UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    
    NSLog(@"image: %@", image);
    imageview.image = image;
    
//    NSString *bundlePath = [resourceBundle pathForResource:@"SDK" ofType:@"bundle"]; // 获取资源bundle路径
//       NSLog(@"path2: %@", bundlePath);
//
//
//
//    NSString *bundlePath1 = [[NSBundle mainBundle] pathForResource:@"SDK" ofType:@"bundle"];
//    NSString *imgPath= [bundlePath1 stringByAppendingPathComponent:@"black2.png"];
//
//    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
//
//    NSLog(@"path3: %@    %@", imgPath, image);
    
    
    
    
        // 方式1 直接拼路径
    //    NSString *imagePath = [bundlePath stringByAppendingPathComponent:@"user.jpg"];
    //    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        // 方式2 通过获取bundle来操作
    //    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    //    NSString *imagePath = [bundle pathForResource:@"user.jpg" ofType:nil];
    //    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        // 方式3 通过传入bundle来获取数据
//        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
//        image = [UIImage imageNamed:@"black2" inBundle:resourceBundle compatibleWithTraitCollection:nil];
////
//        imageview.image = image;
    
    
    
    
}


@end
