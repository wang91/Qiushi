//
//  ViewController.m
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "CommentViewController.h"
#import "ViewController1.h"
#import "CommentModel.h"
#import "BaseModel.h"
#import "BaseCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,BaseCellDelegate>
{
    NSMutableArray * _dataArr;
    UITableView    * _tableView;
    MJRefreshHeaderView * _headerView;
    MJRefreshFooterView * _footerView;
    NSInteger  _pageNumber;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"糗事百科";
    _dataArr=[NSMutableArray arrayWithCapacity:0];
    _pageNumber=1;
    //创建界面
    [self creatUI];
    //加载数据
    [self loadDataWithPage:@"1" isRemoved:NO];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ss:) name:@"123" object:nil];
}
-(void)ss:(NSNotification *)noti{
    CommentModel * model=[[CommentModel alloc]init];
    model=noti.object;
    BaseModel * model1=[[BaseModel alloc]init];
    model1.comments_count=[NSString stringWithFormat:@"%d",[model.floor intValue]];
    
   
    [_tableView reloadData];
}

#pragma mark - 创建界面
-(void)creatUI{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, LFScreenWidth, LFScreenHeight)style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;

    [self.view addSubview:_tableView];
    _headerView=[MJRefreshHeaderView header];
    _footerView=[MJRefreshFooterView footer];
    _headerView.delegate=self;
    _footerView.delegate=self;
    _headerView.scrollView=_tableView;
    _footerView.scrollView=_tableView;

}
#pragma mark - TableView 的代理
#pragma mark  行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
#pragma mark  Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCell * cell=[BaseCell baseCellWithTableView:tableView];
    cell.baseModel=_dataArr[indexPath.row];
    cell.delegate=self;
    return cell;
}
#pragma mark Cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_dataArr[indexPath.row] cellHeight];
}
#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentViewController * cvc=[[CommentViewController alloc]init];
    cvc.model=_dataArr[indexPath.row];
    [self.navigationController pushViewController:cvc animated:YES];
}
#pragma mark - 加载数据
-(void)loadDataWithPage:(NSString *)number isRemoved:(BOOL)isRemoved{
       NSString * urlStr=@"http://m2.qiushibaike.com/article/list/text?page=%d&count=30";
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlStr,[number integerValue]]]];
    //底层发送异步请求,放在主线程当中（mainQueue）
    [NSURLConnection sendAsynchronousRequest:request queue: [NSOperationQueue mainQueue]completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){//失败
            NSLog(@"%@",connectionError.localizedDescription);
        }else{//成功
            if (isRemoved) {
                [_dataArr removeAllObjects];
            }
      id backData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",backData);
            NSArray * itemsArr=backData[@"items"];
            for (NSDictionary * dict in itemsArr) {
                BaseModel * model=[[BaseModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArr addObject:model];
            }
            [_headerView endRefreshing];
            [_footerView endRefreshing];
            

            [_tableView reloadData];
        }
    }];
}
#pragma mark -  MJRefresh代理
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    NSLog(@"开始刷新啦");
    if (refreshView == _headerView) { // 下拉刷新
        [self loadDataWithPage:@"1" isRemoved:YES];
    } else { // 上拉加载更多
        _pageNumber++;
        [self loadDataWithPage:[NSString stringWithFormat:@"%li", _pageNumber] isRemoved:NO];
        NSLog(@"feffg:%ld",_pageNumber);
    }

   }
-(void)BaseCellCommentClicked:(BaseModel *)model{
    if ([model.comments_count integerValue]) {
        CommentViewController * cvc=[[CommentViewController alloc]init];
        cvc.model=model;
        [self.navigationController pushViewController:cvc animated:YES];

    }else{
    ViewController1 * vc1=[[ViewController1 alloc]init];
        vc1.baseModel=model;
        [self.navigationController pushViewController:vc1 animated:YES];
    }
}
@end
