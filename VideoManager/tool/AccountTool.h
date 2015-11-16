//
//  AccountTool.h
//  VideoManager
//
//  Created by lerrruby on 15/10/25.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Singleton.h"
@interface AccountTool : NSObject
singleton_interface(AccountTool)
@property(nonatomic,strong)User *myUser;
@end
