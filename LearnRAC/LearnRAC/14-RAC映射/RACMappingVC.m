//
//  RACMappingVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/20.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "RACMappingVC.h"
#import <RACReturnSignal.h>

@interface RACMappingVC ()

@end

@implementation RACMappingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self flattenMapDemo1];
//    [self mapDemo1];
    [self flattenMapDemo2];
}

-(void)flattenMapDemo2 {
    // flattenMap 一般用于信号中的信号
    RACSubject *signalOfSignal = [RACSubject subject];
    RACSubject *signal         = [RACSubject subject];

    // 订阅信号
//    [signalOfSignal subscribeNext:^(RACSignal * x) {
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"%@",x);
//        }];
//    }];

//    [signalOfSignal.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];

    [[signalOfSignal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];

    // 发送信号
    [signalOfSignal sendNext:signal];// 信号发送信号
    [signal sendNext:@"123"];
}

-(void)mapDemo1 {
    // 创建信号
    RACSubject * subject = [RACSubject subject];
    
    // 绑定
    [[subject map:^id _Nullable(id  _Nullable value) {
        // 返回的数据就是需要处理的数据
        return [NSString stringWithFormat:@"处理数据%@",value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    // 发送数据
    [subject sendNext:@"123"];
    [subject sendNext:@"321"];
}

-(void)flattenMapDemo1 {
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    
    //绑定信号
    RACSignal *bindSignal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        // block：只要源信号发送内容就会调用
        // value：就是源信号发送的内容
        value = [NSString stringWithFormat:@"处理数据:%@",value];
        
        // 返回信号用来包装修改过的内容
        return [RACReturnSignal return:value];
    }];
    
    // 订阅绑定信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"x = %@",x);
    }];
    
    // 发送数据
    [subject sendNext:@"123"];
}

@end
