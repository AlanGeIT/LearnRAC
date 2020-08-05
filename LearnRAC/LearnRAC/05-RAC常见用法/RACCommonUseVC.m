//
//  RACCommonUseVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "RACCommonUseVC.h"
#import "BlueView.h"
#import <NSObject+RACKVOWrapper.h>// RAC中的KVO

@interface RACCommonUseVC ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet BlueView *blueView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation RACCommonUseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo1];// 1.代替代理:RACSubject
    [self demo2];// 2.代替KVO
    [self demo3];// 3.监听事件
    [self demo4];// 4.代替通知
    [self demo5];// 5.监听文本框
}

-(void)demo5{
    // 5.监听文本框
    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
}

-(void)demo4{
    // 4.代替通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@",x);
    }];
}

-(void)demo3{
    // 3.监听事件
    [[_btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (IBAction)changeBlueViewFrame:(id)sender {
    static int x = 50;
    x++;
    _blueView.frame = CGRectMake(x, 50, 200, 200);
}

-(void)demo2{
    // 2.代替KVO
//    [_blueView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew  observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//        //回调
//        NSLog(@"value = %@---%@",value,change);
//
//    }];
    
    // 更爽!!!
    [[_blueView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"frame = %@",x);

    }];
}

-(void)demo1{
    // 1.代替代理:RACSubject
//    [[_blueView rac_signalForSelector:@selector(buttonAction:)] subscribeNext:^(RACTuple * _Nullable x) {
//        NSLog(@"监听到按钮点击事件了");
//        NSLog(@"%@",x);
//    }];
    
    [[_blueView rac_signalForSelector:@selector(laiel:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"监听按钮传过来的值 = %@",x);
    }];
}







@end
