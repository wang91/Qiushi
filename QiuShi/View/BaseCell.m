//
//  BaseCell.m
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseCell.h"
#import "BaseModel.h"
#define kID @"id"
@interface BaseCell()
{
    UIImageView  * _iconIV;
    UILabel      * _userLabel;
    UILabel      * _contentLabel;
    UILabel      * _laughLabel;
    UIButton     * _upButton;
    UIButton     * _downButton;
    UIButton     * _commentButton;
}
@end
@implementation BaseCell

+(instancetype)baseCellWithTableView:(UITableView *)tableView{
    BaseCell * cell=[tableView dequeueReusableCellWithIdentifier:kID];
    if (!cell) {
        cell=[[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kID];
        [cell addSubViews];
    }
    return cell;
}
-(void)addSubViews{
    _iconIV=[LFView creatImageViewWithFrame:CGRectMake(10, 10, 60, 60) superView:self.contentView];
    _userLabel=[LFView createLabelWithTitle:@"user" frame:CGRectMake(80, 20, 200, 30) font:LFFont(15.0f) superView:self.contentView];
    _contentLabel=[LFView createLabelWithTitle:@"content" frame:CGRectMake(10, 80, LFScreenWidth-20, 200) font:LFFont(15.0f) superView:self.contentView];
    _contentLabel.numberOfLines=0;
    _laughLabel=[LFView createLabelWithTitle:@"laugh" frame:CGRectMake(10,290, 200, 30) font:LFFont(15.0f) superView:self.contentView];
    _upButton=[LFView creatButtonWithTitle:@"up" frame:CGRectMake(10, 330, 30, 30) font:LFFont(15.0f) superView:self.contentView];
    [_upButton addTarget:self action:@selector(upclicked) forControlEvents:UIControlEventTouchUpInside];
    _downButton=[LFView creatButtonWithTitle:@"down" frame:CGRectMake(70, 330, 30, 30) font:LFFont(15.0f) superView:self.contentView];
    [_downButton addTarget:self action:@selector(downclicked) forControlEvents:UIControlEventTouchUpInside];
    _commentButton=[LFView creatButtonWithTitle:@"comment" frame:CGRectMake(130, 330, 30, 30) font:LFFont(15.0f) superView:self.contentView];
    [_commentButton addTarget:self action:@selector(commentclicked) forControlEvents:UIControlEventTouchUpInside];
}
-(void)upclicked{
    NSInteger a= [_laughLabel.text integerValue];
    NSLog(@"%ld",a);
    a++;
    _laughLabel.text=[NSString stringWithFormat:@"%ld好笑*%@评论",a,_baseModel.comments_count];
}
-(void)downclicked{
    
}
-(void)commentclicked{
    if ([_delegate respondsToSelector:@selector(BaseCellCommentClicked:)]) {
        [_delegate BaseCellCommentClicked:_baseModel];
    }
}
-(void)setBaseModel:(BaseModel *)baseModel{
    _baseModel=baseModel;
    
    CGFloat textHeight=[LFTool calculateTextHeight:baseModel.content size:CGSizeMake(LFScreenWidth-20, HUGE_VAL) font:LFFont(15.0f)];
    _contentLabel.frame=CGRectMake(10, 80, LFScreenWidth-20, textHeight);
    _laughLabel.frame=CGRectMake(10, 80+textHeight+10, 200, 30);
    _upButton.frame=CGRectMake(10, 90+30+textHeight+10, 30, 30);
    _downButton.frame=CGRectMake(70, 130+textHeight, 30, 30);
_commentButton.frame=CGRectMake(130, 130+textHeight, 30, 30);
    
    baseModel.cellHeight=130+textHeight+30+10;
    
    _iconIV.image=[UIImage imageNamed:@"114"];
    _userLabel.text=baseModel.user[@"login"];
    _contentLabel.text=baseModel.content;
    _laughLabel.text=[NSString stringWithFormat:@"%@好笑*%@评论",_baseModel.votes[@"up"],_baseModel.comments_count];
    [_upButton setImage:[UIImage imageNamed:@"icon_for"] forState:UIControlStateNormal];
    [_downButton setImage:[UIImage imageNamed:@"icon_against"] forState:UIControlStateNormal];
    [_commentButton setImage:[UIImage imageNamed:@"button_comment"] forState:UIControlStateNormal];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}
@end
