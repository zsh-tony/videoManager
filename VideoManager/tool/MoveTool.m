//
//  StatusTool.m
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "MoveTool.h"
#import "Move.h"
#import "NSURLRequest+Url.h"

@implementation MoveTool
+(void)pageId:(NSString *)pageId success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path
{
    
    NSURLRequest *request = [NSURLRequest requestWithPath:path                        params:@{@"type":@"getmovies",@"page": pageId,@"uAccount"   :@"13080908250"                                                         }];
    NSLog(@"%@",request);
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *array = JSON;
        NSMutableArray *moves = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            Move *s = [[Move alloc]initWithDict:dict];
            [moves addObject:s];
        }
        //回调
        if (success) {
            success(moves);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
        
    }];

    [op start];
    
}

@end
