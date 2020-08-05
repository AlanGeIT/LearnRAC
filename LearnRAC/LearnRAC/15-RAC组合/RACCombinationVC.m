//
//  RACCombinationVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/20.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

//  组合!!

#import "RACCombinationVC.h"
#import <RACReturnSignal.h>

@interface RACCombinationVC ()

@end

@implementation RACCombinationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self concatDemo];  // concat:按顺序组合!!
//    [self thenDemo];    // then:忽略掉第一个信号所有的值!!
//    [self mergeDemo];
    [self zipDemo];
}

#pragma mark - zipWith
-(void)zipDemo{
    // zipWith:两个信号压缩!只有当两个信号同时发出信号内容,并且将内容合并成为一个元祖给你
    
    // 创建信号
    RACSubject * signalA = [RACSubject subject];
    RACSubject * signalB = [RACSubject subject];
    
    // 压缩
    RACSignal * zipSignal =  [signalA zipWith:signalB];
    
    // 接受数据  和发送顺序无关!!
    [zipSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    // 发送数据
    [signalB sendNext:@"B"];
    [signalA sendNext:@"A"];
    [signalB sendNext:@"B1"];
    [signalA sendNext:@"A1"];
    [signalB sendNext:@"B2"];
    [signalA sendNext:@"A2"];

}

#pragma mark - merge
-(void)mergeDemo{
    
    // 创建信号
    RACSubject * signalA = [RACSubject subject];
    RACSubject * signalB = [RACSubject subject];
    RACSubject * signalC = [RACSubject subject];
    
    // 组合信号
//    RACSignal * mergeSignal = [signalA merge:signalB];
    RACSignal *mergeSignal = [RACSignal merge:@[signalA,signalB,signalC]];
    
    // 订阅 -- 根据发送的情况接受数据!!
    [mergeSignal subscribeNext:^(id  _Nullable x) {
        // 任意一个信号发送内容就会来这个Block
        NSLog(@"x = %@",x);
    }];
    
    //发送数据
    [signalC sendNext:@"数据C"];
    [signalA sendNext:@"数据A"];
    [signalB sendNext:@"数据B"];
}

#pragma mark - then:忽略掉第一个信号所有的值!!
-(void)thenDemo{
    
    //创建信号!!
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求A");
        //发送数据
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求B");
        //发送数据
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    // then:忽略掉第一个信号所有的值!!
    // signalB依赖signalA，signalA发送完毕，才会来signalB
    RACSignal * thenSignal = [signalA then:^RACSignal * _Nonnull{
        return signalB;
    }];
    
    // 订阅信号
    [thenSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"x = %@",x);
    }];
}

#pragma mark - concat:按顺序组合!!
-(void)concatDemo{
    // 组合!!
    // 创建信号!!
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求A");
        // 发送数据
        [subscriber sendNext:@"数据A"];
        // 哥么结束了!!
        [subscriber sendCompleted];
//        [subscriber sendError:nil]; 这哥么不行!
        
        return nil;
    }];
    
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求B");
        //发送数据
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal * signalC = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求C");
        //发送数据
        [subscriber sendNext:@"数据C"];
        
        return nil;
    }];
    
    //concat:按顺序组合!!
    //创建组合信号!!
//    RACSignal * concatSignal = [[signalA concat:signalB] concat:signalC];
    
    RACSignal *concatSignal = [RACSignal concat:@[signalA,signalB,signalC]];
    
    // 订阅组合信号
    [concatSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"x = %@",x);
    }];
}

@end
