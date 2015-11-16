//
//  CTFrameParserConfig.h
//  CoreTextDemo
//
//  Created by lerrruby on 15/7/9.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//


@interface CTFrameParserConfig : NSObject
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat fontSize;
@property (nonatomic,assign)CGFloat lineSpace;
@property (nonatomic,strong)UIColor *textColor;
@property (nonatomic,strong)NSString *fontType;
@end
