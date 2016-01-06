//
//  LFTool.m
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LFTool.h"

@implementation LFTool
+(CGFloat)calculateTextHeight:(NSString *)text size:(CGSize)size font:(UIFont *)font{
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : font } context:nil];
    return rect.size.height;
}
@end
