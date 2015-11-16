//
//  UIlabelCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-5-8.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "UIlabelCell.h"
#define kTitleHeight 20
#define kTitileWidth 60
#define kContentWidth 200
@implementation UIlabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake1(k10WidthMargin, k10HeightMargin, kTitileWidth, kTitleHeight)];
        _titleLabel.font = k13Font;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = kTitleColor;
        [self.contentView addSubview:_titleLabel];

        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x+_titleLabel.frame.size.width +k10WidthMargin*kAutoSizeScaleX, k10HeightMargin*kAutoSizeScaleY, kContentWidth*kAutoSizeScaleX, kTitleHeight*kAutoSizeScaleY)];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = k13Font;
        [self.contentView addSubview:_contentLabel];
        
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
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
