//
//  SendVerificationCodeVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "SendVerificationCodeVC.h"

@interface SendVerificationCodeVC ()
@property (weak, nonatomic) IBOutlet UIButton *sendVerificationBtn;
/**  */
@property(assign,nonatomic)int time;
/**   */
@property(nonatomic,strong)RACDisposable  * disposable;
/**   */
@property(nonatomic,strong)RACSignal * signal;
@end

@implementation SendVerificationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self timerDemo];
}
- (IBAction)SendVerificationClick:(id)sender {
    //改变按钮状态
    self.sendVerificationBtn.enabled = NO;
    //设置倒计时
    self.time = 10;
    //每一秒进来
    self.signal = [RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]];
    
    self.disposable = [self.signal subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"%@",self);
        //时间先减少!
        _time--;
        //设置文字
        NSString * btnText = _time > 0 ? [NSString stringWithFormat:@"请等待%d秒",_time]
                                    : @"重新发送";
        [self.sendVerificationBtn setTitle:btnText forState:_time > 0?(UIControlStateDisabled):(UIControlStateNormal)];
        //设置按钮
        if(_time > 0){
            _sendVerificationBtn.enabled = NO;
        }else{
            _sendVerificationBtn.enabled = YES;
            //取消订阅!!
            [_disposable dispose];
        }
    }];
}

-(void)timerDemo{
    // RAC tiemr 让你上瘾!!
    [[RACSignal interval:1.0 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"%@",[NSThread currentThread]);
    }];
}

-(void)dealloc{
    //取消订阅!!
    [self.disposable dispose];
    NSLog(@"走了");
}

@end
