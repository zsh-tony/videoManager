//
//  GameInfo.h
//  Stranger-Social
//
//  Created by lerrruby on 15/8/15.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameInfo : NSObject
@property (nonatomic,strong)NSString *gameIndex;
@property (nonatomic,strong)NSMutableArray *gameScoreArray;
@property (nonatomic,strong)NSString *challengeScore;
@property (nonatomic,strong)NSString *outCoin;
@property (nonatomic,strong)NSString *inCoin;
@property (nonatomic,strong)NSString *myGameCoin;

-(id)initWithDict:(NSDictionary *)dict;
@end
