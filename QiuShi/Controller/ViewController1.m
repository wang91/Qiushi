//
//  ViewController1.m
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController1.h"
#import "CommentModel.h"
#import "BaseModel.h"
@interface ViewController1 ()<UITextFieldDelegate>
{
    UITextField * _tf;
}
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发表评论";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent=NO;
    UIBarButtonItem * button=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClicked)];
    self.navigationItem.rightBarButtonItem=button;
    
    
    
    [self creatTextFiled];
    
    //监听文本框键盘的弹出。收起的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)creatTextFiled{
    UITextField * tf=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, LFScreenWidth-20, 300)];
    tf.backgroundColor=[UIColor orangeColor];
    tf.borderStyle=UITextBorderStyleRoundedRect;
    tf.placeholder=@"请写评论。。。。";
    tf.delegate=self;
    tf.returnKeyType=UIReturnKeyDone;
   
    tf.contentVerticalAlignment=1;
    tf.textAlignment=NSTextAlignmentLeft;
    
   
    [self.view addSubview:tf];
    _tf=tf;
}
-(void)keyboardWillShow:(NSNotification *)noti{
    NSLog(@"键盘弹出");
    NSDictionary * dic1 =noti.userInfo;
    CGRect keyboardframe=[dic1[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    NSLog(@"%@",NSStringFromCGRect(keyboardframe));
    NSTimeInterval duration=[dic1[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    NSLog(@"%f",duration);
}
-(void)keyboardWillHide:(NSNotification *)noti{
    NSLog(@"键盘收起");
    NSDictionary * dic2 =noti.userInfo;
    NSTimeInterval duration=[dic2[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    NSLog(@"%f",duration);
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     [self.view endEditing:YES];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"开始编辑");
    
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)buttonClicked{
    _cModel=[[CommentModel alloc]init];
    [_cModel.user setValue:@"user" forKey:@"login"];
    _cModel.content=_tf.text;
    int a=[self.baseModel.comments_count intValue];
    _cModel.floor=[NSString stringWithFormat:@"%d",a+1];
    NSLog(@"ewewe:%@",_cModel.floor);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"123" object:_cModel];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
