//
//  CTFrameParserConfig.m
//  CoreTextDemo
//
//  Created by lerrruby on 15/7/9.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig
- (id)init
{
    self = [super init];
    if (self) {
        _width = 285.0f*kAutoSizeScaleX;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _fontType = @"ArialMT";
        //_textColor = RGB()
        
    }
    return self;
}
@end
