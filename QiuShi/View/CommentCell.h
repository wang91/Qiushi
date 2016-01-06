//
//  CommentCell.h
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;
@interface CommentCell : UITableViewCell
+(instancetype)commentCellWithTableView:(UITableView *)tableview;
@property(nonatomic,strong)CommentModel * model;
@end
