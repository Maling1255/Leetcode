//
//  Person.m
//  testSDK
//
//  Created by maling  on 2020/4/21.
//  Copyright © 2020 maling . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "Son.h"
#import <YYModel.h>
@implementation Person

+ (UIImage *)showName
{
    NSLog(@"我的名字： 马领");
    
    NSDictionary *info = @{@"name" : @"maling_maling", @"age" : @"28"};
    
    Person *ps = [Person yy_modelWithDictionary:info];
    
    NSLog(@"转模型之后的，使用的YYModel: %@ -> %ld", ps.name, ps.age);

    
    [self showAge];
    
    [self son];
    
    NSBundle *resourceBundle = [NSBundle bundleForClass:[self class]];
    NSString *bundlePath = [resourceBundle pathForResource:@"SDK" ofType:@"bundle"];
    
    NSLog(@"::: %@   %@", resourceBundle, bundlePath);
    
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    UIImage *image = [UIImage imageNamed:@"black2.png" inBundle:bundle compatibleWithTraitCollection:nil];

    
    NSLog(@"SDK.image: %@, bundle: %@ \n----", image, bundle);
    
    NSString *path = [[resourceBundle pathForResource:@"SDK" ofType:@"bundle"] stringByAppendingString:@"black2.png"];
    image = [UIImage imageWithContentsOfFile:path];
    
    NSLog(@"SDK.image: %@, path: %@ \n\n\n\n----", image, path);
    
    
    return image;
}

+ (void)showAge
{
    NSLog(@"添加年龄：： 28， 嘿嘿");
}

+ (void)son
{
    NSLog(@"%s 222", __func__);
}

@end
