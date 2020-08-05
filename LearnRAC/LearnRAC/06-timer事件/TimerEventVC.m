//
//  TimerEventVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

// 有问题，未完善

#import "TimerEventVC.h"
#import "Runloop.h"
#import "Thread.h"

@interface TimerEventVC ()

@property(assign,nonatomic)BOOL finished;

@end

@implementation TimerEventVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _finished = NO;
    
    // 事件 交给谁处理的??  Runloop!
    // Runloop 模式 && 多线程!!
    // NSDefaultRunLoopMode  默认模式;
    // UITrackingRunLoopMode UI模式:只能被UI事件唤醒!!
    // NSRunLoopCommonModes  占位模式:默认&UI模式
    

//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self   selector:@selector(timerMethod) userInfo:nil repeats:YES];
    
    Thread * thread = [[Thread alloc]initWithBlock:^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        //开启runloop循环
        [[NSRunLoop currentRunLoop] run];

        NSLog(@"come here!!%@",[NSThread currentThread]);//a  b
    }];

    [thread start];
}

- (void)timerMethod {
    if(_finished){
        [NSThread exit];
    }
    NSLog(@"来了%@",[NSThread currentThread]);//1  2
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _finished = YES;
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
