//
//  Order.h
//  VideoManager
//
//  Created by lerrruby on 15/11/8.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderRecord : NSObject
@property(nonatomic,strong)NSString *money;
@property (nonatomic,strong)NSString *paytype;
@property (nonatomic,strong)NSString *date;
-(id)initWithDict:(NSDictionary *)dict;

@end
