//
//  CombinationUseVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/20.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "CombinationUseVC.h"

@interface CombinationUseVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation CombinationUseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 组合
    // reduceBlock参数:根据组合的信号关联的  必须 一一对应!!
    RACSignal * signal = [RACSignal combineLatest:@[_accountFiled.rac_textSignal,_pwdFiled.rac_textSignal] reduce:^id _Nullable(NSString * account,NSString * pwd){
        
        //两个文本框的text是否有值!!
        return @(account.length && pwd.length);
    }];

    //订阅组合信号
//    [signal subscribeNext:^(id  _Nullable x) {
//        _loginBtn.enabled = [x boolValue];
//    }];

    RAC(_loginBtn,enabled) = signal;
    
    [[_loginBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击登录%@",x);
    }];
}

@end
