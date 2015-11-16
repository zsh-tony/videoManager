//
//  PayView.m
//  VideoManager
//
//  Created by lerrruby on 15/11/8.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "PayView.h"

@implementation PayView
- (id)initWithFrame:(CGRect)frame WithOrder:(Order*)order
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.payBtn = [[BtnOrder alloc]initWithFrame:CGRectMake(20, 140, 220, 40)];
        [self.payBtn setTitle:@"支付" forState:UIControlStateNormal];
        self.payBtn.backgroundColor = [UIColor lightGrayColor];
        self.payBtn.order=order;
        [self addSubview:self.payBtn];
        
        self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 7, 60, 30)];
        self.typeLabel.backgroundColor = [UIColor clearColor];
        self.typeLabel.text = @"商品名称:";
        self.typeLabel.font = k13Font;
        self.typeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.typeLabel];
        
        self.typeTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.typeLabel.bounds.size.width+20, 7, self.bounds.size.width-self.typeLabel.bounds.size.width-40, 30)];
        self.typeTitle.backgroundColor = [UIColor clearColor];
        self.typeTitle.text = order.productName;
        self.typeTitle.font = k13BordFont;
        self.typeTitle.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.typeTitle];
        
        self.descriLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 51, 60, 30)];
        self.descriLabel.backgroundColor = [UIColor clearColor];
        self.descriLabel.text = @"商品描述:";
        self.descriLabel.font = k13Font;
        self.descriLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.descriLabel];
        
        self.descriTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.typeLabel.bounds.size.width+20, 51, self.bounds.size.width-self.typeLabel.bounds.size.width-40, 30)];
        self.descriTitle.backgroundColor = [UIColor clearColor];
        self.descriTitle.numberOfLines =3;
        self.descriTitle.text = order.productDescription;
        self.descriTitle.font = k13BordFont;
        self.descriTitle.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.descriTitle];
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 91, 60, 30)];
        self.moneyLabel.backgroundColor = [UIColor clearColor];
        self.moneyLabel.text = @"交易金额:";
        self.moneyLabel.font = k13Font;
        self.moneyLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.moneyLabel];
        
        self.moneyTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.typeLabel.bounds.size.width+20, 91, self.bounds.size.width-self.typeLabel.bounds.size.width-40, 30)];
        self.moneyTitle.backgroundColor = [UIColor clearColor];
        self.moneyTitle.text = [NSString  stringWithFormat:@"%@元",order.amount];
        self.moneyTitle.font = k13BordFont;
        self.moneyTitle.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.moneyTitle];
        
        self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 140, 220, 40)];
        
        _backBtn.backgroundColor = [UIColor redColor];

        [self addSubview:_backBtn];
        _backBtn.hidden =YES;
      
    }
    return self;
}
-(void)setOrder:(Order *)order
{
    _order =order;
    self.typeTitle.text = order.productName;
    self.descriTitle.text = order.productDescription;
    self.moneyTitle.text = order.amount;
    self.payBtn.order = order;
}
@end
