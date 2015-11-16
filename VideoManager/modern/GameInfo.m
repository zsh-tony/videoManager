//
//  GameInfo.m
//  Stranger-Social
//
//  Created by lerrruby on 15/8/15.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "GameInfo.h"

@implementation GameInfo
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
      
        self.gameIndex = dict[@"gameIndex"];
        self.challengeScore = dict[@"challengeScore"];
        self.outCoin = dict[@"outCoin"];
        self.inCoin = dict[@"inCoin"];
        self.gameScoreArray = dict[@"gameScoreArray"];
        self.myGameCoin = dict[@"myGameCoin"];
        
        
        
        
    }
    return self;
    
}

@end
