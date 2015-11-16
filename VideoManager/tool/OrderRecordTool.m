//
//  OrderTool.m
//  VideoManager
//
//  Created by lerrruby on 15/11/8.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "OrderRecordTool.h"
#import "OrderRecord.h"
@implementation OrderRecordTool
+(void)success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path
{
    
    NSURLRequest *request = [NSURLRequest requestWithPath:path                        params:@{@"type":@"getaccount",@"uAccount"   :kselfUser.uAccount                                                         }];
    NSLog(@"%@",request);
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *array = JSON;
        NSMutableArray *orders = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            OrderRecord *o = [[OrderRecord alloc]initWithDict:dict];
            [orders addObject:o];
        }
        //回调
        if (success) {
            success(orders);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
        
    }];
    
    [op start];
    
}

@end
