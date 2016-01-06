//
//  CommentViewController.m
//  QiuShi
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommentViewController.h"
#import "ViewController1.h"
#import "BaseModel.h"
#import "BaseCell.h"
#import "CommentModel.h"
#import "CommentCell.h"
@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,BaseCellDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    MJRefreshHeaderView * _headerView;
    MJRefreshFooterView * _footerView;
    NSInteger  _pageNumber;
    
}
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"评论详情";
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

    _model.comments_count=[NSString stringWithFormat:@"%d",[model.floor intValue]];
    
    [_dataArr addObject:model];
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
    return _dataArr.count+1;
}
#pragma mark  Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0==indexPath.row) {
    BaseCell * cell=[BaseCell baseCellWithTableView:tableView];
    cell.baseModel=_model;
        cell.delegate=self;
        return cell;
    }else{
        CommentCell * cell=[CommentCell commentCellWithTableView:tableView];
        cell.model=_dataArr[indexPath.row-1];
        return cell;
    }
}
#pragma mark Cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0==indexPath.row) {
        return [_model cellHeight];
    }else{
    return [_dataArr[indexPath.row-1] cellHeight];
    }
}
-(void)loadDataWithPage:(NSString *)number isRemoved:(BOOL)isRemoved{
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m2.qiushibaike.com/article/%@/comments?page=%@&count=30",_model.id,number]]];
    //底层发送异步请求,放在主线程当中（mainQueue）
    [NSURLConnection sendAsynchronousRequest:request queue: [NSOperationQueue mainQueue]completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){//失败
            [_headerView endRefreshing];
            [_footerView endRefreshing];
            NSLog(@"%@",connectionError.localizedDescription);
        }else{//成功
            id backData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",backData);
            if (isRemoved) {
                [_dataArr removeAllObjects];
            }
            NSArray * itemsArr=backData[@"items"];
            for (NSDictionary * dict in itemsArr) {
                CommentModel * model=[[CommentModel alloc]init];
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
        NSLog(@"feffg:%ld",_pageNumber);
        [self loadDataWithPage:[NSString stringWithFormat:@"%li", _pageNumber] isRemoved:NO];
    }
    
}

-(void)dealloc{
    [_headerView removeFromSuperview];
    [_footerView removeFromSuperview];
}
-(void)BaseCellCommentClicked:(BaseModel *)model{
    ViewController1 * vc1=[[ViewController1 alloc]init];
    vc1.baseModel=model;
    [self.navigationController pushViewController:vc1 animated:YES];
}

@end
