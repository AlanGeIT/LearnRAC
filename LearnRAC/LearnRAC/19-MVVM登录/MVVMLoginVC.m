//
//  MVVMLoginVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/20.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

//  MVC  -- 逻辑非常清晰!!
//  MVVM --  M 模型  V 视图+控制器  VM:视图模型
//  VM(给C瘦身!!): 这就是MVVM架构的一个亮点!!代替控制器做N多的逻辑处理!!

#import "MVVMLoginVC.h"
#import "LoginViewModel.h"

@interface MVVMLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdFiled;
@property (weak, nonatomic) IBOutlet UIButton    *loginBtn;

/** VM  */
@property(nonatomic,strong) LoginViewModel *loginVM;

@end

@implementation MVVMLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self MVVMLoginDemo];
}

- (void)MVVMLoginDemo {
    
    // 1.给模型的账号&&密码绑定信号!!
    RAC(self.loginVM, account) = _accountFiled.rac_textSignal;
    RAC(self.loginVM, pwd)     = _pwdFiled.rac_textSignal;
    
    // 2.设置按钮
    RAC(_loginBtn, enabled) = self.loginVM.loginEnableSignal;
    // 3.监听登录按钮的点击
    [[_loginBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // 处理登录事件
        [self.loginVM.loginCommand execute:@"账号密码"];
    }];
}

-(LoginViewModel *)loginVM
{
    // 有效避免出错!!
    if (nil == _loginVM) {
        _loginVM = [[LoginViewModel alloc]init];
    }
    return _loginVM;
}

@end
