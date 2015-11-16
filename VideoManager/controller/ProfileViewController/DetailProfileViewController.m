//
//  DetailProfileViewController.m
//  VideoManager
//
//  Created by lerrruby on 15/10/25.
//  Copyright (c) 2015年 lerruby.com. All rights reserved.
//

#import "DetailProfileViewController.h"
#import "UITextCell.h"
#import "AccountTool.h"
#define kTableviewFrame CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)
#define kUIViewFrame  CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
#define kaccountLimitWords 11
#define kPwdMaxWords 20

#define kSelfSex [[AccountTool sharedAccountTool].myUser.uSex isEqualToString:@"0"]?@"男":@"女"

@interface DetailProfileViewController ()<UITextFieldDelegate,UIActionSheetDelegate>
{
    UITextCell *sexCell;
    UITextCell *myCell;
    UITextCell *ageCell;
    UITextCell *weixinCell;
    UITextCell *addreCell;
    UITextCell *alipayCell;
    LPPopup *popup;
    CGFloat frameHeight;
    UIActionSheet *  sexSheet;
}
@end


@implementation DetailProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.标题
    self.title = @"个人中心";
    [self addKeyobserver];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.backgroundColor = kGlobalBg;
    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0, self.view.bounds.size.width - 20, 70);
    UIButton *alterInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    [alterInfo setAllStateBg:@"common_button_big_red.png"];
    [alterInfo setTitle:@"修改资料" forState:UIControlStateNormal];
    alterInfo.frame = CGRectMake(10, 10, self.view.bounds.size.width - 20, 44);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
    [alterInfo addTarget:self action:@selector(alterInfo) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:alterInfo];
    self.tableView.tableFooterView = footer;
    [self.view addSubview:self.tableView];
}
- (void)addKeyobserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}
-(void)alterInfo
{
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    NSString *newNick;
    NSString *newSex;
    NSString *newAge;
    NSString *newWxin;
    NSString *newWork;
    NSString *alipay;
    
    NSURLRequest *request;
    if (![myCell.contentText.text isEqualToString:@""]) {
          newNick= myCell.contentText.text;
    }else{
        newNick = myCell.contentText.placeholder;
        
    }
    if (![ageCell.contentText.text isEqualToString:@""]) {
        newAge = ageCell.contentText.text;
    }else{
        newAge = ageCell.contentText.placeholder;
        
    }
    
    if (![sexCell.contentText.text isEqualToString:@""]) {
        newSex = sexCell.contentText.text;
        
    }else{
        newSex = sexCell.contentText.placeholder;
    }
   newSex = [newSex isEqualToString:@"男"]?@"0":@"1";
    
    if (![weixinCell.contentText.text isEqualToString:@""]) {
        newWxin = weixinCell.contentText.text;
    } else if(weixinCell.contentText.placeholder){
        newWxin = weixinCell.contentText.placeholder;
    }
    
    if (![addreCell.contentText.text isEqualToString:@""]) {
        newWork = addreCell.contentText.text;
    }else if(addreCell.contentText.placeholder){
        newWork = addreCell.contentText.placeholder;
    }
  
    if (![alipayCell.contentText.text isEqualToString:@""]) {
        alipay = alipayCell.contentText.text;
    }else if(alipayCell.contentText.placeholder){
        alipay = alipayCell.contentText.placeholder;
    }
    
    if (!newWork) {
        [ToastMessage toastMessageWith:@"工作地点不能为空!"];
       
    }else if(!newWxin){
        [ToastMessage toastMessageWith:@"微信号不能为空!"];


    }else if(!alipay){
         [ToastMessage toastMessageWith:@"支付宝账号不能为空!"];
       
        
    }else{
         request = [NSURLRequest requestWithPath:@"person" params:@{@"uAccount":[[NSUserDefaults standardUserDefaults] objectForKey:kPhone],@"uNick": newNick,@"uSex":newSex,@"uWorkAdd":newWork,@"winxinId":newWxin,@"uAge":newAge,@"type":@"modifyinfo" ,@"alipay":alipay                             }];
        NSHTTPURLResponse *response = nil;
        
        NSLog(@"pusfd-----hreq%@",request);
        [SVProgressHUD showWithStatus:@"修改中" maskType:SVProgressHUDMaskTypeNone];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (connectionError==nil) {
                [SVProgressHUD dismiss];
                NSError *pusherror =nil;
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                if ([str isEqualToString:@"modify_success"]) {
                    [AccountTool sharedAccountTool].myUser.uNick = newNick;
                    [AccountTool sharedAccountTool].myUser.uAge = newAge;
                    [AccountTool sharedAccountTool].myUser.uSex = newSex;
                    [AccountTool sharedAccountTool].myUser.uWorkAdd =newWork;
                    [AccountTool sharedAccountTool].myUser.winxinId = newWxin;
                    [AccountTool sharedAccountTool].myUser.alipay = alipay;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD dismiss];
              
                    popup = [LPPopup popupWithText:@"修改失败!"];
                    popup.popupColor = [UIColor blackColor];
                    popup.alpha = 0.8;
                    popup.textColor = [UIColor whiteColor];
                    popup.font = kDetailContentFont;
                    //popup.textInsets = UIEdgeInsetsMake(10, 0, 0, 0);
                    [popup showInView:self.view
                        centerAtPoint:self.view.center
                             duration:1
                           completion:nil];
                }
                
            }else{
                [SVProgressHUD dismiss];

                popup = [LPPopup popupWithText:@"网络出错!"];
                popup.popupColor = [UIColor blackColor];
                popup.alpha = 0.8;
                popup.textColor = [UIColor whiteColor];
                popup.font = kDetailContentFont;
                //popup.textInsets = UIEdgeInsetsMake(10, 0, 0, 0);
                [popup showInView:self.view
                    centerAtPoint:self.view.center
                         duration:1
                       completion:nil];
            }
        }];

    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            sexCell.contentText.text = @"男";
            break;
        case 1:
            sexCell.contentText.text = @"女";
            
            break;
     
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return 6;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    headView.backgroundColor = [UIColor whiteColor];
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
    titleView.image = [UIImage imageNamed:@"myTitleView.png"];
    [headView addSubview:titleView];
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 60, 50, 50)];
    iconView.image = [UIImage imageNamed:@"iconImage.png"];
    [headView addSubview:iconView];
    
    

    
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 70, 50, 40)];
    levelLabel.text = kselfUser.uAccount;
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.textAlignment = NSTextAlignmentLeft;
    levelLabel.font = [UIFont systemFontOfSize:16];
    [levelLabel sizeToFit];
    [headView addSubview:levelLabel];
    
    
    
    UILabel *theme =[[UILabel alloc]initWithFrame:CGRectMake(0, 120, 320, 30)];
    theme.text = @"  个人资料";
    theme.textColor = [UIColor lightGrayColor];
    theme.textAlignment = NSTextAlignmentLeft;
    theme.font = [UIFont systemFontOfSize:14];
    theme.backgroundColor = kGetColor(245, 245, 245);
    [headView addSubview:theme];
      return headView;
  
   
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 
    return 150;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            sexSheet = [[UIActionSheet alloc]
                        initWithTitle:nil
                        delegate:self
                        cancelButtonTitle:@"取消"
                        destructiveButtonTitle:nil
                        otherButtonTitles:@"男",@"女",nil];
            
            [sexSheet showInView:self.view];

        }else if (indexPath.row == 3){
            
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0) {
            static NSString *CellIdentifier1 = @"myCell";
             myCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (myCell == nil) {
                myCell = [[UITextCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
            }
            myCell.selectionStyle = UITableViewCellSelectionStyleNone;
            myCell.contentText.delegate = self;
            myCell.titleLabel.text = @"昵称:";
            
            NSString* uNick=[AccountTool sharedAccountTool ].myUser.uNick;
            if (![uNick isKindOfClass:[NSNull class]]) {
                myCell.contentText.placeholder = [AccountTool sharedAccountTool].myUser.uNick;
            }
            return myCell;
            
        }else if (indexPath.row == 1){
            static NSString *CellIdentifier2 = @"sexCell";
            sexCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (sexCell == nil) {
                sexCell = [[UITextCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier2] ;
            }
            sexCell.selectionStyle = UITableViewCellSelectionStyleNone;
            sexCell.contentText.delegate = self;
            sexCell.contentText.userInteractionEnabled = NO;
            sexCell.titleLabel.text = @"性别:";
             NSString* uSex=[AccountTool sharedAccountTool ].myUser.uSex;
            if (![uSex isKindOfClass:[NSNull class]]) {
               sexCell.contentText.placeholder = kSelfSex;
            }
            return sexCell;
            
        }else if (indexPath.row == 2){
            static NSString *CellIdentifier3 = @"ageCell";
            ageCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier3];
            if (ageCell == nil) {
                ageCell = [[UITextCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier3] ;
            }
            ageCell.selectionStyle = UITableViewCellSelectionStyleNone;
            ageCell.contentText.delegate = self;
            ageCell.titleLabel.text = @"年龄:";
            NSString* uAge=[AccountTool sharedAccountTool ].myUser.uAge;
            if (![uAge isKindOfClass:[NSNull class]]) {
                ageCell.contentText.placeholder =[NSString stringWithFormat:@"%@",[AccountTool sharedAccountTool ].myUser.uAge] ;
            }
            
            return ageCell;
        }else if (indexPath.row == 3){
            static NSString *CellIdentifier4 = @"weixinCell";
            weixinCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier4];
            if (weixinCell == nil) {
                weixinCell = [[UITextCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier4] ;
            }
            weixinCell.selectionStyle = UITableViewCellSelectionStyleNone;
            weixinCell.contentText.delegate = self;
            weixinCell.titleLabel.text = @"微信号:";
            NSString* winxinId=[AccountTool sharedAccountTool ].myUser.winxinId;
            if (![winxinId isKindOfClass:[NSNull class]]) {
                weixinCell.contentText.placeholder = [AccountTool sharedAccountTool ].myUser.winxinId;
            }
            
            return weixinCell;
        }else if(indexPath.row == 4){
            
            static NSString *CellIdentifier5 = @"addreCell";
            addreCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier5];
            if (addreCell == nil) {
                addreCell = [[UITextCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier5] ;
            }
            addreCell.selectionStyle = UITableViewCellSelectionStyleNone;
            addreCell.contentText.delegate = self;
            addreCell.titleLabel.text = @"地址:";
            NSString* workAdd=[AccountTool sharedAccountTool].myUser.uWorkAdd;
            if (![workAdd isKindOfClass:[NSNull class]]) {
                addreCell.contentText.placeholder = [AccountTool sharedAccountTool].myUser.uWorkAdd;
            }
            
            return addreCell;
        }else{
            static NSString *CellIdentifier5 = @"alipayCell";
            alipayCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier5];
            if (alipayCell == nil) {
                alipayCell = [[UITextCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier5] ;
            }
            alipayCell.selectionStyle = UITableViewCellSelectionStyleNone;
            alipayCell.contentText.delegate = self;
            alipayCell.titleLabel.text = @"支付宝:";
            NSString* alipay=[AccountTool sharedAccountTool].myUser.alipay;
            if (![alipay isKindOfClass:[NSNull class]]&&![alipay isEqualToString:@"null"]) {
                alipayCell.contentText.placeholder = [AccountTool sharedAccountTool].myUser.alipay;
            }
            
            return alipayCell;
        }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    //如果不加这个，每次都会换行了
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if ([textField isEqual:myCell.contentText]) {
        frameHeight = 390;
    }else if ([textField isEqual:sexCell.contentText]) {
        frameHeight = 430;
    }else if ([textField isEqual:ageCell.contentText]) {
        frameHeight = 475;
    }else if ([textField isEqual:weixinCell.contentText]) {
        frameHeight = 500;
    }else{
        frameHeight = 550;
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:myCell.contentText]) {
        if (textField.text.length  >= 20 && string.length > range.length) {
            return NO;
        }else{
            return YES;
        }
        
    }else if ([textField isEqual:sexCell.contentText]){
        if (textField.text.length  >= 4 && string.length > range.length) {
            return NO;
        }else{
            return YES;
        }
    }else if ([textField isEqual:ageCell.contentText]){
        if (textField.text.length  >= 2 && string.length > range.length) {
            return NO;
        }else{
            return YES;
        }
    }else if ([textField isEqual:weixinCell.contentText]){
        if (textField.text.length  >= 10 && string.length > range.length) {
            return NO;
        }else{
            return YES;
        }
    }else if ([textField isEqual:ageCell.contentText]){
        if (textField.text.length  >= 20 && string.length > range.length) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
    
    
    
    
}
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    NSDictionary *userInfo = [notification userInfo];
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    CGFloat height = keyboardRect.size.height - (568*kAutoSizeScaleY-frameHeight);
    [animationDurationValue getValue:&animationDuration];
    [self.tableView setScrollEnabled:YES];
    NSLog(@"%f",height);
    if (height < 0) {//<0说明，界面不用升降，只用把tableview的大小调一下，以当滑动时，界面都能显示
        [UIView animateWithDuration:animationDuration animations:^{
            self.tableView.frame =CGRectMake(0, 0, 320*kAutoSizeScaleX, 568*kAutoSizeScaleY-keyboardRect.size.height-self.view.frame.origin.y);
            // self.tableView.frame =CGRectMake(0, 44, 320, 524-keyboardRect.size.height-self.view.frame.origin.y);不加self.view.frame.origin.y的话后面先点下面的再点上面的uitextview会导致不对
            
        }];
        
    }
    if (height > 0) {//大于0时说明界面要升降，
        [UIView animateWithDuration:animationDuration animations:^{
            
            
            self.tableView.frame =CGRectMake(0, 44, 320*kAutoSizeScaleX, 524*kAutoSizeScaleY-keyboardRect.size.height+height);
            
            self.view.frame = CGRectMake1(0, -height, 320, 568);
            self.tableView.contentInset = UIEdgeInsetsMake(height*kAutoSizeScaleY, 0, 0, 0);
            
        }];
        
    }
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    //[self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    //[self moveInputBarWithKeyboardHeight:0.0 withDuration:animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        [UIView animateWithDuration:0.2 animations:^{
            
            
            self.tableView.frame = kTableviewFrame;
            self.view.frame = kUIViewFrame;
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
        
        
    }];
}
CG_INLINE CGRect
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
    
    
    
}
@end


