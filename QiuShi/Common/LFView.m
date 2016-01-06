//
//  LFView.m
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LFView.h"

@implementation LFView

+(UIImageView *)creatImageViewWithFrame:(CGRect)frame superView:(UIView *)superView{
    UIImageView * iv=[[UIImageView alloc]initWithFrame:frame];
    iv.layer.cornerRadius=10.0f;
    iv.layer.masksToBounds=YES;
    [superView addSubview:iv];
    return iv;
}
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font superView:(UIView *)superView{
    UILabel * label=[[UILabel alloc]initWithFrame:frame];
    label.text=title;
    label.font=font;
    [superView addSubview:label];
    return label;
}
+(UIButton *)creatButtonWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font superView:(UIView *)superView{
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font=font;
    [superView addSubview:btn];
    return btn;
}


@end
