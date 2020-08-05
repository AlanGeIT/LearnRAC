//
//  ModalVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "ModalVC.h"

@interface ModalVC ()

@property(nonatomic,strong)RACSignal * signal;

@end

@implementation ModalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);// 解决强引用问题
       
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       
       @strongify(self);// 记得strongify回来才有效
       
       NSLog(@"%@",self);
       [subscriber sendNext:@"发送数据"];
       
       return  nil;
    }];

    [signal subscribeNext:^(id  _Nullable x) {
       NSLog(@"%@",x);
    }];

    _signal = signal;
    
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//对象被释放!!
- (void)dealloc {
    NSLog(@"ModalVC走了!不送!!");
}

@end
