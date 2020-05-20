//
//  main.m
//  BinaryTreePrinterOC
//
//  Created by MJ Lee on 2019/5/1.
//  Copyright © 2019 MJ Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJBinaryTrees.h"
#import "MJBinarySearchTree.h"
#import "Person.h"

void test1() {
//    int data[] = { 38, 18, 4, 69, 85, 71, 34, 36, 29, 100 };
    int data[] = {7, 4, 9, 2, 5, 8, };
    int len = sizeof(data) / sizeof(int);
    
    MJBinarySearchTree *bst = [MJBinarySearchTree tree];
    for (int i = 0; i < len; i++) {
        [bst add:@(data[i])];
    }
    
    [MJBinaryTrees println:bst];
    printf("---------------------------------\n");
//    [MJBinaryTrees println:bst style:MJPrintStyleInorder];
//    printf("---------------------------------\n");

    
    
}

void test2() {
    int data[] = { 38, 18, 4, 69, 85, 71, 34, 36, 29, 100 };
    int len = sizeof(data) / sizeof(int);
    
    MJBinarySearchTree *bst = [MJBinarySearchTree
                               treeWithComparatorBlock:^int(id  _Nonnull e1, id  _Nonnull e2) {
        return [e2 compare:e1];
    }];
    for (int i = 0; i < len; i++) {
        [bst add:@(data[i])];
    }
    
    [MJBinaryTrees println:bst];
    printf("---------------------------------\n");
    [MJBinaryTrees println:bst style:MJPrintStyleInorder];
    printf("---------------------------------\n");
}

void test3() {
    MJBinarySearchTree *bst = [MJBinarySearchTree tree];
    for (int i = 0; i < 20; i++) {
        [bst add:@((arc4random() % 666) + 1)];
    }
    
    [MJBinaryTrees println:bst];
    printf("---------------------------------\n");
    [MJBinaryTrees println:bst style:MJPrintStyleInorder];
    printf("---------------------------------\n");
    NSString *str = [MJBinaryTrees printString:bst];
    NSString *file = @"/Users/mj/Desktop/1.txt";
    [str writeToFile:file atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

void test4() {
    
    
    // 使用比较器
    MJBinarySearchTree *tree = [MJBinarySearchTree treeWithComparator:[Person new]];
    
    [tree add:[Person person:10]];
    [tree add:[Person person:20]];
    [tree add:[Person person:80]];
    [tree add:[Person person:40]];
    [tree add:[Person person:50]];
    
    
    [MJBinaryTrees println:tree];
    
}

void test5() {
    
    MJBinarySearchTree *tree = [MJBinarySearchTree treeWithComparator:[Person creatPerson:^int(Person * _Nonnull person1, Person * _Nonnull person2) {
        return  person2.age - person1.age;
    }]];
    
    [tree add:[Person person:10]];
    [tree add:[Person person:20]];
    [tree add:[Person person:80]];
    [tree add:[Person person:40]];
    [tree add:[Person person:50]];
    
    [MJBinaryTrees println:tree];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        test1();
//        test2();
//        test3();
        
//        test4();
        test5();
    }
    return 0;
}
