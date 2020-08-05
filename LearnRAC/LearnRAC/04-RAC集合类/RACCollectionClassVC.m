//
//  RACCollectionClassVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "RACCollectionClassVC.h"
#import "KFC.h"

@interface RACCollectionClassVC ()

@end

@implementation RACCollectionClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // RACSequence:用于代替NSArray,NSDictionary,可以使用快速的遍历
    // 最常见的应用场景:字典转模型!!
    
//    [self demo1]; // 元组
//    [self demo2]; // 遍历数组
//    [self demo3]; // 字典
    [self demo4]; // 解析plist文件
}

// 解析plist文件
-(void)demo4 {
    
    // 解析plist文件
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"kfc.plist" ofType:nil];
    NSArray * dictArr = [NSArray arrayWithContentsOfFile:filePath];

//    NSMutableArray * arr = [NSMutableArray array];
//    [dictArr.rac_sequence.signal subscribeNext:^(NSDictionary * x) {
//        KFC * kfc = [KFC kfcWithDict:x];
//        [arr addObject:kfc];
//    }];
    
    // 更加爽的用法
    // 会将一个集合中的所有元素都映射成一个新的对象!
    NSArray * arr = [[dictArr.rac_sequence map:^id _Nullable(NSDictionary * value) {
        //返回模型!!
        return  [KFC kfcWithDict:value];
    }] array];
    NSLog(@"%@",arr);
}

// 字典
-(void)demo3 {
    // 字典
    NSDictionary * dict = @{@"name":@"Alan",@"age":@"18"};
    
    // 字典转集合
    [dict.rac_sequence.signal subscribeNext:^(RACTuple* x) {
//        NSString * key = x[0];
//        NSString * value = x[1];
//        NSLog(@"%@ : %@",key,value);
        
        // RACTupleUnpack:用来解析元祖
        // 宏里面的参数,传需要解析出来的变量名称
        // = 右边,放需要解析的元祖
        RACTupleUnpack(NSString * key,NSString * value) = x;
        NSLog(@"%@ : %@",key,value);
    }];
}

// 遍历数组
-(void)demo2 {
    
    // RACSequence:用于代替NSArray,NSDictionary,可以使用快速的遍历
    // 最常见的应用场景:字典转模型!!
    
    // 数组
    NSArray * arr = @[@"abc",@"bbb",@123];
    
    // RAC集合
//    RACSequence *requence = [arr rac_sequence];
//    // 遍历
//    RACSignal *signal = [requence signal];
//    // 订阅信号
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

// 元组
-(void)demo1 {
    // 元组
    RACTuple * tuple = [RACTuple tupleWithObjectsFromArray:@[@"aaa",@"bbb",@123]];
    NSString * str = tuple[0];
    NSLog(@"%@",str);
}

@end
