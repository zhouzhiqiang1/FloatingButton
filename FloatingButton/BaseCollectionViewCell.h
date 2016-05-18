//
//  BaseCollectionViewCell.h
//  GlassStore
//
//  Created by noname on 15/4/14.
//  Copyright (c) 2015年 ORead. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell
@property (assign, nonatomic) BOOL isChecked;

- (void)bindWithData:(id)aData;
/**
 *  返回cell的大小, 子类实现
 *
 *  @return CGSzie
 */
+(CGSize)sizeForCell;

/**
 *  setSelected 不好用，自己写
 *
 *  @param isChecked 是否选中
 */
-(void)setChecked:(BOOL)isChecked;
@end
