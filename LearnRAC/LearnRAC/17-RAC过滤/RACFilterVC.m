//
//  RACFilterVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/20.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "RACFilterVC.h"

@interface RACFilterVC ()
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation RACFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self filterDemo];    // filter：过滤
//    [self ignoreDemo];    // ignore:忽略
//    [self takeDemo];      // 指定拿哪几条数据
//    [self distinDemo];    // 忽略掉重复数据
    [self skipDemo];      // skip: 跳跃几个值
}

// skip: 跳跃几个值
- (void)skipDemo {
    RACSubject * subject = [RACSubject subject];
    
    // skip: 跳跃几个值
    [[subject skip:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"跳跃几个值 = %@",x);
    }];

    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
}

// 忽略掉重复数据
-(void)distinDemo{
    //1.创建信号
    RACSubject * subject = [RACSubject subject];
    
    // 忽略掉重复数据
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"忽略掉重复数据 = %@",x);
    }];
    
    //请求回来
    [subject sendNext:@"abc haha hehe"];
    [subject sendNext:@"hehe"];
    [subject sendNext:@"1"];[subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"2"];

}

// 指定拿哪几条数据
-(void)takeDemo {
    
    RACSubject * subject = [RACSubject subject];
    
    // take:指定拿前面的哪几条数据!!(从前往后)
    [[subject take:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"从前往后 = %@",x);
    }];
    // takeLast:指定拿前面的哪几条数据!!(从后往前)注意点:一定要写结束!!
    [[subject takeLast:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"从后往前 = %@",x);
    }];
    
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendNext:@"1"];
    [subject sendCompleted];
    
//    RACSubject * subject = [RACSubject subject];
    //专门做一个标记信号!!
    RACSubject *signal = [RACSubject subject];
    
    //take:指定拿前面的哪几条数据!!(从前往后)
    //takeLast:指定拿前面的哪几条数据!!(从后往前)注意点:一定要写结束!!
    //takeUntil:直到你的标记信号发送数据的时候结束!!!
    [[subject takeUntil:signal] subscribeNext:^(id  _Nullable x) {
        NSLog(@"直到你的标记信号发送数据的时候结束 = %@",x);
    }];
    
    [subject sendNext:@"2"];
    
    //[signal sendNext:@".."];
    [signal sendCompleted];//标记信号!!
    
    [subject sendNext:@"3"];
    [subject sendNext:@"1"];
    [subject sendCompleted];
}

// ignore:忽略
-(void)ignoreDemo {
    
    // ignore:忽略
    RACSubject * subject = [RACSubject subject];
    
    //忽略一些值!!
    RACSignal * ignoreSignal = [[[subject ignore:@"1"] ignore:@"2"] ignore:@"3"];
    
    //订阅
    [ignoreSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    // 发送数据
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"13"];
    [subject sendNext:@"3"];
}

// filter：过滤
-(void)filterDemo {
    [[_textFiled.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        // value:源信号的内容
        return [value length] > 5;
        // 返回值：就是过滤条件，只有满足这个条件，才能获取到内容
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
}

@end
