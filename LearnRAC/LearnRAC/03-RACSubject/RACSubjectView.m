//
//  RACSubjectView.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "RACSubjectView.h"

@interface RACSubjectView ()

@property (nonatomic, strong) UIButton        *button;

@end

@implementation RACSubjectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup {
    
    self.backgroundColor = [UIColor blueColor];
    
    self.button.frame = CGRectMake(100, 100, 100, 40);
    [self addSubview:self.button];
}

- (void)buttonClick {
    //通知外面!!
    [self.btnClickSingnal sendNext:self.backgroundColor];
}

#pragma mark - 懒加载
-(RACSubject *)btnClickSingnal
{
    if (!_btnClickSingnal) {
        _btnClickSingnal = [RACSubject subject];
    }
    return _btnClickSingnal;
}

- (UIButton *)button {
    if (_button != nil) {
        return _button;
    }
    
    _button                      = [[UIButton alloc] init];
    _button.backgroundColor      = [UIColor lightGrayColor];
    _button.titleLabel.font      = [UIFont systemFontOfSize:15];

    [_button setTitle:@"按钮" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return _button;
}

@end
