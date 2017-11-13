//
//  RootViewController.m
//  SelectDemo
//
//  Created by 思 彭 on 2017/11/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "RootViewController.h"
#import <Masonry.h>
#import "SelectPageViewController.h"
#import <TTGTagCollectionView.h>
#import "VerticalCenterTextLabel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface RootViewController () <WMPageControllerDelegate, TTGTagCollectionViewDelegate, TTGTagCollectionViewDataSource>

@property (nonatomic, strong) SelectPageViewController *pageVc;
@property (nonatomic, strong) TTGTagCollectionView *tagCollectionView;
@property (strong, nonatomic) NSMutableArray <UIView *> *tagViews;
@property (nonatomic, assign) NSInteger currentSelectTagIndex; // 当前选中的tag的index
@property (nonatomic, assign) NSInteger lastDeleteSelectTagIndex; // 上次删除的tag的index

@end

@implementation RootViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择Demo";
    self.navigationController.navigationBar.translucent = NO;
    [self createTopView];
    [self createTagCollectionView];
    [self.view layoutSubviews];
    [self createPageVC];
    
    // 接受添加tag的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReciverNotification:) name:@"TapTagNotification" object:nil];
}

- (void)createTopView {
    
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
}

- (void)createTagCollectionView {
    _tagViews = [NSMutableArray new];
    
    _tagCollectionView = [[TTGTagCollectionView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 200)];
    _tagCollectionView.delegate = self;
    _tagCollectionView.dataSource = self;
    [self.topView addSubview:_tagCollectionView];
    [_tagViews addObject:[self newViewWithTitle:@"脑科" textColor:[UIColor grayColor] fontSize:15 backgroundColor: [UIColor whiteColor] tipImage:nil hasDeleteFlag:NO]];
    [_tagViews addObject:[self newViewWithTitle:@"神经外科" textColor:[UIColor grayColor] fontSize:15 backgroundColor: [UIColor whiteColor] tipImage:@"mine_collection_question_icon" hasDeleteFlag:YES]];
    [_tagViews addObject:[self newViewWithTitle:@"内科内科内科内科" textColor:[UIColor grayColor] fontSize:15 backgroundColor: [UIColor whiteColor] tipImage:@"mine_collection_question_icon" hasDeleteFlag:YES]];
    [_tagCollectionView reload];
}

- (void)createPageVC {
    self.pageVc = [[SelectPageViewController alloc]init];
    self.pageVc.delegate = self;
    [self.view addSubview:self.pageVc.view];
    [self.view bringSubviewToFront:self.topView];
}

#pragma mark - TTGTagCollectionViewDelegate

- (CGSize)tagCollectionView:(TTGTagCollectionView *)tagCollectionView sizeForTagAtIndex:(NSUInteger)index {
    return _tagViews[index].frame.size;
}

- (void)tagCollectionView:(TTGTagCollectionView *)tagCollectionView didSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    NSLog(@"选中了。。。。");
    self.currentSelectTagIndex = index;
    //    [self.tagViews removeObjectAtIndex:index];
    //    [self.tagCollectionView reload];
}

#pragma mark - TTGTagCollectionViewDataSource

- (NSUInteger)numberOfTagsInTagCollectionView:(TTGTagCollectionView *)tagCollectionView {
    return _tagViews.count;
}

- (UIView *)tagCollectionView:(TTGTagCollectionView *)tagCollectionView tagViewForIndex:(NSUInteger)index {
    return _tagViews[index];
}

#pragma mark - Private methods

// 自定义itemView
- (UIView *)newViewWithTitle:(NSString *)text textColor: (UIColor *)textColor fontSize:(CGFloat)fontSize backgroundColor:(UIColor *)backgroudColor tipImage: (NSString *)imageName hasDeleteFlag: (BOOL)flag {
    
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectZero];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.masksToBounds = YES;
    containerView.layer.cornerRadius = 4.0f;
    containerView.tag = !self.tagViews.count  ? 0 : self.tagViews.count - 1 + 1;
    VerticalCenterTextLabel *label = [[VerticalCenterTextLabel alloc]init];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.textColor = textColor;
    label.backgroundColor = backgroudColor;
    [label sizeToFit];
    label.verticalAlignment = myVerticalAlignmentCenter;
    [containerView addSubview:label];
    UIImageView *tipImageView;
    // tipImage
    if (imageName.length > 0 && ![imageName isEqualToString:@""]) {
        tipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 10)];
        if (imageName.length > 0 && imageName != nil) {
            tipImageView.image = [UIImage imageNamed:imageName];
        }
        [containerView addSubview:tipImageView];
    }
    UIButton *delButton;
    if (flag) {
        // deleteButton
        delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        delButton.backgroundColor = [UIColor blueColor];
        delButton.tag = containerView.tag;
        [delButton addTarget:self action:@selector(tagDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:delButton];
    }
    [self expandSizeForView:label extraWidth:20 extraHeight:16];
    
    // 设置布局
    containerView.frame = CGRectMake(0, 0, label.frame.size.width, label.frame.size.height);
    if (flag) {
        delButton.frame = CGRectMake(CGRectGetMaxX(containerView.frame) - 10, 0, 10, 10);
    }
    return containerView;
}

- (void)expandSizeForView:(UIView *)view extraWidth:(CGFloat)extraWidth extraHeight:(CGFloat)extraHeight {
    CGRect frame = view.frame;
    frame.size.width += extraWidth;
    frame.size.height += extraHeight;
    view.frame = frame;
}

- (void)didReciverNotification: (NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *text = userInfo[@"text"];
    NSLog(@"---%@---", text);
    [_tagViews addObject:[self newViewWithTitle:text textColor:[UIColor grayColor] fontSize:15 backgroundColor: [UIColor whiteColor] tipImage:nil hasDeleteFlag:YES]];
    [_tagCollectionView reload];
}

- (void)tagDeleteAction: (UIButton *)button {
    NSLog(@"---删除---%ld",button.tag);
    self.lastDeleteSelectTagIndex = button.tag;
    [self.tagViews removeObjectAtIndex:button.tag];
    NSLog(@"---个数---%ld",self.tagViews.count);
    
    // 点击删除并没有出发点击tag的代理方法。
    //    [self.tagViews removeObjectAtIndex:self.currentSelectTagIndex];
    //    [self.tagCollectionView reload];
    
    // 这里注意： 删除一个tagView之后，后面的tagView的tag值需要更新，否则会崩溃
    for (NSInteger i = self.lastDeleteSelectTagIndex; i < self.tagViews.count; i++) {
        UIView *subView = self.tagViews[i];
        subView.tag = subView.tag - 1;
        for (NSInteger j = 0; j < subView.subviews.count; j++) {
            if ([subView.subviews[j] isKindOfClass:[UIButton class]]) {
                subView.subviews[j].tag = subView.tag;
            }
        }
    }
    [self.tagCollectionView reload];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end

