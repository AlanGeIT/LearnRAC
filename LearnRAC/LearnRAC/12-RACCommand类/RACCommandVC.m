//
//  RACCommandVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "RACCommandVC.h"

@interface RACCommandVC ()

@end

@implementation RACCommandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self command1];
//    [self command2];
//    [self command3];
    [self command4];
}

-(void)command4{
    // RACCommand 命令
    // 1.创建命令
    RACCommand * command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input = %@",input);
        // input:指令
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            // 发送数据
            [subscriber sendNext:@"执行完命令之后产生的数据"];

            // 发送完成
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
    // 监听事件有没有执行完毕
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if([x boolValue]){ // 正在执行!!
            NSLog(@"正在执行!!");
        }else{
            NSLog(@"已经结束咯 || 还没开始做!");
        }
    }];
    
    RACSignal * signal =  [command execute:@"执行!!"];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到数据了 = %@",x);
    }];
}

-(void)command3{
    
    // 创建多个信号
    RACSubject *signalOfSignal = [RACSubject subject];
    RACSubject *signal1        = [RACSubject subject];
    RACSubject *signal2        = [RACSubject subject];
    RACSubject *signal3        = [RACSubject subject];
    
    //订阅信号
//    [signalOfSignal subscribeNext:^(id  _Nullable x) {
//       [x subscribeNext:^(id  _Nullable x) {
//           NSLog(@"%@",x);
//       }];
//    }];
    
    //switchToLatest :最新的信号!!
    [signalOfSignal.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //发送信号
    [signalOfSignal sendNext:signal1];
    [signalOfSignal sendNext:signal2];
    [signalOfSignal sendNext:signal3];
    
    //发送数据
    [signal3 sendNext:@"3"];
    [signal2 sendNext:@"2"];
    [signal1 sendNext:@"1"];
}

/* ************** command2 ************** */
-(void)command2 {
    
    // RACCommand 命令
    //1.创建命令
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input = %@",input);
        //input:指令
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            //发送数据
            [subscriber sendNext:@"执行完命令之后产生的数据"];
            
            return nil;
        }];
    }];
    
    //订阅信号
    //executionSignals:信号源!!,发送信号的信号!
//    [command.executionSignals subscribeNext:^(RACSignal * x) {
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"%@",x);
//        }];
//        NSLog(@"%@",x);
//    }];
    
    //switchToLatest 获取最新发送的信号.
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"x = %@",x);
    }];
    
    //2.执行命令
    [command execute:@"输入的指令!!"];
}
/* ************** command1 ************** */
-(void)command1 {
    // 1.创建命令
    RACCommand * command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"input = %@",input);
        //input:指令
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            // 发送数据
            [subscriber sendNext:@"执行完命令之后产生的数据"];
            
            return nil;
        }];
    }];
    
    // 2.执行命令
    RACSignal *signal = [command execute:@"输入的指令!!"];
    
    // 3.订阅信号!
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"x = %@",x);
    }];
}

@end
