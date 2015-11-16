//
//  DiscoverViewController.m
//  Stranger-Social
//
//  Created by lerrruby on 15/5/21.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "ConsultViewController.h"
#import "User.h"
#import "MJRefreshHeaderView.h"
#import "TitleButton.h"
@interface ConsultViewController ()<UIWebViewDelegate>
{
    
    UIWebView *webView;
    NSURLRequest *request;
    TitleButton *titleBtn;
}


@end

@implementation ConsultViewController
- (void)viewWillAppear:(BOOL)animated
{
    if (webView != nil&&request != nil) {
        [webView loadRequest:request];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"咨询师";
   
  webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 108)];
    webView.delegate = self;
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.fhzpt.com:8082/EnterClinic/CounselorIndex?account=13080908250"]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    titleBtn = [[TitleButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44) WithTitle:@"咨询师"];
    self.navigationItem.titleView = titleBtn;
    [titleBtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
}
-(void)refresh
{
    [webView reload];
}
//-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView//协议名称一般不包括前缀
//{
//    [webView reload];
//    
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//    
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return self.view.frame.size.height;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    static NSString *CellIdentifier1 = @"Cell";
//    UITableViewCell *myCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
//    if (myCell == nil) {
//        myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
//    }
//    myCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    //        myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    [myCell.contentView addSubview:webView];
//    return myCell;
//    
//    
//}
#pragma mark - UIWebViewDelegate的实现
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    //display the state of loading
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeNone];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //alter the icon to reflesh
   // [header endRefreshing];
    [SVProgressHUD dismiss];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载出错%@", [error localizedDescription]);
    //    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络加载失败"
    //                                                    message:nil
    //                                                   delegate:self
    //                                          cancelButtonTitle:@"再试一次"
    //                                          otherButtonTitles:@"取消",nil];
    //    [alert show];
    [SVProgressHUD dismiss];
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //if you click the button of trying again
    if (buttonIndex==0) {
        [webView loadRequest:request];
    }
    
    [SVProgressHUD dismiss];
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
