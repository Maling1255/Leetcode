//
//  Person.h
//  testSDK
//
//  Created by maling  on 2020/4/21.
//  Copyright © 2020 maling . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

+ (UIImage *)showName;

@end

NS_ASSUME_NONNULL_END
