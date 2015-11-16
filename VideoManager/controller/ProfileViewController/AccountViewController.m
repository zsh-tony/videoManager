//
//  AccountViewController.m
//  VideoManager
//
//  Created by lerrruby on 15/10/22.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountCell.h"
@interface AccountViewController ()
{
    NSMutableArray *myOrderRecords;
}
@end

@implementation AccountViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.标题
    self.title = @"我的订单";
    myOrderRecords = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.backgroundColor = kGetColor(250, 255, 230);
    [self.view addSubview:self.tableView];
    
//    NSURLRequest *request = [NSURLRequest requestWithPath:@"person" params:@{@"type":@"getaccount",@"uAccount":@"u110000111" }];
//    NSLog(@"%@",request);
//    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [OrderRecordTool  success:^(NSMutableArray *OrderRecords) {
       
        for(OrderRecord *m in OrderRecords){
            NSLog(@"%@",m.date);
        }
        
        [myOrderRecords addObjectsFromArray:OrderRecords];
        
        [self.tableView reloadData];
        
        
    } fail:^{

    } path:@"person"];

}




- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse
{
    NSLog(@"sdfsfdsfsd");
}
// 你可以在里面判断返回结果, 或者处理返回的http头中的信息

// 每收到一次数据, 会调用一次
- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data
{
    //        NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responesStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@----%@",teststr1,teststr);
    NSLog(@"responeStr======%@",responesStr);
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return myOrderRecords.count;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    headView.backgroundColor = [UIColor redColor];
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, 30)];
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    titleView.text = @"    我的交易记录";
    [headView addSubview:titleView];
    
    
    return headView;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return  50;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier1 = @"Cell";
    AccountCell *myCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (myCell == nil) {
        myCell = [[AccountCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
    }
    myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    OrderRecord *o = [myOrderRecords objectAtIndex:indexPath.row];
    myCell.dateLabel.text = o.date;
    myCell.moneyLabel.text = [NSString stringWithFormat:@"充值%@",o.money];
    myCell.typeLabel.text = [o.paytype isEqualToString:@"0"]?@"用于购买会员":@"用于购买咨询豆";
    //myCell.imageView.image = [UIImage imageNamed:@"我的资料.png"];
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
