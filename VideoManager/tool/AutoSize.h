//
//  AutoSize.h
//  Stranger-Social
//
//  Created by lerrruby on 15/8/14.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface AutoSize : NSObject
singleton_interface(AutoSize)

@property   CGFloat autoSizeScaleX;
@property   CGFloat autoSizeScaleY;
-(AutoSize *)getAutoSize;
@end
