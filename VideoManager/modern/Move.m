//
//  BaseOrder.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "Move.h"

@implementation Move
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title  = dict[@"title"];
        self.mId = dict[@"mId"];
        self.introduce = dict[@"introduce"];
        self.pic = dict[@"pic"];
        
    }
    return self;
    
}
@end
