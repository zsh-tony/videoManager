//
//  ToastMessage.m
//  VideoManager
//
//  Created by lerrruby on 15/11/15.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "ToastMessage.h"
#import "MainViewController.h"
@implementation ToastMessage
+(void)toastMessageWith:(NSString*)message
{
    LPPopup *popup = [LPPopup popupWithText:message];
    popup.popupColor = [UIColor blackColor];
    popup.alpha = 0.8;
    popup.textColor = [UIColor whiteColor];
    popup.font = kDetailContentFont;
    //popup.textInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    [popup showInView:[MainViewController sharedMainViewController].view
        centerAtPoint:[MainViewController sharedMainViewController].view.center
             duration:1
           completion:nil];
}
@end
