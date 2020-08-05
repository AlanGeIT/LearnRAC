//
//  LoginViewModel.h
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/20.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

/** 账号&&密码  */
@property(nonatomic, strong)NSString *account;
@property(nonatomic, strong)NSString *pwd;

/** 处理登录按钮能否点击的信号 */
@property(nonatomic, strong)RACSignal  *loginEnableSignal;
/** 登录按钮命令  */
@property(nonatomic, strong)RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
