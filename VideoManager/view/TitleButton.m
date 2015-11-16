//
//  TitleButton.m
//  VideoManager
//
//  Created by lerrruby on 15/11/15.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton


#define kImageRatio 0.7

- (id)initWithFrame:(CGRect)frame WithTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //1.设置文字属性
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 ];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        //2.设置图片属性
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = NO;
        [self setImage:[UIImage imageNamed:@"刷新.png"] forState:UIControlStateNormal];
  
    }
    return self;
}
//重写父类的方法可以去掉某些从父类继承来的不想要的设置
-(void)setHighlighted:(BOOL)highlighted
{
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
//返回的是按钮内部UILabel的边框，这个UILabel是和button的title相关的
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{

     return  CGRectMake(0, 0, contentRect.size.width*kImageRatio, contentRect.size.height);
}

//返回的是按钮内部的UIImageview的边框，和按钮的image相关
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
       return CGRectMake( contentRect.size.width * kImageRatio,13, contentRect.size.width * (1-kImageRatio),contentRect.size.height-26);
}


@end

