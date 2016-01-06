//
//  BaseModel.h
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BaseModel : NSObject
@property(nonatomic,strong)NSDictionary * user;
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSDictionary * votes;
@property(nonatomic,strong)NSString * content;
@property(nonatomic,strong)NSString * comments_count;
//cell高度属性
@property(nonatomic,assign)CGFloat cellHeight;

@end
