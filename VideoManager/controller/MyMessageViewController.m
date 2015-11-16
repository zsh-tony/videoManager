//
//  MyMessageViewController.m
//  VideoManager
//
//  Created by lerrruby on 15/11/15.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "MyMessageViewController.h"
#import "User.h"
@interface MyMessageViewController ()

@end

@implementation MyMessageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.标题
    self.title = @"我的消息";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.backgroundColor = kGetColor(250, 255, 230);
    [self.view addSubview:self.tableView];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    headView.backgroundColor = [UIColor redColor];
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, 30)];
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    titleView.text = @"    我的消息";
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
    UITableViewCell *myCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (myCell == nil) {
        myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
    }
    myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    User *u= kselfUser;
    NSLog(@"%@",u.leftDay);
    myCell.textLabel.text = [NSString stringWithFormat:@"您的会员天数还剩下%@天",kselfUser.leftDay];
   
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
