//
//  PayView.h
//  VideoManager
//
//  Created by lerrruby on 15/11/8.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BtnOrder.h"
@interface PayView : UIView
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *descriLabel;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UILabel *typeTitle;
@property (nonatomic,strong)UILabel *descriTitle;
@property (nonatomic,strong)UILabel *moneyTitle;
@property (nonatomic,strong)BtnOrder *payBtn;
@property (nonatomic,strong)Order *order;
@property (nonatomic,strong)UIButton *backBtn;
- (id)initWithFrame:(CGRect)frame WithOrder:(Order*)order;
@end
