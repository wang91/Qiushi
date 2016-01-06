//
//  LFView.h
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFView : UIView
+(UIImageView *)creatImageViewWithFrame:(CGRect)frame superView:(UIView *)superView;
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font superView:(UIView *)superView;
+(UIButton *)creatButtonWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font superView:(UIView *)superView;
@end
