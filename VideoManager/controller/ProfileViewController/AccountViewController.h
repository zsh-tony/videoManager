//
//  AccountViewController.h
//  VideoManager
//
//  Created by lerrruby on 15/10/22.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;

@end
