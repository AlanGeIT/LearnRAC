//
//  RACMulticastConnectionVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

// 11-RAC连接类 RACMulticastConnection

#import "RACMulticastConnectionVC.h"

@interface RACMulticastConnectionVC ()

@end

@implementation RACMulticastConnectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self RACMulticastConnectionDemo];
}

-(void)RACMulticastConnectionDemo{
    
    // 不管订阅多少次信号，就只会请求一次数据
    // RACMulticastConnection:必须要有信号
    
    // 1.创建信号
    RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 发送网络请求
        NSLog(@"发送请求");
        // 发送数据
        [subscriber sendNext:@"请求到的数据"];
        
        return nil;
    }];
    
    // 2.将信号转成连接类!!
    RACMulticastConnection *connection = [signal publish];
    
    // 3.订阅 连接类 的信号
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"A处在处理数据%@",x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"B处在处理数据%@",x);
    }];
    
    // 4.连接
    [connection connect];
}

@end
