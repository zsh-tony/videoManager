//
//  UIView+frameAdjust.h
//  CoreTextDemo
//
//  Created by lerrruby on 15/7/9.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frameAdjust)
- (CGPoint)origin;
- (void)setOrigin:(CGPoint) point;

- (CGSize)size;
- (void)setSize:(CGSize) size;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)tail;
- (void)setTail:(CGFloat)tail;

- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

- (CGFloat)right;
- (void)setRight:(CGFloat)right;

@end
