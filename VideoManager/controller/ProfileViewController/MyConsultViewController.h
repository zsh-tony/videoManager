//
//  MyConsultViewController.h
//  VideoManager
//
//  Created by lerrruby on 15/11/7.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyConsultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end
