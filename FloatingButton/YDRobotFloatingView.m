//
//  YDRobotFloatingView.m
//  yxtk
//
//  Created by Aren on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YDRobotFloatingView.h"

@implementation YDRobotFloatingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    UITapGestureRecognizer *tapReg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRobotViewTapHandle:)];
    [self addGestureRecognizer:tapReg];
    
    UIPanGestureRecognizer *panReg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [self addGestureRecognizer:panReg];
}

#pragma mark - PanGesture
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        if (self.frame.origin.y + translation.y > self.superview.frame.size.height - self.frame.size.height) {
            translation.y = self.superview.frame.size.height - self.frame.size.height - self.frame.origin.y;
        } else if (self.frame.origin.y + translation.y < 64 ){
//            translation.y = -self.frame.origin.y;
            translation.y = 64 - self.frame.origin.y;
        }
        
        if (self.frame.origin.x + translation.x > self.superview.frame.size.width - self.frame.size.width) {
            translation.x = self.superview.frame.size.width - self.frame.size.width - self.frame.origin.x;
        } else if (self.frame.origin.x + translation.x < 0 ){
            translation.x = -self.frame.origin.x;
        }
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}

- (void)onRobotViewTapHandle:(UITapGestureRecognizer *)gestureRecognizer
{
    if ([self.delegate respondsToSelector:@selector(didTapOnFloatingView:)]) {
        [self.delegate didTapOnFloatingView:self];
    }
}

@end


