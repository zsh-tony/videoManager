//
//  AutoSize.m
//  Stranger-Social
//
//  Created by lerrruby on 15/8/14.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "AutoSize.h"
@interface AutoSize()



@end
@implementation AutoSize
singleton_implementation(AutoSize)
-(AutoSize*)getAutoSize
{
    if (self!= nil) {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        _autoSizeScaleX = myDelegate.autoSizeScaleX;
        _autoSizeScaleY = myDelegate.autoSizeScaleY;
        
    }
   return self;
}

@end
