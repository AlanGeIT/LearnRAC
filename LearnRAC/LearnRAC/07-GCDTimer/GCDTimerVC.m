//
//  GCDTimerVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "GCDTimerVC.h"

@interface GCDTimerVC ()

@property(nonatomic, strong)dispatch_source_t  timer;

@end

@implementation GCDTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // GCD设置timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    
    // GCD的事件单位是纳秒
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"-----_%@",[NSThread currentThread]);
    });
    
    // 启动
    dispatch_resume(timer);
    _timer = timer;
}

- (void)dealloc {
    NSLog(@"走了");
}

@end
