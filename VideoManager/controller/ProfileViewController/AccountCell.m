//
//  AccountCell.m
//  VideoManager
//
//  Created by lerrruby on 15/11/8.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "AccountCell.h"

@implementation AccountCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 80, 30)];
        _dateLabel.font = k13Font;
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = kTitleColor;
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_dateLabel];
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 7, 80, 30)];
        _moneyLabel.font = k13Font;
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.textColor = kTitleColor;
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_moneyLabel];
        
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(190, 7, 100, 30)];
        _typeLabel.font = k13Font;
        _typeLabel.text = @"dsfsdf";
        _typeLabel.backgroundColor = [UIColor clearColor];
        _typeLabel.textColor = kTitleColor;
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_typeLabel];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
