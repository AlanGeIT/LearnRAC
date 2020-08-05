//
//  RACDisposableVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "RACDisposableVC.h"

@interface RACDisposableVC ()

@property(nonatomic,strong)id<RACSubscriber> subscriber;

@end

@implementation RACDisposableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建信号(冷信号!)
     RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
         //3.发送数据subscriber它来发送
         [subscriber sendNext:@"发送数据"];
         self->_subscriber = subscriber;
         
         return [RACDisposable disposableWithBlock:^{
             // 只要信号取消订阅就会来这里
             // 清空资源!!
             NSLog(@"清空资源!!");
         }];
     }];
     
     
     //2.订阅信号(热信号!!)
    RACDisposable * disposable =  [signal subscribeNext:^(id x) {
         //x:信号发送的内容!!
         NSLog(@"%@",x);
     }];
     
     // 默认一个信号发送数据完毕就会主动取消订阅
     // 只要订阅者在,就不会自动取消订阅
     // 手动取消订阅
     [disposable dispose];
}



@end
