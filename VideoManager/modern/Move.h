//
//  BaseOrder.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Move : NSObject
@property (nonatomic,strong)NSString *mId;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *introduce;
@property (nonatomic,strong)NSString *pic;

-(id)initWithDict:(NSDictionary *)dict;
@end
