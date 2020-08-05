//
//  RACSubjectVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

// 代理可以做很多复杂而且选择非常多的功能!!
// id 是什么?
// RAC它的运用范围非常广泛!!!

#import "RACSubjectVC.h"
#import "RACSubjectView.h"

@interface RACSubjectVC ()

@property (nonatomic, strong) RACSubjectView        *subjectView;

@end

@implementation RACSubjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self subject1];
    [self subject2];
}

- (void)subject1 {
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    // 2.订阅信号
    // 不同的信号，订阅的方式不一样(因为类型不一样，所以调用的方法不一样)
    // RACSubject处理订阅：拿到之前的_subscribers保存订阅者
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到了数据 = %@",x);
    }];
    // 3.发送数据
    // 遍历出所有的订阅者，调用nextBlock
    [subject sendNext:@"发送的数据"];
}

- (void)subject2 {
    
    self.subjectView.frame = CGRectMake((kMainScreenWidth-200)/2, 0, 200, 200);
    [self.view addSubview:self.subjectView];
    
    //订阅信号
    [self.subjectView.btnClickSingnal subscribeNext:^(id x) {
        NSLog(@"x = %@",x);
        self.view.backgroundColor = x;
    }];
}

- (RACSubjectView *)subjectView {
    if (_subjectView != nil) {
        return _subjectView;
    }
    
    _subjectView = [[RACSubjectView alloc] init];
    
    return _subjectView;
}

@end
