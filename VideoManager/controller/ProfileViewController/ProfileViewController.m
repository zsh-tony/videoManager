//
//  ProfileViewController.m
//  weibo
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ProfileViewController.h"
#import "DetailProfileViewController.h"
#import "AlterPwdViewController.h"
#import "MyVideoViewController.h"
#import "MyConsultViewController.h"
#import "AccountViewController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import "WXMediaMessage+messageConstruct.h"
#import "SendMessageToWXReq+requestWithTextOrMediaMessage.h"
#import "Constant.h"
#import "PayView.h"
#import "MainViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ScanViewController.h"
#import "MyMessageViewController.h"

@interface ProfileViewController ()<WXApiManagerDelegate,UIActionSheetDelegate>
{
    LPPopup *popup;
    UIActionSheet  *shareSheet;
    UIActionSheet  *paySheet;
    UIButton *maskView;
    PayView *payView;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.标题
    self.title = @"个人中心";
   
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-108) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.backgroundColor = kGlobalBg;
    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0, self.view.bounds.size.width - 20, 70);
    UIButton *signOut = [UIButton buttonWithType:UIButtonTypeCustom];
    [signOut setAllStateBg:@"common_button_big_red.png"];
    [signOut setTitle:@"注销登录" forState:UIControlStateNormal];
    signOut.frame = CGRectMake(10, 10, self.view.bounds.size.width - 20, 44);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
    [signOut addTarget:self action:@selector(signOut) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:signOut];
    self.tableView.tableFooterView = footer;
    [self.view addSubview:self.tableView];
    
    maskView =[[UIButton alloc]initWithFrame:self.view.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.6;
    [maskView addTarget:self action:@selector(maskBack) forControlEvents:UIControlEventTouchUpInside];
    [WXApiManager sharedManager].delegate = self;
}
-(void)maskBack
{
    [maskView removeFromSuperview];
    if (payView) {
        [payView removeFromSuperview];
    }
}
-(void)signOut
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else{
        
    return 4;
    }
    

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 240)];
    headView.backgroundColor = [UIColor whiteColor];
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    titleView.image = [UIImage imageNamed:@"myTitleView.png"];
    [headView addSubview:titleView];
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 110, 80, 80)];
    iconView.image = [UIImage imageNamed:@"iconImage.png"];
    [headView addSubview:iconView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 320, 50)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"欢迎来到365个人中心";
   
    title.font =  [UIFont fontWithName:@"Helvetica-Bold" size:22];
    [headView addSubview:title];
    
    
    UILabel *nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 120, 40, 15)];
    nickLabel.text = kselfUser.uNick;
    nickLabel.textColor = [UIColor whiteColor];
    nickLabel.textAlignment = NSTextAlignmentLeft;
    nickLabel.font = [UIFont systemFontOfSize:13];
    [nickLabel sizeToFit];
    [headView addSubview:nickLabel];
    
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 141, 50, 15)];
    levelLabel.text = @"会员级别:";
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.textAlignment = NSTextAlignmentLeft;
    levelLabel.font = [UIFont systemFontOfSize:13];
    [levelLabel sizeToFit];
    [headView addSubview:levelLabel];
    
    
    
    UILabel *levelTitle = [[UILabel alloc]initWithFrame:CGRectMake(185, 141, 80, 15)];
    levelTitle.text = [self getVipTypeWith:kselfUser.vipType];
    levelTitle.textColor = [UIColor whiteColor];
    levelTitle.textAlignment = NSTextAlignmentLeft;
    levelTitle.font = [UIFont systemFontOfSize:13];
    levelTitle.backgroundColor = [UIColor clearColor];
    [headView addSubview:levelTitle];
    
    UILabel *leftMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 163, 40, 15)];
    leftMoneyLabel.text = @"咨询豆:";
    leftMoneyLabel.textColor = [UIColor whiteColor];
    leftMoneyLabel.textAlignment = NSTextAlignmentLeft;
    leftMoneyLabel.font = [UIFont systemFontOfSize:13];
    [leftMoneyLabel sizeToFit];
    [headView addSubview:leftMoneyLabel];
    
    
    
    UILabel *leftMoneyTitle = [[UILabel alloc]initWithFrame:CGRectMake(170, 163, 80, 15)];
    leftMoneyTitle.text = [NSString stringWithFormat:@"%d", kselfUser.leftMoney];
    leftMoneyTitle.textColor = [UIColor whiteColor];
    leftMoneyTitle.textAlignment = NSTextAlignmentLeft;
    leftMoneyTitle.font = [UIFont systemFontOfSize:13];
    leftMoneyTitle.backgroundColor = [UIColor clearColor];
    [headView addSubview:leftMoneyTitle];
    
    
    UILabel *theme =[[UILabel alloc]initWithFrame:CGRectMake(0, 200, 320, 30)];
    theme.text = @"  个人中心";
    theme.textColor = [UIColor lightGrayColor];
    theme.textAlignment = NSTextAlignmentLeft;
    theme.font = [UIFont systemFontOfSize:14];
    theme.backgroundColor = kGetColor(245, 245, 245);
    [headView addSubview:theme];
    if (section == 0) {
        return headView;
    }else{
        return nil;
    }
    
    
}
-(NSString*)getVipTypeWith:(VipType)vipType
{
    switch (vipType) {
        case VipTypeMaster:
            return @"应用型会员";
            break;
        case VipTypePrimary:
            return @"体验型会员";
            break;
        case VipTypeStruggle:
            return @"学习型会员";
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"个人中心";
    }else{
        return @"账户中心";
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 230;
    }else{
    return 30;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DetailProfileViewController *detail = [[DetailProfileViewController alloc]init];
            [self.navigationController pushViewController:detail animated:YES];
        }else if (indexPath.row == 1){
            MyConsultViewController *myConsult = [[MyConsultViewController alloc]init];
            [self.navigationController pushViewController:myConsult animated:YES];
        }else if (indexPath.row == 3){
            paySheet = [[UIActionSheet alloc]
                          initWithTitle:@"请选择交易类型"
                          delegate:self
                          cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                          otherButtonTitles:@"购买会员",@"购买咨询豆",nil];
            
            [paySheet showInView:self.view];
        }else if (indexPath.row == 2){
            AccountViewController *myAccount = [[AccountViewController alloc]init];
            [self.navigationController pushViewController:myAccount animated:YES];
        }else if (indexPath.row == 4){
            MyVideoViewController *myVideo = [[MyVideoViewController alloc]init];
            [self.navigationController pushViewController:myVideo animated:YES];
        }
    }else{
        if (indexPath.row == 0) {
            MyMessageViewController *myMessage = [[MyMessageViewController alloc]init];
            [self.navigationController pushViewController:myMessage animated:YES];
        }
        if (indexPath.row == 1) {
            AlterPwdViewController *alter = [[AlterPwdViewController alloc]init];
            [self.navigationController pushViewController:alter animated:YES];
        }
        if (indexPath.row == 3) {
         shareSheet = [[UIActionSheet alloc]
                        initWithTitle:nil
                        delegate:self
                        cancelButtonTitle:@"取消"
                        destructiveButtonTitle:nil
                        otherButtonTitles:@"分享到微信朋友圈",@"分享给微信好友",nil];
            
            [shareSheet showInView:self.view];

        }
        if (indexPath.row == 2) {
            ScanViewController *scan = [[ScanViewController alloc]init];
            [self.navigationController pushViewController:scan animated:YES];
        }
      
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == shareSheet) {
        WXAppExtendObject *ext = [WXAppExtendObject object];
        ext.extInfo = @"程序信息";
        ext.url = @"appUrl";
        ext.fileData = nil;
        
        WXMediaMessage *message = [WXMediaMessage messageWithTitle:@"testXINxi"
                                                       Description:@"testDescri"
                                                            Object:ext
                                                        MessageExt:@"这是第三方带的测试字段"
                                                     MessageAction:@"<action>dotalist</action>"
                                                        ThumbImage:[UIImage imageNamed:@"bgView.png"]
                                                          MediaTag:nil];
        
        if (buttonIndex ==0) {
            SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
                                                           OrMediaMessage:message
                                                                    bText:NO
                                                                  InScene:WXSceneTimeline];
            [WXApi sendReq:req];
        }else if (buttonIndex == 1){
            SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
                                                           OrMediaMessage:message
                                                                    bText:NO
                                                                  InScene:WXSceneSession];
            [WXApi sendReq:req];
        }
 
        
    }else if (actionSheet ==paySheet){
        
          if (buttonIndex ==0) {
              Order *order = [[Order alloc]init];
              order.productName = @"购买会员";
              order.productDescription = @"购买一年会员，在这期间你可以观看任意视频";
              order.body = [NSString stringWithFormat:@"%@|2",[AccountTool sharedAccountTool].myUser.uAccount];
              order.tradeNO = [AccountTool sharedAccountTool].myUser.uAccount;
              order.amount = @"0.01";
              if (!payView) {
                  payView = [[PayView alloc]initWithFrame:CGRectMake(30, 200, 260, 200) WithOrder:order];
              }else{
                  payView.order = order;
              }
              payView.payBtn.hidden=NO;
              payView.backBtn.hidden = YES;
             [payView.payBtn addTarget:self action:@selector(startPay:) forControlEvents:UIControlEventTouchUpInside];
              [[MainViewController sharedMainViewController].view addSubview:maskView];
              [[MainViewController sharedMainViewController].view  addSubview:payView];
        }else if (buttonIndex == 1){
            Order *order = [[Order alloc]init];
            order.productName = @"购买12颗咨询豆";
            order.productDescription = @"每次咨询咨询师需消耗若干咨询豆，以下价格购买12颗";
            order.body = [NSString stringWithFormat:@"%@|2",[AccountTool sharedAccountTool].myUser.uAccount];
            order.tradeNO = [AccountTool sharedAccountTool].myUser.uAccount;
            order.amount = @"0.02";
            if (!payView) {
                payView = [[PayView alloc]initWithFrame:CGRectMake(30, 200, 260, 200) WithOrder:order];
            }else{
                payView.order = order;
            }
            payView.backBtn.hidden = YES;
            payView.payBtn.hidden = NO;
            [payView.payBtn addTarget:self action:@selector(startPay:) forControlEvents:UIControlEventTouchUpInside];
            [[MainViewController sharedMainViewController].view addSubview:maskView];
            [[MainViewController sharedMainViewController].view  addSubview:payView];
        }
        
        
    }
    
}
- (NSString *)generateTradeNO
{
    static int kNumber = 10;
    
    NSString *sourceStr = @"0123456789";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];

    NSString *trimmedString = [strDate stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *trimmedString1 = [trimmedString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *trimmedString2 = [trimmedString1 stringByReplacingOccurrencesOfString:@":" withString:@""];
    [resultStr appendString:trimmedString2];
    return resultStr;
}

-(void)startPay:(BtnOrder *)sender
{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    if (kselfUser.vipType == VipTypePrimary&&[sender.order.productName isEqualToString:@"购买12颗咨询豆"]) {
        [ToastMessage toastMessageWith:@"你现在为体验型会员,请先购买会员再购买咨询豆!"];
    }else{
        NSString *partner = @"2088021691136735";
        NSString *seller = @"87624859@qq.com";
        NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMjWMb7TnK+RqqB50ciCfHTfuw4LBk0mDmeTNgjOHNasUfPPWMVRnx/A+bEjs08x1MXVJS7ImrZdlf2YZ2NxgrzIddiWwfAhFbI6iS37PhgGvhcP0Y1D8iAtXwQaVzhRipEKf9DIKjUEAVneXM6eJzq3uFF1JWz+f+/QzpxjXhbXAgMBAAECgYAE5BJ6DzU1oVqCZfUR6PuW7QvlH6eboV2gcBlUxZA2OiQUx+vlgkNZxp1ODwyC1TfVSYeKSCBcaJMKhfeemFkSrNHNm2MVdJG9Uj0uK+ZF8FfE2fYBvXCjcG7Qgtf/esVjqFoGEpzyrukhEh2FrVboIx6oUUCYb/4yL1f/Os0k4QJBAOt4rFxxE9s9g7Wf2IMd6cTRH1Fm/ur0yjOf4+Wj0PFNFAb0gOoZl/Q66cqTwKlvrwLkVM+IhMbqqO9/YT+j/dsCQQDaWIhtiIt8gouOIl7riwif9673D38JsNgMohoqWn1jTxBNs1gbLKLb1dba6IbClAVJO2AcKcn3pFN3GEgqFUG1AkEAqdMUbG9ZZMuOzFUGcDoIuVwhfDIONCJsGqN8V8i4DvAKO6Hnv+7JeulqaCH717emvy0yRaMuL9BaGrEB0EZT9QJAERnwDYwtSKI85fQBNTedhFH07TrUe2DTeyHTJNATlAykPUG3u+EiHE/CVUDzFRhc1aCF5Y7MV84SD3jiZhFmJQJBAJDlnk/O6v4yB2Fe093kTS3hBVLrc6Mls5pPY2UX9j6NtHX4BNspnmHxGM40QqCVsYyd76CzdY5LldG3/6l7Ve8=";
        /*============================================================================*/
        /*============================================================================*/
        /*============================================================================*/
        
        //partner和seller获取失败,提示
        if ([partner length] == 0 ||
            [seller length] == 0 ||
            [privateKey length] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"缺少partner或者seller或者私钥。"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        Order *order = [[Order alloc] init];
        order.partner = partner;
        order.seller = seller;
        order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
        order.productName = sender.order.productName; //商品标题
        order.productDescription = sender.order.productDescription; //商品描述
        order.amount = sender.order.amount; //商品价格
        order.notifyURL =  @"http:// www.fhzpt.com:8082/EnterClinic/Alipay/notify_url.jsp"; //回调URL
        order.body = sender.order.body;
        
        order.service = @"mobile.securitypay.pay";
        order.paymentType = @"1";
        order.inputCharset = @"utf-8";
        order.itBPay = @"30m";
        order.showUrl = @"m.alipay.com";
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"alipaytest";
        
        //将商品信息拼接成字符串
        NSString *orderSpec = [order description];
        NSLog(@"orderSpec = %@",orderSpec);
        
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        id<DataSigner> signer = CreateRSADataSigner(privateKey);
        NSString *signedString = [signer signString:orderSpec];
        
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
           
                [payView.backBtn addTarget:self action:@selector(payBack) forControlEvents:UIControlEventTouchUpInside];
                payView.backBtn.hidden = NO;
                payView.payBtn.hidden=YES;
                if ([resultDic[@"resultStatus"]isEqualToString:@"9000"]) {
                    [payView.backBtn setTitle:@"交易成功" forState:UIControlStateNormal];
                    
                    NSURLRequest *request = [NSURLRequest requestWithPath:@"ReciAlipay" params:@{@"body":[NSString stringWithFormat:@"\"%@\"",order.body],@"out_trade_no":[NSString stringWithFormat:@"\"%@\"",order.tradeNO] }];
                    
    //                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.fhzpt.com:8082//EnterClinic/ReciAlipay"]];
    //                request.HTTPMethod = @"post";
    //                NSMutableData *data = [[NSMutableData alloc] init];
    //                NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //                [archiver encodeObject:order.tradeNO forKey:@"out_trade_no"];
    //                [archiver encodeObject:order.body forKey:@"body"];
    //                [archiver finishEncoding];
    //                request.HTTPBody = data;
                    NSHTTPURLResponse *response = nil;
                    
                    NSLog(@"pushreq%@",request);
                    
                    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                        if (connectionError==nil) {
                            NSError *pusherror =nil;
                            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                            
                        }
                    }];

                    
                }else if([resultDic[@"resultStatus"]isEqualToString:@"8000"]){
                    [payView.backBtn setTitle:@"交易结果确认中，点击返回" forState:UIControlStateNormal];
                }else{
                    [payView.backBtn setTitle:@"交易失败" forState:UIControlStateNormal];
                }
                
            }];
            
        }

    }
}
-(void)payBack
{
    [payView removeFromSuperview];
    [maskView removeFromSuperview];
}
- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response
{
    if(response.errCode == 0){
        popup = [LPPopup popupWithText:@"分享成功!"];
    }else{
        popup = [LPPopup popupWithText:@"分享失败!"];
    }
    popup.popupColor = [UIColor blackColor];
    popup.alpha = 0.8;
    popup.textColor = [UIColor whiteColor];
    popup.font = kDetailContentFont;
    [popup showInView:self.view
        centerAtPoint:self.view.center
             duration:3
           completion:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *CellIdentifier1 = @"myCell";
            UITableViewCell *myCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (myCell == nil) {
                myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
            }
            myCell.selectionStyle = UITableViewCellSelectionStyleNone;
            myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            myCell.textLabel.text = @"我的资料";
            myCell.imageView.image = [UIImage imageNamed:@"我的资料.png"];
            return myCell;
            
        }else if (indexPath.row == 2){
            static NSString *CellIdentifier1 = @"accountCell";
            UITableViewCell *accountCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (accountCell == nil) {
                accountCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
            }
            accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
            accountCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            accountCell.textLabel.text = @"我的订单";
            accountCell.imageView.image = [UIImage imageNamed:@"我的订单.png"];
            return accountCell;
            
        }else if (indexPath.row == 1){
            static NSString *CellIdentifier2 = @"consultCell";
            UITableViewCell *consultCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (consultCell == nil) {
                consultCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier2] ;
            }
            consultCell.selectionStyle = UITableViewCellSelectionStyleNone;
            consultCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            consultCell.textLabel.text = @"我的咨询师";
            consultCell.imageView.image = [UIImage imageNamed:@"我的咨询师.png"];
            return consultCell;
        }else if (indexPath.row == 3){
            static NSString *CellIdentifier1 = @"payCell";
            UITableViewCell *payCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (payCell == nil) {
                payCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
            }
            payCell.selectionStyle = UITableViewCellSelectionStyleNone;
            payCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            payCell.textLabel.text = @"支付中心";
            payCell.imageView.image = [UIImage imageNamed:@"我的订单.png"];
            return payCell;
            
        }else{
            
            static NSString *CellIdentifier3 = @"videoCell";
            UITableViewCell *videoCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier3];
            if (videoCell == nil) {
                videoCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier3] ;
            }
            videoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            videoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            videoCell.textLabel.text = @"我的视频";
            videoCell.imageView.image = [UIImage imageNamed:@"我的视频.png"];
            return videoCell;
            
        }
    }else{
        if (indexPath.row == 0) {
            static NSString *CellIdentifier4 = @"messageCell";
            UITableViewCell *messageCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier4];
            if (messageCell == nil) {
                messageCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier4] ;
            }
            messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
            messageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            messageCell.textLabel.text = @"我的消息";
            messageCell.imageView.image = [UIImage imageNamed:@"我的消息.png"];
            return messageCell;
            
        }else if (indexPath.row == 1){
            static NSString *CellIdentifier5 = @"pwdCell";
            UITableViewCell *pwdCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier5];
            if (pwdCell == nil) {
                pwdCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier5] ;
            }
            pwdCell.selectionStyle = UITableViewCellSelectionStyleNone;
            pwdCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            pwdCell.textLabel.text = @"修改密码";
            pwdCell.imageView.image = [UIImage imageNamed:@"修改密码.png"];
            return pwdCell;
            
        }else if(indexPath.row == 2){
            static NSString *CellIdentifier6 = @"scanCell";
            UITableViewCell *scanCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier6];
            if (scanCell == nil) {
                scanCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier6] ;
            }
            scanCell.selectionStyle = UITableViewCellSelectionStyleNone;
            scanCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            scanCell.textLabel.text = @"扫一扫";
            scanCell.imageView.image = [UIImage imageNamed:@"扫一扫.png"];
            return scanCell;
            
        }else{
            static NSString *CellIdentifier6 = @"shareCell";
            UITableViewCell *shareCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier6];
            if (shareCell == nil) {
                shareCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier6] ;
            }
            shareCell.selectionStyle = UITableViewCellSelectionStyleNone;
            shareCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            shareCell.textLabel.text = @"分享到微信";
            shareCell.imageView.image = [UIImage imageNamed:@"分享.png"];
            return shareCell;
            
        }
    }
    
}

@end
