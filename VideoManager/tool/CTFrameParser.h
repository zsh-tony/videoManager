//
//  CTFrameParser.h
//  CoreTextDemo
//
//  Created by lerrruby on 15/7/10.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"
#import "CTFrameParserConfig.h"
@interface CTFrameParser : NSObject
+(CoreTextData*)parseContent:(NSString*)content config:(CTFrameParserConfig*)config;
+(NSMutableDictionary *)attributesWithConfig:(CTFrameParserConfig*)config;
+(CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config;
+(CoreTextData*)parseTemplateFile:(NSString*)path config:(CTFrameParserConfig*)config;
@end
