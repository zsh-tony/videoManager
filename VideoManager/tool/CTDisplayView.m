//
//  CTDisplayView.m
//  CoreTextDemo
//
//  Created by lerrruby on 15/7/9.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreTextImageData.h"
@implementation CTDisplayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code、
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
        for (CoreTextImageData * imageData in self.data.imageArray) {
            UIImage *image = [UIImage imageNamed:imageData.name];
            if (image) {
                CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
            }
        }
    }
    
    
}
@end
