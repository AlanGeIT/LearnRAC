//
//  RACMacroVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "RACMacroVC.h"

@interface RACMacroVC ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RACMacroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* ************** RAC宏 ************** */
    [self  RACMacro];
}

#pragma mark - RAC宏
- (void)RACMacro {
    //监听文本框内容
//    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        _label.text = x;
//        NSLog(@"文本框内容 = %@",x);
//    }];
    
    /* ************** RAC宏：RAC ************** */
    
    // 将输入框的值赋值给label
    // 给某个对象的某个属性绑定信号，一旦信号产生数据,就会将内容赋值给属性!
    RAC(_label,text) = _textField.rac_textSignal;
    
    /* ************** RAC宏：RACObserve ************** */
    //只要这个对象的属性发生变化..哥么信号就发送数据!!
    [RACObserve(self.label, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"label的值%@",x);
    }];
    /* ************** RAC宏：RACTuplePack ************** */
    
    // 包装元祖
    RACTuple * tuple = RACTuplePack(@1,@2);

    NSLog(@"%@",tuple[0]);

    //解包!!
//    RACTupleUnpack(<#...#>)
}

@end
