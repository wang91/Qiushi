//
//  ViewController1.h
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;
@class CommentModel;
@interface ViewController1 : UIViewController
@property(nonatomic,strong)BaseModel * baseModel;
@property(nonatomic,strong)CommentModel * cModel;
@end
