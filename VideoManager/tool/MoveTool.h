//
//  OrderTool.h
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Move;
@interface MoveTool : NSObject
+(void)pageId:(NSString *)pageId success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path;
@end
