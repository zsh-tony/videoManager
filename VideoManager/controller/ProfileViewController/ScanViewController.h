//
//  ScanViewController.h
//  VideoManager
//
//  Created by lerrruby on 15/11/8.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBarSDK.h"
@interface ScanViewController : UIViewController<ZBarReaderViewDelegate,ZBarReaderDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (strong, nonatomic) ZBarReaderView *readerView;
@property (strong, nonatomic) ZBarCameraSimulator *cameraSim;
@end
