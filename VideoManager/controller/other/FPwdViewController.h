//
//  FPwdViewController.h
//  VideoManager
//
//  Created by lerrruby on 15/10/25.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPwdViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UILabel *phonePlaceholder;
@property (nonatomic,strong)UILabel *note;
@property (nonatomic,strong)UIButton *loginBtn;

@end
