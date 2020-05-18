//
//  Person.h
//  BinaryTreePrinterOC
//
//  Created by maling  on 2020/5/15.
//  Copyright © 2020 MJ Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJBinarySearchTree.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject <MJBSTComparator>

@property (nonatomic, assign) int age;


+ (instancetype)person:(int)age;

+ (instancetype)creatPerson:(int(^)(Person *person1, Person *person2))comparatorblock;

@end

NS_ASSUME_NONNULL_END
