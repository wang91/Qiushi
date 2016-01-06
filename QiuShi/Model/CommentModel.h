//
//  CommentModel.h
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property(nonatomic,strong)NSString * floor;
@property(nonatomic,strong)NSString * content;
@property(nonatomic,strong)NSDictionary * user;
//cell高度属性
@property(nonatomic,assign)CGFloat cellHeight;

@end
