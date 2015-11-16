//
//  VideoPlayViewController.m
//  VideoManager
//
//  Created by lerrruby on 15/11/14.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "VideoPlayViewController.h"
#import "User.h"
@interface VideoPlayViewController ()<UIWebViewDelegate>
{
    
    UIWebView *webView;
    NSURLRequest *request;
}


@end

@implementation VideoPlayViewController

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
    self.title = @"我的视频";
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height )];
    webView.delegate = self;
    [self.view addSubview:webView];
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.movieUrl]];
    [webView loadRequest:request];


}
-(void)stop
{
    [webView stopLoading];
}
-(void)forward
{
    [webView goForward];
}
-(void)rewind
{
    [webView goBack];
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
