//
//  KFC.h
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KFC : NSObject

@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *icon;

+(instancetype)kfcWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
