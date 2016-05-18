//
//  ZZQFloatingViewController.m
//  FloatingButton
//
//  Created by r_zhou on 16/5/17.
//  Copyright © 2016年 r_zhous. All rights reserved.
//

#import "ZZQFloatingViewController.h"
#import "YDRecommendView.h"
#import "YDRobotFloatingView.h"
#import "ZZQUserSetting.h"

@interface ZZQFloatingViewController ()<YDRecommendViewDelegate,YDRobotFloatingViewDelegate>
@property (strong, nonatomic) YDRecommendView *recommendView;
@property (strong, nonatomic) YDRobotFloatingView *robotView;

@property (strong, nonatomic) UILabel *label;

@end

@implementation ZZQFloatingViewController
@synthesize label;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     //文字添加
    label = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, 300, 44)];
    label.font=[UIFont systemFontOfSize:25];
    [self.view addSubview:label];
    

    self.view.backgroundColor = [UIColor whiteColor];
     [self configRobotButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.robotView) {
        NSLog(@"记录位子");
        //记录位子
        [ZZQUserSetting setPoint:self.robotView.frame.origin forKey:ORSettingsRobotPosition];
        [ZZQUserSetting synchronize];
        
        [self.robotView removeFromSuperview];
        self.robotView = nil;
    }
}

- (void)configRobotButton
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.robotView];

    //拿到记录的位子
    CGPoint lastPosition = [ZZQUserSetting pointOfKey:ORSettingsRobotPosition];
    if (CGPointEqualToPoint(lastPosition, CGPointZero)) {
        self.robotView.frame = CGRectMake( window.bounds.size.width - 48 - 10,window.bounds.size.height - 54 - 48, 48, 48);
    } else {
        self.robotView.frame = CGRectMake(lastPosition.x, lastPosition.y, 48, 48);
    }
}


#pragma mark - Robot
- (YDRobotFloatingView *)robotView
{
    if (!_robotView) {
        _robotView = [[YDRobotFloatingView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        _robotView.image = [UIImage imageNamed:@"btn_chat_robot"];
        _robotView.delegate = self;
        _robotView.userInteractionEnabled = YES;
    }
    return _robotView;
}

#pragma mark - YDRobotFloatingViewDelegate
- (void)didTapOnFloatingView:(YDRobotFloatingView *)aFloatingView
{
    [self showRecommendViewFromView:self.robotView];
}

- (void)showRecommendViewFromView:(UIView *)aView
{
    //    [self setChatSessionInputBarStatus:KBottomBarDefaultStatus animated:YES];
    YDRecommendView *recommendView = [YDRecommendView recommendViewWithDelegate:self];
    self.recommendView = recommendView;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [recommendView showFromView:aView targetView:window];
}

#pragma mark - YDRecommendViewDelegate
- (void)recommendView:(YDRecommendView *)aView onChatButtonAction:(id)aChatButton
{
    
}

- (void)recommendView:(YDRecommendView *)aView didSelectItem:(NSString *)aData
{
    //    [self sendMessage:[RCTextMessage messageWithContent:aData] pushContent:aData];
    NSLog(@"%@",aData);
    label.text = aData;
}

- (void)didHideRecommendView:(YDRecommendView *)aView
{
    self.recommendView = nil;
}


@end
