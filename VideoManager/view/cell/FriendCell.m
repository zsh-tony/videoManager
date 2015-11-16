//
//  FriendCell.m
//  Stranger-Social
//
//  Created by lerrruby on 15/5/27.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake1(10,10,40, 40)];
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.frame.size.width +_iconView.frame.origin.x +7*kAutoSizeScaleX, 10*kAutoSizeScaleY, 100*kAutoSizeScaleX, 40*kAutoSizeScaleY)];
        _titleLabel.font = k15Font;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = kTextColor;
        [self.contentView addSubview:_titleLabel];
        
  
        
    }
    
    return self;
}

CG_INLINE CGRect
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
    
    
    
}

@end
