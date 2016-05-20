//
//  ViewController.m
//  FloatingButton
//
//  Created by r_zhou on 16/5/17.
//  Copyright © 2016年 r_zhous. All rights reserved.
//

#import "ViewController.h"
#import "ZZQFloatingViewController.h"
#import "YDRecommendView.h"

@interface ViewController ()<YDRecommendViewDelegate>
@property (strong, nonatomic) YDRecommendView *recommendView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"悬浮抖动页面";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFloatingBtnAction:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ZZQFloatingViewController * floatingView = [storyboard instantiateViewControllerWithIdentifier:@"ZZQFloatingViewController"];
    
    [self.navigationController pushViewController:floatingView animated:YES];
    
}


- (IBAction)onJitterBtnAction:(id)sender {
    YDRecommendView *recommendView = [YDRecommendView recommendViewWithDelegate:self];
    self.recommendView = recommendView;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [recommendView showFromView:recommendView targetView:window];
}



#pragma mark - YDRecommendViewDelegate
- (void)recommendView:(YDRecommendView *)aView onChatButtonAction:(id)aChatButton
{
    
}

- (void)recommendView:(YDRecommendView *)aView didSelectItem:(NSString *)aData
{
    NSLog(@"%@",aData);
//    label.text = aData;
}

- (void)didHideRecommendView:(YDRecommendView *)aView
{
    self.recommendView = nil;
}
@end
