//
//  RACFirstTryVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "RACFirstTryVC.h"


@interface RACFirstTryVC ()

@end

@implementation RACFirstTryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // RACSignal: 信号类，当我们有数据产生，创建一个信号!
    // 1.创建信号(冷信号!)
    // didSubscribe调用：只要一个信号被订阅就会调用!!
    // didSubscribe作用：利用subscriber发送数据!!
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 3.发送数据subscriber它来发送
        [subscriber sendNext:@"呵呵哈哈嘿嘿"];
        return nil;
    }];
    
    // 2.订阅信号(热信号!!)
    // nextBlock调用：只要订阅者发送数据就会调用!
    // nextBlock作用：处理数据,展示UI界面!
    [signal subscribeNext:^(id x) {
        // x:信号发送的内容!!
        NSLog(@"%@",x);
    }];
}

@end
