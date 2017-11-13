//
//  VerticalCenterTextLabel.h
//  SelectDemo
//
//  Created by 思 彭 on 2017/11/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    myVerticalAlignmentNone = 0,
    myVerticalAlignmentCenter,
    myVerticalAlignmentTop,
    myVerticalAlignmentBottom
} myVerticalAlignment;

@interface VerticalCenterTextLabel : UILabel
@property (nonatomic) UIEdgeInsets edgeInsets;

/**
 *  对齐方式
 */
@property (nonatomic) myVerticalAlignment verticalAlignment;

@end  
