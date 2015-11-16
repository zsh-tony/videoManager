//
//  CoreTextData.h
//  CoreTextDemo
//
//  Created by lerrruby on 15/7/10.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextData : NSObject
@property (assign,nonatomic)CTFrameRef ctFrame;
@property (assign,nonatomic)CGFloat height;
@property (nonatomic,strong)NSArray *imageArray;
@end
