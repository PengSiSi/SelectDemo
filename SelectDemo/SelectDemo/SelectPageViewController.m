//
//  SelectPageViewController.m
//  SelectDemo
//
//  Created by 思 彭 on 2017/11/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SelectPageViewController.h"
#import "SelectListViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface SelectPageViewController ()

@end

@implementation SelectPageViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuView.backgroundColor = [UIColor whiteColor];
        self.menuView.lineColor = [UIColor blueColor];
        
        self.titleSizeSelected = [UIScreen mainScreen].bounds.size.width > 320 ? 17.0 : 16.0;
        self.titleSizeNormal = [UIScreen mainScreen].bounds.size.width > 320 ? 16.0 : 15.0;
        self.itemsWidths = @[@(80), @(80)];
        self.itemMargin = 1.0;
        self.menuView.contentMargin = 1.0;
        self.titleColorSelected = [UIColor blueColor];
        self.titleColorNormal = [UIColor grayColor];
        self.progressColor = [UIColor blueColor];
    }
    return self;
}

- (NSArray<NSString *> *)titles {
    return @[@"患者主题", @"医生主题"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - WMPageController DataSource

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    SelectListViewController *listVC;
    if (index == 0) {
        listVC = [[SelectListViewController alloc]init];
        listVC.type = @"0";
    } else {
        listVC = [[SelectListViewController alloc]init];
        listVC.type = @"1";
    }
    return listVC;
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    NSLog(@"info: %@",info);
    
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    // .multipliedBy(9.0f/16.0f).with.priority(750)
    return CGRectMake(0, 200 + 44, SCREEN_WIDTH, SCREEN_HEIGHT - 200 - 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 200, SCREEN_WIDTH, 44);
}

@end
