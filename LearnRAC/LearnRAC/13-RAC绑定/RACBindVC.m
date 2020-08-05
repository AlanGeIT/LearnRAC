//
//  RACBindVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/20.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "RACBindVC.h"
#import <RACReturnSignal.h>

@interface RACBindVC ()

@end

@implementation RACBindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bind];
}

- (void)bind {
    // bind 绑定!
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    // 2.绑定信号
    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
        return ^RACSignal * (id value, BOOL *stop){
            // block调用：只要源信号发送数据，就会调用bindBlock
            // block作用：处理原信号内容
            // value：源信号发送的内容
            NSLog(@"value = %@",value);
            // 返回信号，不能传nil，返回空信号:[RACSignal empty]
            return [RACReturnSignal return:value];
        };
    }];
    
    //3.订阅信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"绑定接收到 = %@",x);
    }];
    
    //4.发送
    [subject sendNext:@"发送原始的数据"];
}

@end
