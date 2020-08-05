//
//  RACSubjectView.h
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ReactiveCocoa.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACSubjectView : UIView

@property(nonatomic,strong)RACSubject *btnClickSingnal;

@end

NS_ASSUME_NONNULL_END
