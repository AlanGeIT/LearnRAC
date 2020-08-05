//
//  BaseTableViewVC.m
//  LearnRAC
//
//  Created by Alan Ge on 2020/7/19.
//  Copyright © 2020 Alan Ge. All rights reserved.
//

#import "BaseTableViewVC.h"

@interface BaseTableViewVC ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *classNames;

@end

@implementation BaseTableViewVC

- (void)setupDataArr:(NSArray *)dataArr {

    NSMutableArray *tempTitleArr = [NSMutableArray array];
    NSMutableArray *tempNamesArr = [NSMutableArray array];

    for (NSArray *arr in dataArr) {
        [tempTitleArr addObject:arr[0]];
        [tempNamesArr addObject:arr[1]];
    }
    self.titles = tempTitleArr;
    self.classNames = tempNamesArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *mainCellIdentifier = @"mainCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.titles[indexPath.row]];
    cell.detailTextLabel.text = self.classNames[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = self.classNames[indexPath.row];
    
    // 注意: 如果是sb来搭建, 必须以 _storyboard 结尾
    NSUInteger classNameLength = className.length;
    NSUInteger storyBoardLength = @"_storyboard".length;
    NSUInteger xibLength = @"_xib".length;
    
    NSString *suffixClassName;
    if (classNameLength > storyBoardLength) {
        suffixClassName = [className substringFromIndex:classNameLength - storyBoardLength];
    }
    
    if ([suffixClassName isEqualToString:@"_storyboard"]) {
        
        className = [className substringToIndex:classNameLength - storyBoardLength];
        
        // 注意: 这个storyboard的名字必须是控制器的名字
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:className bundle:nil];
        UIViewController *cardVC = [storyBoard instantiateInitialViewController];
        if (!cardVC) {
            cardVC = [storyBoard instantiateViewControllerWithIdentifier:className];
        }
        cardVC.title = self.titles[indexPath.row];
        [self.navigationController pushViewController:cardVC animated:YES ];
        
    }else if ([[className substringFromIndex:classNameLength - xibLength] isEqualToString:@"_xib"]) {
    
        className = [className substringToIndex:classNameLength - xibLength];

        UIViewController *vc = [[NSClassFromString(className) alloc]initWithNibName:className bundle:nil];
        vc.title = self.titles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        UIViewController *vc = [[NSClassFromString(className) alloc] init];
        vc.title = self.titles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
