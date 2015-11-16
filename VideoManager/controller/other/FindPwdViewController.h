//
//  FindPwdViewController.h
//  VideoManager
//
//  Created by lerrruby on 15/10/25.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPwdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)void (^passPhone) (NSString *phone);
@end
