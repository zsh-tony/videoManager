//
//  CTFrameParser.m
//  CoreTextDemo
//
//  Created by lerrruby on 15/7/10.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "CTFrameParser.h"
#import "CoreTextImageData.h"

static CGFloat ascentCallback(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}

static CGFloat descentCallback(void *ref){
    return 0;
}

static CGFloat widthCallback(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

@implementation CTFrameParser
+(NSMutableDictionary *)attributesWithConfig:(CTFrameParserConfig*)config
{
    CGFloat fontSize=config.fontSize;
    NSString *fontType = config.fontType;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)fontType, fontSize, NULL);
    CGFloat lineSpacing = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings ]={
        {
            kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpacing
        },
        {
            kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpacing
        },
        {
            kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpacing
        }
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    UIColor *textColor = config.textColor;
    
    NSMutableDictionary*dict = [NSMutableDictionary dictionary];
    if (textColor) {
         dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    }
   
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dict;
    
    
}

+(CTFrameRef)creatFrameWithFramesetter:(CTFramesetterRef)framesetter
                                config:(CTFrameParserConfig*)config
                                height:(CGFloat)height
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
    
}

+(CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config
{
    NSDictionary *attributes =[self attributesWithConfig:config];
    NSAttributedString *contentString = [[NSAttributedString alloc]initWithString:content attributes:attributes];
   return  [self parseAttributedContent:contentString config:config];
    
}
+(CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    CTFrameRef frame = [self creatFrameWithFramesetter:framesetter config:config height:textHeight];
    
    CoreTextData *data = [[CoreTextData alloc]init];
    data.ctFrame = frame;
    data.height = textHeight;
    return  data;
}

+(CoreTextData*)parseTemplateFile:(NSString*)path config:(CTFrameParserConfig*)config
{
    NSMutableArray *imageArray = [NSMutableArray array];
    
    NSMutableAttributedString *content = [self loadTemplateFile:path config:config imageArray:imageArray];

    CoreTextData *data = [self parseAttributedContent:content config:config];
    data.imageArray = imageArray;
    
    return data;
}

+(NSMutableAttributedString*)loadTemplateFile:(NSString*)path config:(CTFrameParserConfig*)config imageArray:(NSMutableArray *)imageArray
{
    NSData*data = [NSData dataWithContentsOfFile:path];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]init];
    
    if (data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if ([array isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in array) {
                NSString *type = dict[@"type"];
                if ([type isEqualToString:@"txt"]) {
                    NSAttributedString *sa = [self parseAttributedContentFromNSDictionary:dict config:config];
                    [result appendAttributedString:sa];
                }else if([type isEqualToString:@"img"]){
                    CoreTextImageData *imageData = [[CoreTextImageData alloc]init];
                    imageData.name = dict[@"name"];
                    imageData.position = [result length];
                    [imageArray addObject:imageData];
                  NSAttributedString *as=  [self parseImageDataFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                }
            }
        }
    }
    return result;
    
}

+(NSAttributedString *)parseImageDataFromNSDictionary:(NSDictionary *)dict
                                               config:(CTFrameParserConfig *)config
{
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void*)(dict));
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc]initWithString:content attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return space;
}

+(NSAttributedString*)parseAttributedContentFromNSDictionary:(NSDictionary*)dict
                                                      config:(CTFrameParserConfig*)config
{
    NSMutableDictionary *attributes= [self attributesWithConfig:config];
    UIColor *color =[self colorFromTemplate: dict[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
        
    }
    CGFloat fontSize = [dict[@"size"]floatValue];
    NSString *fontType = dict[@"font"];
    if (fontType == nil) fontType = config.fontType;
    if (fontSize <0) fontSize = config.fontSize;
   
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)fontType, fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    
    NSString *content = dict[@"content"];
    return [[NSAttributedString alloc]initWithString:content attributes:attributes];
}

+(UIColor *)colorFromTemplate:(NSString *)name
{
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    }else if([name isEqualToString:@"red"]){
        return [UIColor redColor];
    }else if([name isEqualToString:@"black"]){
        return [UIColor blackColor];
    }else if([name isEqualToString:@"white"]){
        return [UIColor whiteColor];
    }else{
        return nil;
    }
}

@end
