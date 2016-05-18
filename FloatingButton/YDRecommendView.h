//
//  YDRecommendView.h
//  yxtk
//
//  Created by Aren on 16/5/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDRecommendView;
@protocol YDRecommendViewDelegate<NSObject>
@optional
- (void)recommendView:(YDRecommendView *)aView onChatButtonAction:(id)aChatButton;
- (void)recommendView:(YDRecommendView *)aView didSelectItem:(NSString *)aData;
- (void)didHideRecommendView:(YDRecommendView *)aView;
@end

@interface YDRecommendView : UIView
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (assign, nonatomic) CGPoint fromPoint;
@property (weak, nonatomic) id<YDRecommendViewDelegate> delegate;

+ (instancetype)recommendViewWithDelegate:(id)aDelegate;
- (void)showFromView:(UIView *)aFrom targetView:(UIView *)aView;
- (void)hide;
@end
