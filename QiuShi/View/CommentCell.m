//
//  CommentCell.m
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#define kkID @"ID"

@interface CommentCell ()
{
    UIImageView * _iconIV;
    UILabel     * _userLabel;
    UILabel     * _contentLabel;
    UILabel     * _floorLabel;
}
@end

@implementation CommentCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}
+(id)commentCellWithTableView:(UITableView *)tableview{
    CommentCell * cell=[tableview dequeueReusableCellWithIdentifier:kkID];
    if (!cell) {
        cell=[[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kkID];
        [cell addsubViews];
    }
    return cell;
}
-(void)addsubViews{
    _iconIV=[LFView creatImageViewWithFrame:CGRectMake(10, 10, 60, 60) superView:self.contentView];
    _userLabel=[LFView createLabelWithTitle:@"user" frame:CGRectMake(80, 15, 150, 15) font:LFFont(15.0f) superView:self.contentView];
    _contentLabel=[LFView createLabelWithTitle:@"content" frame:CGRectMake(80, 30, LFScreenWidth-90, 80) font:LFFont(15.0f) superView:self.contentView];
    _contentLabel.numberOfLines=0;
    _floorLabel=[LFView createLabelWithTitle:@"floor" frame:CGRectMake(LFScreenWidth-40-20, 5, 40, 20) font:LFFont(15.0f) superView:self.contentView];
    _floorLabel.textAlignment=NSTextAlignmentRight;
 }
-(void)setModel:(CommentModel *)model{
    _model=model;
    CGFloat textHeight=[LFTool calculateTextHeight:model.content size:CGSizeMake(LFScreenWidth-90, HUGE_VAL) font:LFFont(15.0f)];
    _contentLabel.frame=CGRectMake(80, 35, LFScreenWidth-90-40, textHeight);
    CGFloat maxValue = MAX(textHeight+_contentLabel.frame.origin.y, _iconIV.frame.origin.y+60);
    model.cellHeight=maxValue+10;

    _iconIV.image=[UIImage imageNamed:@"114"];
    _userLabel.text=model.user[@"login"];
    _contentLabel.text=model.content;
    _floorLabel.text=[NSString stringWithFormat:@"%@楼",model.floor];
    
    
}
@end
