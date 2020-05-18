//
//  Person.m
//  BinaryTreePrinterOC
//
//  Created by maling  on 2020/5/15.
//  Copyright © 2020 MJ Lee. All rights reserved.
//

#import "Person.h"

@interface Person ()

@property (nonatomic, copy) int(^comparatorblock)(Person *person1, Person *person2);

@end

@implementation Person

- (int)compare:(nonnull id)e1 another:(nonnull id)e2 {
    
    Person *person1 = (Person *)e1;
    Person *person2 = (Person *)e2;
    
    return self.comparatorblock(person1, person2);
}

+ (instancetype)person:(int)age
{
    Person *person = [Person new];
    
    person.age = age;
    
    return person;
}

+ (instancetype)creatPerson:(int(^)(Person *person1, Person *person2))comparatorblock
{
    Person *p = [Person new];
    p.comparatorblock = comparatorblock;
    return p;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %p: %d ", [self class], self, _age];
}

@end
