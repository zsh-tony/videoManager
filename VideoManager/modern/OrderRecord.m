//
//  Order.m
//  VideoManager
//
//  Created by lerrruby on 15/11/8.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "OrderRecord.h"

@implementation OrderRecord
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.money  = dict[@"money"];
        self.paytype = dict[@"paytype"];
        self.date = dict[@"date"];
      
        
    }
    return self;
    
}
@end
