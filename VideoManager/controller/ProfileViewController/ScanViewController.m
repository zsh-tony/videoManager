//
//  ScanViewController.m
//  VideoManager
//
//  Created by lerrruby on 15/11/8.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "ScanViewController.h"

@implementation ScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _readerView = [ZBarReaderView new];
     _readerView.frame =self.view.frame;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:_readerView];
    _readerView.readerDelegate = self;
    [_readerView setAllowsPinchZoom:YES];
    ZBarImageScanner *scanner = _readerView.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    if (TARGET_IPHONE_SIMULATOR) {
        _cameraSim = [[ZBarCameraSimulator alloc] initWithViewController:self];
        _cameraSim.readerView = _readerView;
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [_readerView start];

}
-(void)viewDidDisappear:(BOOL)animated
{
    [_readerView stop];
  
}

-(void) readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    NSString *codeData = [[NSString alloc] init];;
    for (ZBarSymbol *sym in symbols) {
        codeData = sym.data;
        break;
    }
//    NSString *urlStr = @"http://www.fhzpt.com:8082/EnterClinic/person";
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
//
//    NSMutableDictionary *dict= [NSMutableDictionary dictionaryWithObject:@"erweima" forKey:@"type"];
//    [dict setObject:codeData forKey:@"2dcodes"];
//    [dict setObject:kselfUser.uAccount forKey:@"uAccount"];
//    NSLog(@"%@",dict);
//    NSLog(@"%hhd",[NSJSONSerialization isValidJSONObject:dict]);
//    NSError *jsonWriteError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&jsonWriteError];
//    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
////    NSMutableData *data = [[NSMutableData alloc] init];
////    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
////    [archiver encodeObject:@"erweima" forKey:@"type"];
////    [archiver encodeObject:codeData forKey:@"2dcodes"];
////    [archiver encodeObject:kselfUser.uAccount forKey:@"uAccount"];
////    [archiver finishEncoding];
//    request.HTTPBody = jsonData;
//    request.HTTPMethod= @"post";
    
    NSString *urlStr= [NSString stringWithFormat:@"http://www.fhzpt.com:8082/EnterClinic/person?2dcodes=%@&uAccount=%@&type=erweima",codeData,kselfUser.uAccount];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    //NSURLRequest *request = [NSURLRequest requestWithPath:@"person" params:@{@"uAccount":kselfUser.uAccount,@"2dcodes": codeData,@"type":@"erweima"                                               }];
 [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeNone];
    NSHTTPURLResponse *response = nil;
    
    NSLog(@"pushreq%@",request);
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError==nil) {
            NSError *pusherror =nil;
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            [SVProgressHUD dismiss];
            if (str) {
                UIAlertView *alterView;
                switch ([str intValue]) {
                    case 0:
                        alterView = [[UIAlertView alloc]initWithTitle:nil message:@"二维码失效" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
                        break;
                    case 1:
                         alterView = [[UIAlertView alloc]initWithTitle:nil message:@"成功购买会员，感谢您的支持" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
                        break;
                    case 2:
                         alterView = [[UIAlertView alloc]initWithTitle:nil message:@"您还没购买会员，请先购买会员！" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
                       
                        break;
                    case 3:
                         alterView = [[UIAlertView alloc]initWithTitle:nil message:@"二维码解析错误" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
                        break;
                    case 4:
                         alterView = [[UIAlertView alloc]initWithTitle:nil message:@"成功购买咨询豆" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
                        break;
                }
                [alterView show];
            }
        }else{
             [SVProgressHUD dismiss];
            [ToastMessage toastMessageWith:@"网络错误"];
        }
    }];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 得到条形码结果
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    //获得到条形码
    //NSString *dataNum=symbol.data;
    //扫描界面退出
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
       [SVProgressHUD dismiss];
}
@end
