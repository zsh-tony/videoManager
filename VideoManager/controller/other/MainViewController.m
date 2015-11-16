//
//  MainViewController.m
//  weibo
//
//  Created by zsh tony on 14-7-24.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "MainViewController.h"
#import "Dock.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"
#import "ForumViewController.h"
#import "VideoViewController.h"
#import "ConsultViewController.h"
#import "loginViewController.h"
#import "SliderNavViewController.h"



#define kDockHeight 44
#define kContentFrame CGRectMake(0,0 , self.view.frame.size.width, self.view.frame.size.height - kDockHeight);
#define kDockFrame CGRectMake(0, self.view.frame.size.height-kDockHeight,self.view.frame.size.width , kDockHeight)
@interface MainViewController ()
{
    
    Dock *dock;
}
@property (nonatomic, readonly) AppDelegate *appDelegate;
@end

@implementation MainViewController
singleton_implementation(MainViewController)


- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)addChildViewController:(UIViewController *)childController
{
    //包装一个导航条
    SliderNavViewController *nav = [[SliderNavViewController alloc]initWithRootViewController:childController];//前一个类名可以不改，因为多态？
    nav.delegate = self;
    [super addChildViewController:nav];
}

- (void)creatChildcontrollers
{
    
    VideoViewController *video = [[VideoViewController alloc]init];
    
    [self addChildViewController:video];
    
    ConsultViewController *consult = [[ConsultViewController alloc]init];
    [self addChildViewController:consult];
    
    ForumViewController *forum = [[ForumViewController alloc]init];
    [self addChildViewController:forum];
    
    ProfileViewController *profile = [[ProfileViewController alloc]init];
    //profile.title = @"我";
    //profile.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:profile];


}

-(void)logOut:(NSNotification *)notification
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self _initSDK];
    self.view.backgroundColor = kGlobalBg;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut:) name:@"logOut" object:nil];
    
    [self creatChildcontrollers];
    [self setNavigationTheme];
    
    [self addDock];
    
    [self selectedControllerAtIndex:0];
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
- (void)selectedControllerAtIndex:(int)index
{
    //为保证代码的性能，添加一个view就要先将当前的view从主控制器中移除，这里是没有销毁的，因为其父控制器还在
    UINavigationController *new = self.childViewControllers[index];
    if ( new == _selectedController) return ;
    
    
    [_selectedController.view removeFromSuperview];
    
    new.view.frame = kContentFrame;
    //NSLog(@"%@",new.view.backgroundColor);
    [self.view addSubview:new.view];
    
    _selectedController = new;
}

//添加dock
- (void)addDock
{
    /*背景颜色：黑色的话相当于clearcolor，相当于透明，也就不能响应点击事件
     userInteractionEnabled = NO;
     hiden = YES;
     alpha <=0.01;
     clearcolor
     */
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor grayColor];
    dock = [[Dock alloc]init];
    dock.frame = kDockFrame;
    [self.view addSubview:dock];
    
    [dock addItemWithIcon:@"消息.png" title:@"视频"];
    [dock addItemWithIcon:@"通讯录.png" title:@"咨询师"];
    [dock addItemWithIcon:@"发现.png" title:@"论坛"];
    [dock addItemWithIcon:@"我的.png" title:@"个人中心"];
    
 
    
    //item点击通知dock，再由dock通知控制器，用block作为中间传递者，现在监听dock的内部点击事件
    __weak MainViewController *weakSelf = self;
    dock.itemClickBlock = ^(int index){
        [weakSelf selectedControllerAtIndex:index];
    };
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 导航控制器代理方法
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController != root) {
        //每当导航控制器即将显示一个子控制器的时候调用
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_back.png" target:self action:@selector(back)];
        //右边首页
               //dock.hidden = YES;//这种方法不能保证dock和导航控制器的view变化同步。所以要将dock加到view上才能同步

        
        navigationController.view.frame = self.view.bounds;
        [dock removeFromSuperview];
        CGRect dockFrame = dock.frame;
        //改变dock的Y值，不改的话，添加是添加上去了，但是被遮住了
        //        if ([root.view isKindOfClass:[UIScrollView class]]) {
        //            UIScrollView *scrollview = (UIScrollView *)root.view;
        //            dockFrame.origin.y = scrollview.contentOffset.y + root.view.frame.size.height - kDockHeight;
        //        } else {
        if (viewController==navigationController.childViewControllers[1]) {
            dockFrame.origin.y -=64;
            
        }else if (viewController==navigationController.childViewControllers[2]) {
            dockFrame.origin.y +=64;
            
        }else if (viewController==navigationController.childViewControllers[3]) {
            dockFrame.origin.y -=64;
            
        }else if (viewController==navigationController.childViewControllers[4]) {
            dockFrame.origin.y +=64;
            
        }else if (viewController==navigationController.childViewControllers[5]) {
            dockFrame.origin.y -=64;
            
        }else if (viewController==navigationController.childViewControllers[6]) {
            dockFrame.origin.y +=64;
            
        }else if (viewController==navigationController.childViewControllers[7]) {
            dockFrame.origin.y -=64;
            
        }else if (viewController==navigationController.childViewControllers[8]) {
            dockFrame.origin.y +=64;
            
        }




        //因为home的view与self的viewY值不一样
        // }
        
        dock.frame = dockFrame;
        
        
        [root.view addSubview:dock];

    }
//    }else{
//        
//        //dock.hidden = NO;
//        
//        navigationController.view.frame = kContentFrame;
//        [dock removeFromSuperview];
//        dock.frame = kDockFrame;
//        [self.view addSubview:dock];
//        
//    }
//    如果这样的话，回来的时候还是不能同步，只能通过下面的方法。当它回来之后再添加进去

}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
     UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root) {
        navigationController.view.frame = kContentFrame;
        [dock removeFromSuperview];
        dock.frame = kDockFrame;
        [self.view addSubview:dock];
    }
    
}

-(void)home
{
    
}
-(void)back
{
    [_selectedController popViewControllerAnimated:YES];
}

@end
