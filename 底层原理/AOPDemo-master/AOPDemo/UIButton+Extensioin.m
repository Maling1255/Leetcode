//
//  UIButton+Extensioin.m
//  AOPDemo
//
//  Created by maling  on 2020/4/10.
//  Copyright © 2020 xtcel.com Inc. All rights reserved.
//

#import "UIButton+Extensioin.h"

#import <objc/runtime.h>

static NSString * sss = @"sssss";

@implementation UIButton (Extensioin)

- (NSDictionary *)info
{
    return objc_getAssociatedObject(self, &sss);
}

- (void)setInfo:(NSDictionary *)info
{
    objc_setAssociatedObject(self, &sss, info, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
