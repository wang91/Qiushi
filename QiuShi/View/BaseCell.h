//
//  BaseCell.h
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;
@protocol BaseCellDelegate<NSObject>
-(void)BaseCellCommentClicked:(BaseModel *)model;
@end
@interface BaseCell : UITableViewCell
+(instancetype)baseCellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)BaseModel * baseModel;
@property(nonatomic,weak)id<BaseCellDelegate>delegate;
@end
