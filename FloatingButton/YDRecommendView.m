//
//  YDRecommendView.m
//  yxtk
//
//  Created by Aren on 16/5/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YDRecommendView.h"
#import "YDRecommendItemCell.h"
#import <POP/POP.h>

@interface YDRecommendView()
<UICollectionViewDataSource,
UICollectionViewDelegate>
@property (strong, nonatomic) NSArray *dataSource;
@end
@implementation YDRecommendView

+ (instancetype)recommendViewWithDelegate:(id)aDelegate
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YDRecommendView" owner:self options:nil];
    YDRecommendView *recommendView = (YDRecommendView *)[nib objectAtIndex:0];
    recommendView.delegate = aDelegate;
    return recommendView;
}

- (void)showFromView:(UIView *)aFromView targetView:(UIView *)aView
{
    //    CGPoint absoluteCenter = CGPointMake((aFromView.frame.origin.x + aFromView.frame.size.width)/2,
    //                                         (aFromView.frame.origin.y + aFromView.frame.size.height)/2);
//    CGPoint absoluteCenter = CGPointZero;
    //    absoluteCenter.x = aFromView.center.x + aFromView.layer.anchorPoint.x;
    //    absoluteCenter.y = aFromView.center.y + aFromView.layer.anchorPoint.y;
    CGPoint fromPoint = [aView convertPoint:aFromView.layer.position fromView:aFromView.superview];
    self.fromPoint = fromPoint;
    self.frame = aView.bounds;
    [aView addSubview:self];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alphaAnimation.fromValue = @0;
    alphaAnimation.toValue = @1;
    alphaAnimation.duration = 0.4;
    [self.bgImageView pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    self.contentView.hidden = NO;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:self.fromPoint];
    positionAnimation.toValue = [NSValue valueWithCGPoint:self.center];
    positionAnimation.duration = 0.4;
    [self.contentView pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    //    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.01f, 0.01f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleAnimation.duration = 0.4;
    [self.contentView.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleAnimation"];
    __weak typeof(self) weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [weakself doChatButtonAnimation];
    });
}

- (void)hide
{
    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    alphaAnimation.duration = 0.4;
    [self.bgImageView pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    self.contentView.hidden = NO;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:self.contentView.center];
    positionAnimation.toValue = [NSValue valueWithCGPoint:self.fromPoint];
    positionAnimation.duration = 0.4;
    [self.contentView pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.01f, 0.01f)];
    scaleAnimation.duration = 0.25;
    [self.contentView.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleAnimation"];
    
    POPBasicAnimation *contentAlphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    contentAlphaAnimation.fromValue = @1;
    contentAlphaAnimation.toValue = @0;
    contentAlphaAnimation.duration = 0.4;
    [self.contentView pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
    
    __weak typeof(self) weakself = self;
    [alphaAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        weakself.userInteractionEnabled = YES;
        if ([weakself.delegate respondsToSelector:@selector(didHideRecommendView:)]) {
            [weakself.delegate didHideRecommendView:weakself];
        }
        [weakself removeFromSuperview];
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.layer.cornerRadius = 16;
    self.contentView.layer.masksToBounds = YES;
    self.chatButton.layer.cornerRadius = 8;
    self.chatButton.layer.masksToBounds = YES;
    self.contentView.layer.transform = CATransform3DMakeScale(.01, .01, 1);
    //    self.contentView.layer.transform =
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.bgImageView addGestureRecognizer:tapGesture];
    
    [self initDataSource];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YDRecommendItemCell" bundle:nil] forCellWithReuseIdentifier:@"YDRecommendItemCell"];
}

- (void)dealloc
{
    NSLog(@"dealloc - %@", [self class]);
}

#pragma mark - Tap Handle
- (void)handleTap:(UIGestureRecognizer *)aGestureRecognizer
{
    [self hide];
}

- (void)initDataSource
{
    self.dataSource = @[@{@"color":@"6657A6", @"icon":@"icon_recommend_food", @"title":@"美食", @"msg":@"我要吃美食"},
                        @{@"color":@"FECB8D", @"icon":@"icon_recommend_shop", @"title":@"购物", @"msg":@"我要买买买"},
                        @{@"color":@"D46767", @"icon":@"icon_recommend_video", @"title":@"视频", @"msg":@"我要看视频"},
                        @{@"color":@"7AAFDB", @"icon":@"icon_recommend_joke", @"title":@"段子", @"msg":@"我要看段子"},
                        @{@"color":@"79BBB3", @"icon":@"icon_recommend_news", @"title":@"资讯", @"msg":@"我要看资讯"},
                        @{@"color":@"FBCB51", @"icon":@"icon_recommend_photo", @"title":@"颜值", @"msg":@"我要看颜值"},
                        @{@"color":@"FB9D6D", @"icon":@"icon_recommend_music", @"title":@"音乐", @"msg":@"我要听音乐"},
                        @{@"color":@"565C78", @"icon":@"icon_recommend_weather", @"title":@"天气", @"msg":@"我要查天气"},
                        @{@"color":@"FB7493", @"icon":@"icon_recommend_ticket", @"title":@"订票", @"msg":@"我要订票"}];
}

#pragma mark - UICollectionView Delegate/Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    //    NSInteger section = indexPath.section;
    
    static NSString *cellIdentifier = @"YDRecommendItemCell";
    YDRecommendItemCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dict = [self.dataSource objectAtIndex:row];
    [collectionViewCell bindWithData:dict];
    return collectionViewCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize = [YDRecommendItemCell sizeForCell];
    return cellSize;
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if (collectionView == self.recommendCollectionView) {
//        NSInteger section = indexPath.section;
//        if (section == YDHomeRecommendSectionHot) {
//            YDHomeCollectionViewHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YDHomeCollectionViewHeadView" forIndexPath:indexPath];
//            headView.headIconImageView.image = [UIImage imageNamed:@"icon_home_hot"];
//            headView.headTitleLabel.text = @"热门推荐";
//            return headView;
//        }
//    }
//
//    return nil;
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSDictionary *dict = [self.dataSource objectAtIndex:row];
    NSString *content = [dict objectForKey:@"msg"];
    if ([self.delegate respondsToSelector:@selector(recommendView:didSelectItem:)]) {
        [self.delegate recommendView:self didSelectItem:content];
    }
    
    [self hide];
}

#pragma mark - Action
- (IBAction)onChatButtonAction:(id)sender {
    //    [self doChatButtonAnimation];
    [self hide];
    if ([self.delegate respondsToSelector:@selector(recommendView:onChatButtonAction:)]) {
        [self.delegate recommendView:self onChatButtonAction:sender];
    }
}

#pragma mark - Animation
- (void)doChatButtonAnimation
{
//    self.chatButton.userInteractionEnabled = NO;
    POPSpringAnimation *ratationAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    ratationAnimation.velocity = @15;
    ratationAnimation.springBounciness = 12.f;
    ratationAnimation.dynamicsTension = 500;
    [self.chatButton.layer pop_addAnimation:ratationAnimation forKey:@"buttonShakeAnimation"];
    __weak typeof(self) weakself = self;
    [ratationAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        weakself.chatButton.userInteractionEnabled = YES;
    }];
}
@end
