//
//  ViewController.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSArray     *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"01-初试",@"RACFirstTryVC"],
                         @[@"02-RACDisposable",@"RACDisposableVC"],
                         @[@"03-RACSubject",@"RACSubjectVC"],
                         @[@"04-RAC集合类",@"RACCollectionClassVC"],
                         @[@"05-RAC常见用法",@"RACCommonUseVC_storyboard"],
                         @[@"06-timer事件",@"TimerEventVC_storyboard"],
                         @[@"07-GCDTimer",@"GCDTimerVC"],
                         @[@"08-发送验证码",@"SendVerificationCodeVC_storyboard"],
                         @[@"09-RAC_liftSelector",@"LiftSelectorVC"],
                         @[@"10-RAC宏",@"RACMacroVC_storyboard"],
                         @[@"11-RAC连接类",@"RACMulticastConnectionVC"],
                         @[@"12-RACCommand类",@"RACCommandVC"],
                         @[@"13-RAC绑定",@"RACBindVC"],
                         @[@"14-RAC映射",@"RACMappingVC"],
                         @[@"15-RAC组合",@"RACCombinationVC"],
                         @[@"16-组合应用",@"CombinationUseVC_storyboard"],
                         @[@"17-RAC过滤",@"RACFilterVC_storyboard"],
                         @[@"18-登录逻辑",@"LoginVC_storyboard"],
                         @[@"19-MVVM登录",@"MVVMLoginVC_storyboard"]]];
}

@end


