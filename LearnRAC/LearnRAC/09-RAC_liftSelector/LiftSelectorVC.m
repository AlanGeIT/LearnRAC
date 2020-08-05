//
//  LiftSelectorVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "LiftSelectorVC.h"


@interface LiftSelectorVC ()


@end

@implementation LiftSelectorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self rac_liftDemo];
}

-(void)rac_liftDemo {
    //请求1
    RACSignal * signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%@",[NSThread currentThread]);
        //发送请求
        NSLog(@"请求网络数据 1");
        //发送数据
        [subscriber sendNext:@"数据1 来了"];
        
        return nil;
    }];
    
    //请求2
    RACSignal * signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%@",[NSThread currentThread]);
        //发送请求
        NSLog(@"请求网络数据 2");
        //发送数据
        [subscriber sendNext:@"数据2 来了"];
        
        return nil;
    }];
    
    // 数组:存放信号
    // 当数组中的所有信号都发送了数据，才会执行Selector
    // 方法的参数: 必须和数组的信号一一对应!!
    // 方法的参数: 就是每一个信号发送的数据!!
    [self rac_liftSelector:@selector(updateUIWithOneData:TwoData:) withSignalsFromArray:@[signal1,signal2]];
}

- (void)updateUIWithOneData:(id )oneData TwoData:(id )twoData {
    NSLog(@"%@",[NSThread currentThread]);
    //拿到数据更新UI
    NSLog(@"UI!! oneData = %@ twoData = %@",oneData,twoData);
}

@end
