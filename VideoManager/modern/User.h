//
//  user.h
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GameInfo.h"
typedef enum {
    VipTypeNone = 0,
    VipTypePrimary , // 体验型
    VipTypeStruggle, // 学习型
    VipTypeMaster // 应用型
} VipType;
@interface User : NSObject
@property (nonatomic ,copy) NSString *uAccount;
@property (nonatomic ,copy) NSString *uNick;
@property (nonatomic ,copy) NSString *uAge;
@property (nonatomic ,strong)NSString *uSex;
@property (nonatomic ,copy) NSString *uWorkAdd;
@property (nonatomic,strong)NSString *winxinId;
@property (nonatomic,assign)int leftMoney;
@property (nonatomic,assign)int uLevel;
@property (nonatomic,strong)NSString *startTime;
@property (nonatomic,strong)NSString *hasTime;
@property (nonatomic,strong)NSString *alipay;
@property (nonatomic,assign)VipType vipType;
@property (nonatomic,strong)NSString *leftDay;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
