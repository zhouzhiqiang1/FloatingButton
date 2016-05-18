//
//  YDRecommendItemCell.h
//  yxtk
//
//  Created by Aren on 16/5/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface YDRecommendItemCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *itemBgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
