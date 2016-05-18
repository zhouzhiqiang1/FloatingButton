//
//  YDRecommendItemCell.m
//  yxtk
//
//  Created by Aren on 16/5/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YDRecommendItemCell.h"
#import "ORColorUtil.h"
#import <POP/POP.h>

@implementation YDRecommendItemCell

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
    self.itemBgView.layer.cornerRadius = self.itemBgView.frame.size.width/2;
    self.itemBgView.layer.masksToBounds = YES;
}

- (void)bindWithData:(id)aData
{
    NSDictionary *dict = aData;
    
    self.itemBgView.backgroundColor = ORColor([dict objectForKey:@"color"]);
    self.iconView.image = [UIImage imageNamed:[dict objectForKey:@"icon"]];
    self.titleLabel.text = [dict objectForKey:@"title"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self doAnimation];
    });
    
    
}

- (void)doAnimation
{
    POPSpringAnimation *ratationAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    ratationAnimation.velocity = @40;
    ratationAnimation.springBounciness = 28.f;
    ratationAnimation.dynamicsTension = 500;
    [self.iconView.layer pop_addAnimation:ratationAnimation forKey:@"layerRotateSpringAnimation"];
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    //    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.5f, 1.5f)];
    scaleAnimation.duration = 0.8;
    [self.iconView.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

+ (CGSize)sizeForCell
{
    return CGSizeMake(84, 106);
}
@end
