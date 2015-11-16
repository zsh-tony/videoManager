//
//  AccountTool.m
//  VideoManager
//
//  Created by lerrruby on 15/10/25.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "AccountTool.h"

@implementation AccountTool
singleton_implementation(AccountTool)

-(id)init
{
    if (self = [super init]) {
        
        self.myUser = [[User alloc]init];
    }
    return self;
}
@end
