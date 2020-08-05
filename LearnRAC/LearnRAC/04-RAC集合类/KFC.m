//
//  KFC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "KFC.h"

@implementation KFC

+(instancetype)kfcWithDict:(NSDictionary *)dict
{
    KFC *kfc = [[KFC alloc]init];
    
    [kfc setValuesForKeysWithDictionary:dict];
    
    return kfc;
}

@end
