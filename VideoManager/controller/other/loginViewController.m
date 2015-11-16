//
//  loginViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-23.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "loginViewController.h"
#import "RegisterViewController.h"
#import "MainViewController.h"
#import "FPwdViewController.h"
#define kHeight 150
#define kaccountLimitWords 11
#define kPwdMaxWords 20
#define kPwdMinWords 6
#define kWidthMargin 27
#define kHeightMargin 15
#define kLabelWidth 40
#define kLabelHeight 35
#define kBtnHeight 40
#define kBtnWidth 60
#define kNavbarHeight 64
#define kIconLength 80
@interface loginViewController ()<UINavigationControllerDelegate>
{
    UIView *navBar;
    LPPopup *popup;
    CGFloat autoSizeScaleX;
    CGFloat autoSizeScaleY;
}
@end

@implementation loginViewController

+ (void)getUserID:(NSString *__autoreleasing *)aUserID Password:(NSString *__autoreleasing *)aPassword
{
    if (aUserID) {
        *aUserID = [self UserID];
    }
    
    if (aPassword) {
        *aPassword = [self Password];
    }
}

#pragma mark - properties

+ (NSString *)UserID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"UserID"];
}

+ (void)setUserID:(NSString *)UserID
{
    [[NSUserDefaults standardUserDefaults] setObject:UserID forKey:@"UserID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)Password
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Password"];
}

+ (void)setPassword:(NSString *)Password
{
    [[NSUserDefaults standardUserDefaults] setObject:Password forKey:@"Password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        autoSizeScaleX = myDelegate.autoSizeScaleX;
         autoSizeScaleY = myDelegate.autoSizeScaleY;

    }
    
    
        
    
    return self;
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


- (void)addSubViews
{
   
    self.view.backgroundColor = [UIColor orangeColor];
    self.bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height+20)];
    self.bgView.image = [UIImage imageNamed:@"登录背景.png"];
    [self.view addSubview:self.bgView];
    // Do any additional setup after loading the view.
    
    UIView *white= [[UIView alloc]initWithFrame:CGRectMake1(kWidthMargin, 173, 10, 2*kLabelHeight)];
    white.backgroundColor = [UIColor whiteColor];
  
    NSLog(@"whiteframe--%f",white.frame.origin.y);
    [self.view addSubview:white];
    
    self.accountText =[[UITextField alloc]initWithFrame:CGRectMake1(kWidthMargin+10, 173, 320-2*kWidthMargin-10, kLabelHeight)];
    self.accountText.font = kDetailContentFont;
    self.accountText.keyboardType = UIKeyboardTypeNamePhonePad;
    self.accountText.backgroundColor = [UIColor whiteColor];
    self.accountText.delegate = self;
    self.accountText.placeholder = @"手机号";
    self.accountText.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.accountText];

   
    self.passWordText =[[UITextField alloc]initWithFrame:CGRectMake((kWidthMargin+10)*autoSizeScaleX, _accountText.frame.origin.y  + _accountText.frame.size.height, _accountText.frame.size.width, kLabelHeight*autoSizeScaleY)];

    self.passWordText.returnKeyType = UIReturnKeyDone;
    self.passWordText.secureTextEntry = YES;
    self.passWordText.font = kDetailContentFont;
    self.passWordText.textAlignment = NSTextAlignmentLeft;
    self.passWordText.backgroundColor = [UIColor whiteColor];
    self.passWordText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    NSLog(@"%u",self.passWordText.secureTextEntry);
    self.passWordText.placeholder = @"密码";
    self.passWordText.delegate = self;
    [self.view addSubview:self.passWordText];
    
    
    UIView *seperator2 = [[UIView alloc]initWithFrame:CGRectMake(25*autoSizeScaleX, _passWordText.frame.origin.y, [UIScreen mainScreen].applicationFrame.size.width-2*kWidthMargin*autoSizeScaleX, 0.5)];
    seperator2.backgroundColor = kGetColor(88, 164, 222);
  
    [self.view addSubview:seperator2];
    
//    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, _passWordText.frame.origin.y +_passWordText.frame.size.height, [UIScreen mainScreen].applicationFrame.size.width, 0.5)];
//    seperator.backgroundColor = kSeperatorColor;
//    
//    [self.view addSubview:seperator];
    
