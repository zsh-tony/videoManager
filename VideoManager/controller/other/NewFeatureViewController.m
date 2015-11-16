//
//  NewFeatureViewController.m
//  weibo
//
//  Created by zsh tony on 14-7-24.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "MainViewController.h"

#define kCount 3

@interface NewFeatureViewController ()
{
    UIScrollView *scrollview;
    UIPageControl *pageControl;
    UIButton *shareBtn;
}
@end

@implementation NewFeatureViewController

#pragma mark 自定义控制器的view

-(void)loadView
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage fullscreenImageWithName:@"new_feature_background.png"]];
    imageView.frame=[UIScreen mainScreen].bounds;
    imageView.userInteractionEnabled = YES;
    self.view=imageView;
}

- (void)addImageViewAtIndex:(int)index
{
    CGSize viewSize = self.view.frame.size;
    NSString *imagestr= [NSString stringWithFormat:@"new_feature_%d.png",index+1];
    
    UIImageView *imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:imagestr]];
    imageview.frame=CGRectMake(index*viewSize.width, 0, viewSize.width, viewSize.height);
    if (index==kCount-1) {
        imageview.userInteractionEnabled=YES;
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image =[UIImage imageNamed:@"button_bg_icon.png"];
        startBtn.center = CGPointMake(viewSize.width*0.5, viewSize.height*0.85);
        startBtn.frame = (CGRect){CGPointMake(85, 470),CGSizeMake(150, 45)};
        [startBtn setBackgroundImage: image forState:UIControlStateNormal];
        [startBtn setBackgroundImage:image forState:UIControlStateHighlighted];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [imageview addSubview:startBtn];
        
        
    }
    [scrollview addSubview:imageview];
}

-(void)start
{
//  block很强大
    
    if (_startBlock) {
        _startBlock(shareBtn.isSelected);
    }
    
//    //[UIApplication sharedApplication].statusBarHidden = NO;
//    
//    MainViewController *main = [[MainViewController alloc]init];
//    
//    self.view.window.rootViewController = main;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[UIApplication sharedApplication].statusBarHidden = YES;
    self.view.backgroundColor = [UIColor grayColor];
    
    CGSize viewSize = self.view.bounds.size;
    
    scrollview=[[UIScrollView alloc]init];
    scrollview.frame= self.view.bounds;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled=YES;
    scrollview.delegate=self;
    scrollview.contentSize = CGSizeMake(kCount*self.view.bounds.size.width, 0);
    [self.view addSubview:scrollview];
    for (int i=0; i<kCount; i++) {
        
        [self addImageViewAtIndex:i];

    }
    pageControl = [[UIPageControl alloc]init];
    pageControl.center = CGPointMake(viewSize.width*0.5, viewSize.height*0.93);
    pageControl.bounds = CGRectMake(0, 0, 100, 20);
    pageControl.numberOfPages = kCount;
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point@2x.png"]];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point@2x.png"]];
    
    [self.view  addSubview:pageControl];
    
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark scrollviewdelgate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControl.currentPage = scrollview.contentOffset.x/self.view.bounds.size.width;
}


@end
