//
//  BaseCollectionViewCell.m
//  GlassStore
//
//  Created by noname on 15/4/14.
//  Copyright (c) 2015年 ORead. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

-(void)setChecked:(BOOL)isChecked
{
    _isChecked = isChecked;
}

+(CGSize)sizeForCell
{
    return CGSizeZero;
}

- (void)bindWithData:(id)aData
{
    
}

#pragma mark - 重用
-(void)prepareForReuse
{
    [super prepareForReuse];
    [self setChecked:NO];
}

@end
