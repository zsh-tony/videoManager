//
//  MyConsultViewController.m
//  VideoManager
//
//  Created by lerrruby on 15/11/7.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "MyConsultViewController.h"

@interface MyConsultViewController ()

@end

@implementation MyConsultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.标题
    self.title = @"我的咨询师";

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.backgroundColor = kGetColor(250, 255, 230);
    [self.view addSubview:self.tableView];
    
    NSURLRequest *request = [NSURLRequest requestWithPath:@"person" params:@{@"type":@"getcounselor",@"uAccount":@"u110000111" }];
    NSLog(@"%@",request);
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    

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
    return 4;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 220)];
    headView.backgroundColor = [UIColor whiteColor];
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
    titleView.image = [UIImage imageNamed:@"bgView.png"];
    [headView addSubview:titleView];
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 95, 50, 50)];
    iconView.image = [UIImage imageNamed:@"iconImage.png"];
    [headView addSubview:iconView];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 40, 20)];
    titleLabel.text = [AccountTool sharedAccountTool].myUser.uNick;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [titleLabel sizeToFit];
    [headView addSubview:titleLabel];

    UILabel *subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 130, 40, 20)];
    subTitleLabel.text = @"咨询总数:1名";
    subTitleLabel.textColor = [UIColor lightGrayColor];
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    [subTitleLabel sizeToFit];
    [headView addSubview:subTitleLabel];
    
    
    
    UILabel *subL = [[UILabel alloc]initWithFrame:CGRectMake(0, 145, 320, 35)];
    subL.text = @"      谁能像优乐美一样把我捧在手心，我就。。。。。";
    subL.textColor = [UIColor lightGrayColor];
    subL.textAlignment = NSTextAlignmentLeft;
    subL.font = [UIFont systemFontOfSize:12];
    subL.backgroundColor = [UIColor whiteColor];
    [headView addSubview:subL];
    
    UIView *sepV = [[UIView alloc]initWithFrame:CGRectMake(30, 146, 260, 0.5)];
    sepV.backgroundColor = [UIColor lightGrayColor];
    [headView addSubview:sepV];
    
    UILabel *theme =[[UILabel alloc]initWithFrame:CGRectMake(0, 180, 320, 40)];
    theme.text = @"      ta咨询过的咨询师";
    theme.textColor = [UIColor lightGrayColor];
    theme.textAlignment = NSTextAlignmentLeft;
    theme.font = [UIFont systemFontOfSize:12];
    theme.backgroundColor = kGetColor(250, 255, 230);
    [headView addSubview:theme];
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
 
        return 220;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *CellIdentifier1 = @"Cell";
        UITableViewCell *myCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (myCell == nil) {
            myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
        }
        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        myCell.textLabel.text = @"jsdsodso";
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
