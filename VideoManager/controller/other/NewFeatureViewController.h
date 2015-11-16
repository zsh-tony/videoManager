//
//  NewFeatureViewController.h
//  weibo
//
//  Created by zsh tony on 14-7-24.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic, copy) void (^startBlock)(BOOL shared);
@end
