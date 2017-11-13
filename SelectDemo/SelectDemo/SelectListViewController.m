//
//  SelectListViewController.m
//  SelectDemo
//
//  Created by 思 彭 on 2017/11/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SelectListViewController.h"
#import <TTGTextTagCollectionView.h>

@interface SelectListViewController () <TTGTextTagCollectionViewDelegate>

@end

@implementation SelectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    TTGTextTagCollectionView *tagCollectionView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width - 20, 200)];
    tagCollectionView.delegate = self;
    [self.view addSubview:tagCollectionView];
    
    // Style
    TTGTextTagConfig *config = tagCollectionView.defaultConfig;
    config.tagCornerRadius = 2;
    config.tagShadowColor = [UIColor whiteColor];
    config.tagShadowOffset = CGSizeMake(0, 0.3);
    config.tagShadowOpacity = 0.3f;
    config.tagShadowRadius = 0.5f;
    config.tagTextFont = [UIFont systemFontOfSize:15];
    config.tagTextColor = [UIColor darkGrayColor];
    config.tagSelectedTextColor = [UIColor darkGrayColor];
    config.tagBackgroundColor = [UIColor lightGrayColor];
    config.tagSelectedBackgroundColor = [UIColor lightGrayColor];
    
    if ([self.type isEqualToString:@"0"]) {
        // 患者
        [tagCollectionView addTags:@[@"患者一", @"患者2", @"患者3", @"患者4",@"TTG", @"Tag", @"collection", @"view",@"TTG", @"Tag", @"collection", @"患者8"]];
    } else {
        // 医生
         [tagCollectionView addTags:@[@"科室一", @"科室一", @"医生1", @"医生2",@"科室7", @"科室2", @"科室33", @"科室66",@"TTG", @"医生8", @"科室6", @"科室5"]];
    }
}

#pragma mark - TTGTextTagCollectionViewDelegate

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected {
    
    // 发通知添加
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TapTagNotification" object:nil userInfo:@{@"text": tagText}];
}

@end
