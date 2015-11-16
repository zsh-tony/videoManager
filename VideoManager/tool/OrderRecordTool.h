//
//  OrderTool.h
//  VideoManager
//
//  Created by lerrruby on 15/11/8.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderRecord;
@interface OrderRecordTool : NSObject
+(void)success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path;
@end
