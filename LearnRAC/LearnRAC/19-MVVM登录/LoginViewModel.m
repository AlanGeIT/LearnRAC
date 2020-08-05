//
//  LoginViewModel.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/20.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

-(instancetype)init{
    if (self = [super init]) {
        //初始化
        [self setUP];
    }
    return self;
}

-(void)setUP{
    
    // 处理登录点击的信号
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, pwd)] reduce:^id _Nullable(NSString * account,NSString * pwd){
        return @(account.length && pwd.length);
    }];
    
    // 处理登录的命令
    // 创建命令
    _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // 处理事件密码加密
        NSLog(@"拿到%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送请求&&获取登录结果!!
            [subscriber sendNext:@"请求登录的数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // 获取命令中信号源
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    // 监听命令执行过程!!
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        
        if ([x boolValue]) {
            //正在执行
            NSLog(@"显示菊花!!");
        }else{
            NSLog(@"干掉菊花!!");
        }
        
    }];
}

@end
