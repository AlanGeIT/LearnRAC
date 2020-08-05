//
//  LoginVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/20.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "LoginVC.h"


@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self demo1];
//    [self demo2];
    

}

/* ************** demo1 ************** */
- (void)demo1 {
    
    //处理文本框业务逻辑
    RACSignal *loginEnableSignal = [RACSignal combineLatest:@[_accountFiled.rac_textSignal, _pwdFiled.rac_textSignal] reduce: ^id _Nullable(NSString *
    account , NSString * pwd){
        return @( account.length & pwd.length);
    }];
    
    //设置按钮
    RAC(_loginBtn, enabled) = loginEnableSignal;
   
    //创建命令
    RACCommand * command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
        //处理事件密码加密
        NSLog(@"拿到 = %@",input);
        return [RACSignal createSignal: ^RACDisposable * _Nullable(id<RACSubscriber> _Nonnull subscriber) {
            NSLog(@"请求登录的数据");
            //发送请求&&获取登录结果! !
            [subscriber sendNext :@"请求登录的数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // 获取命令中信号源
    [command.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
        NSLog(@"获取命令中信号源 = %@",x);
    }];
    
    // 监听命令执行过程
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"监听命令执行过程 = %@",x);
        if ([x boolValue]) {
            // 正在执行
            NSLog(@"显示菊花");
        } else {
            NSLog(@"隐藏菊花");
        }
    }];
    
    //监听登录按钮的点击
    [[_loginBtn rac_signalForControlEvents : (UIControlEventTouchUpInside )] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了登录按钮");
        // 处理登录事件
        [command execute:@"账号密码"];
    }];
}

@end
