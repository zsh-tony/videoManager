//
//  MyVideoViewController.m
//  VideoManager
//
//  Created by lerrruby on 15/11/7.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "MyVideoViewController.h"
#import "Move.h"
#import "MJRefresh.h"
#import "VideoPlayViewController.h"
@interface MyVideoViewController ()<MJRefreshBaseViewDelegate>
{
    MJRefreshHeaderView *header;
    MJRefreshFooterView *footer;
    NSMutableArray *myMoves;
    __block int pageId;
}


@end

@implementation MyVideoViewController

-(void)dealloc
{
    [header free];
    [footer free];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.标题
    self.title = @"我的视频";
    pageId = 0;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.backgroundColor = kGetColor(250, 255, 230);
    [self.view addSubview:self.tableView];
    header = [[MJRefreshHeaderView alloc]init];
    header.scrollView = self.tableView;
    //header.beginRefreshingBlock = ^(MJRefreshBaseView *view){
    //NSLog(@"fdsf");
    // };
    //[header beginRefreshing];//原因在于此时代理还没有设置，所以出错了
    header.delegate = self;
    [header beginRefreshing];
    footer = [[MJRefreshFooterView alloc]init];
    //    footer.beginRefreshingBlock = ^(MJRefreshBaseView *view){
    //        NSLog(@"dgdhdh");
    //    };
    footer.delegate = self;
    footer.scrollView = self.tableView;
    NSURLRequest *request = [NSURLRequest requestWithPath:@"person" params:@{@"type":@"getmovies",@"uAccount":@"13080908250",@"page":@"1" }];

  
}


-(void)refreshData
{
    NSString *page = [NSString stringWithFormat:@"%d",pageId+1];
    [MoveTool pageId:page success:^(NSMutableArray *moves) {
        pageId +=1;
        for(Move *m in moves){
            NSLog(@"%@",m.pic);
        }
       
        [moves addObjectsFromArray:myMoves];
        myMoves = moves;

        [self.tableView reloadData];
        
        [header endRefreshing];

        
        NSLog(@"%@",moves);
    } fail:^{
        [header endRefreshing];
    } path:@"person"];
    
    
}
-(void)loadData
{
    NSString *page = [NSString stringWithFormat:@"%d",pageId-1];
    [MoveTool pageId:page success:^(NSMutableArray *moves) {
        pageId -=1;
        for(Move *m in moves){
            NSLog(@"%@",m.pic);
        }
        
        [myMoves addObjectsFromArray:moves];

        [self.tableView reloadData];
        
        [footer endRefreshing];
        
        
        NSLog(@"%@",moves);
    } fail:^{
        [footer endRefreshing];
    } path:@"person"];
    
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView//协议名称一般不包括前缀
{
    if (header ==refreshView) {
        [self refreshData];
    }else{
        [self loadData];
    }
    
}

- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse
{
    NSLog(@"sdfsfdsfsd");
}
// 你可以在里面判断返回结果, 或者处理返回的http头中的信息

// 每收到一次数据, 会调用一次

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return myMoves.count;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   
     return @"视频浏览记录";
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoPlayViewController *video = [[VideoPlayViewController alloc]init];
    video.movieUrl = [[NSString stringWithFormat:@"http://www.fhzpt.com:8082/EnterClinic/bofang?movieId=%@&type=showMovie&uAccount=%@",[myMoves[indexPath.row] mId],kselfUser.uAccount]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
    [self.navigationController pushViewController:video animated:YES];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier1 = @"Cell";
    UITableViewCell *myCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (myCell == nil) {
        myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle                   reuseIdentifier:CellIdentifier1] ;
    }
    myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    Move *m = myMoves[indexPath.row];
    myCell.textLabel.text = m.title;
    myCell.detailTextLabel.text = m.introduce;
    NSString *urlStr = [NSString stringWithFormat:@"Http://www.fhzpt.com:8082/EnterClinic/thrumbs/%@",m.pic];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [myCell.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"我的资料.png"]];
    CGSize itemSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [myCell.imageView.image drawInRect:imageRect];
    
    myCell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myCell;
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
