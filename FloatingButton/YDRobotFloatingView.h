//
//  YDRobotFloatingView.h
//  yxtk
//
//  Created by Aren on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDRobotFloatingView;
@protocol YDRobotFloatingViewDelegate<NSObject>
- (void)didTapOnFloatingView:(YDRobotFloatingView *)aFloatingView;
@end

@interface YDRobotFloatingView : UIImageView
@property (weak, nonatomic) id<YDRobotFloatingViewDelegate> delegate;
@end
