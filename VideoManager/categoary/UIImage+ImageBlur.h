//
//  UIImage+ImageBlur.h
//  SchoolExpress
//
//  Created by zsh tony on 15-5-9.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageBlur)
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
@end