//    self.pwdPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin+kLabelWidth+5, kHeightMargin*3+kLabelHeight, 180, kLabelHeight)];
//    self.pwdPlaceholder.numberOfLines = 0;
//    self.pwdPlaceholder.textColor = [UIColor lightGrayColor];
//    self.pwdPlaceholder.font = kDetailContentFont;
//    self.pwdPlaceholder.text = @"请输入密码";
//    self.pwdPlaceholder.hidden=YES;
//    [self.view addSubview:self.pwdPlaceholder];

    

    
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidthMargin*autoSizeScaleX, _passWordText.frame.origin.y + _passWordText.frame.size.height +20*autoSizeScaleY, 10+_accountText.frame.size.width*autoSizeScaleX, kBtnHeight*autoSizeScaleY)];
    self.loginBtn.backgroundColor =kGetColor(0, 172, 237);
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 5;
    //[self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    //self.loginBtn.layer.cornerRadius = 5;
    //[self.loginBtn.layer setMasksToBounds:YES];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidthMargin, _loginBtn.frame.size.height +_loginBtn.frame.origin.y +15, 60, 20)];
    self.registerBtn.backgroundColor = [UIColor clearColor];
    self.registerBtn.titleLabel.font = k13BordFont;
    self.registerBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
    
    self.findPassWord = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width - 60-kWidthMargin, _registerBtn.frame.origin.y, 60, 20)];
    self.findPassWord.backgroundColor = [UIColor clearColor];
    self.findPassWord.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [self.findPassWord setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.findPassWord.titleLabel.font = k13BordFont;
    [self.findPassWord setTitle:@"找回密码" forState:UIControlStateNormal];
    [self.findPassWord addTarget:self action:@selector(findKey) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.findPassWord];
}
- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length] == 0)
    {
        [self.accountPlaceholder setHidden:NO];
    }else{
        [self.accountPlaceholder setHidden:YES];
    }
    if (textView.markedTextRange == nil && textView.text.length > kaccountLimitWords) {
        textView.text = [textView.text substringToIndex:kaccountLimitWords];
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
  
    if ( [text isEqualToString:@"\n"] ) {
        //Do whatever you want
  
        [textView resignFirstResponder];
        
        //如果不加这个，每次都会换行了
    }
    if (textView.text.length  >= kaccountLimitWords && text.length > range.length) {
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    //如果不加这个，每次都会换行了
     return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length  >= kPwdMaxWords && string.length > range.length) {
        return NO;
    }
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
     [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubViews];
    //[self.accountText setText:[loginViewController UserID]];
    //[self.passWordText setText:[loginViewController Password]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_back.png" target:self action:@selector(Pop)];

    
    [self setNavigationTheme];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    
    tapGesture.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tapGesture];
    
}
-(void)viewTapped:(UITapGestureRecognizer*)tap
{
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


-(void)Pop
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)login
{
    _indictor = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake1(140, 320, 40, 40 )];
    [self.view addSubview:_indictor];
    [_indictor startAnimating];

     
        [loginViewController setUserID:self.accountText.text];
        [loginViewController setPassword:self.passWordText.text];
//        BOOL success;
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSError *error;
//        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *deviceFilePath = [documentsDirectory stringByAppendingPathComponent:@"deviceToken.txt"];
//        NSLog(@"deviceFilePath->>%@",deviceFilePath);
//        success = [fileManager fileExistsAtPath:deviceFilePath];
//        NSString *deviceToken = [[NSString alloc]init];
//        if(success) {
//            deviceToken = [NSString stringWithContentsOfFile:deviceFilePath encoding:NSUTF8StringEncoding error:nil];
//            NSLog(@"deviceToken-----%@",deviceToken);
//        }
    
    NSURLRequest *request = [NSURLRequest requestWithPath:@"userLogin" params:@{@"username":[[NSUserDefaults standardUserDefaults] objectForKey:kPhone],@"userpassword": [[self class] Password],@"type":@"register"                                                }];
        //
        NSHTTPURLResponse *response = nil;
    
        NSLog(@"pushreq%@",request);
    
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (connectionError==nil) {
                NSError *pusherror =nil;
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                
                [_indictor stopAnimating];
                if ([str isEqualToString:@"uperror"]) {
                    [_indictor stopAnimating];
                    popup = [LPPopup popupWithText:@"用户名或密码错误!"];
                    popup.popupColor = [UIColor blackColor];
                    popup.alpha = 0.8;
                    popup.textColor = [UIColor whiteColor];
                    popup.font = kDetailContentFont;
                    //popup.textInsets = UIEdgeInsetsMake(10, 0, 0, 0);
                    [popup showInView:self.view
                        centerAtPoint:self.view.center
                             duration:1
                           completion:nil];
                }else{
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&pusherror];
                User *user = [[User alloc]initWithDict:dict];
                [AccountTool sharedAccountTool].myUser = user;
                NSLog(@"%@",[AccountTool sharedAccountTool].myUser.uAccount);
                MainViewController *main = [[MainViewController alloc] init];
                
                
                [self presentViewController:main animated:NO completion:nil];
                    
                }
            }else{
                [_indictor stopAnimating];
                popup = [LPPopup popupWithText:@"网路错误!"];
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

-(void)registerAccount
{
    RegisterViewController *registerAccount = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerAccount animated:YES];
    
}

-(void)findKey
{
    FPwdViewController *find = [[FPwdViewController alloc]init];
    [self.navigationController pushViewController:find animated:YES];
    
}

-(void)setNavigationTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    //控制器上面的导航栏会默认影响状态栏的颜色x
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //[navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background.png"]]];
    [navBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor darkGrayColor],
                                     UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]}];
    
    
    NSString *icon = @"navigationbar_button_background.png";
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:[icon filenameAppend:@"_pushed"]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:[icon filenameAppend:@"_disable"]] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    
    NSDictionary *barItemTextAttr =@{
                                     UITextAttributeTextColor:[UIColor darkGrayColor],
                                     UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
                                     UITextAttributeFont:[UIFont systemFontOfSize:13]};
    
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateHighlighted];
    
    
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController != root) {
        //每当导航控制器即将显示一个子控制器的时候调用
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_back.png" target:self action:@selector(back)];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
