//
//  CoreTextImageData.h
//  CoreTextDemo
//
//  Created by lerrruby on 15/7/10.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextImageData : NSObject
@property (strong, nonatomic) NSString * name;
@property (nonatomic) int position;

// 此坐标是 CoreText 的坐标系，而不是UIKit的坐标系
@property (nonatomic) CGRect imagePosition;
@end
