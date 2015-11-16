//
//  DiscoverViewController.m
//  Stranger-Social
//
//  Created by lerrruby on 15/5/21.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "ForumViewController.h"
#import "User.h"
#import "TitleButton.h"
@interface ForumViewController ()<UIWebViewDelegate>
{
    
    UIWebView *webView;
    NSURLRequest *request;
    TitleButton *titleBtn;
}
@end

@implementation ForumViewController
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
    self.title = @"论坛";
    self.navigationItem.titleView = self.view;
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 108)];
    webView.delegate = self;
    [self.view addSubview:webView];
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.fhzpt.com:8082/EnterClinic/forumIndex?account=13080908250"]];
    [webView loadRequest:request];
    titleBtn = [[TitleButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44) WithTitle:@"论坛"];
    self.navigationItem.titleView = titleBtn;
    [titleBtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
//    UIToolbar *tabbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 416, 320, 44)];
//    tabbar.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background.png"]];;
//    [self.view addSubview:tabbar];
//    UIBarButtonItem *forwardItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forward)];
//    UIBarButtonItem *rewindItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(rewind)];
//   UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
//    tabbar.items = @[rewindItem,forwardItem,spaceItem,refreshItem];
}
-(void)refresh
{
    [webView reload];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}
#pragma mark - UIWebViewDelegate的实现
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    //display the state of loading
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeNone];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //alter the icon to reflesh
    
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
