//
//  user.m
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "user.h"


@implementation User
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.uAccount = dict[@"uAccount"];
        self.uNick = dict[@"uNick"];
        self.uAge = dict[@"uAge"];
        self.uWorkAdd = dict[@"uWorkAdd"];
        self.uSex = dict[@"uSex"];
        self.winxinId = dict[@"winxinId"];
        self.leftMoney = [dict[@"leftMoney"] intValue];
        self.hasTime = dict[@"hasTime"];
        self.startTime = dict[@"startTime"];
        self.alipay = dict[@"alipay"];
        self.uLevel = [dict[@"uLevel"] intValue];
    }
    return self;

}
-(VipType)vipType
{
    if (self.uLevel == 0) {
        return VipTypePrimary;
    }else if (self.uLevel == 1&&self.leftMoney == 0){
        return VipTypeStruggle;
    }else if (self.uLevel ==1&&self.leftMoney >0){
        return VipTypeMaster;
    }else{
        return VipTypeNone;
    }
}

-(NSString*)leftDay
{
    if (self.startTime == nil||self.hasTime == nil||[self.startTime isKindOfClass:[NSNull class]]||[self.hasTime  isKindOfClass:[NSNull class]]) {
        return @"0";
    }else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterMediumStyle];
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *startTime = [formatter dateFromString:[self.startTime substringToIndex:19]];
        NSDate *expireDate = [NSDate dateWithTimeInterval:365*3600*24 sinceDate:startTime];
        NSDate *now = [NSDate date];
        NSTimeInterval leftInterval = [expireDate timeIntervalSinceDate:now];
        return [NSString stringWithFormat:@"%d",(int)leftInterval/3600/24];
    }
}

@end
