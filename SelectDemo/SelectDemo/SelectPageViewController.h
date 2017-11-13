//
//  SelectPageViewController.h
//  SelectDemo
//
//  Created by 思 彭 on 2017/11/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WMPageController.h>

typedef NS_ENUM(NSInteger, SelectType){
    PatientType = 0, //患者主题
    DoctorType  //医生主题
};

@interface SelectPageViewController : WMPageController

@property (nonatomic, assign) SelectType type; // 类型

@end
