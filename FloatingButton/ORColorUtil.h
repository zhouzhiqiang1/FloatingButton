//
//  LDColorUtil.h
//  ORead
//
//  Created by chhren on 4/19/14.
//  Copyright (c) 2014 ORead. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ORColor(aColorString) [UIColor colorFromString:aColorString]

/**
 *  color def
 */
#define kORColorGreen_00B757 @"00B757"
#define kORColorBlue_00B9ED @"00b9ed"
#define kORColorRed_FE3F7B @"fe3f7b"
#define kORColorGreen_51D6DB @"51D6DB"
#define kORColorGray_ABABAB @"ABABAB"
#define kORColorGray_99A1A7 @"99A1A7"
#define kORColorGreen_81DBDB @"81DBDB"
#define kORColorRed_EE7385 @"EE7385"
#define kORColorPurple_AC91E0 @"AC91E0"
#define kORColorYellow_EEDD8F @"EEDD8F"
#define kORColorBlue_6DC0EB @"6DC0EB"
#define kORColorOrange_D55403 @"D55403"

#define kORBorderColor @"DEDEDE"

@interface UIColor(Custom)

/**
 *  NSString -》 UIColor
 *
 *  @param aColorString normal:@“#AB12FF” or @“AB12FF” or gray: @"C7"
 *
 *  @return UIColor
 */
+ (UIColor *)colorFromString:(NSString *)aColorString;
/**
 *  NSString -》 UIColor with alpha
 *
 *  @param aColorString normal:@“#AB12FF” or @“AB12FF” or gray: @"C7"
 *  @param aAlpha       alpha 0-1.0
 *
 *  @return UIColor
 */
+ (UIColor *)colorFromString:(NSString *)aColorString alpha:(CGFloat)aAlpha;

/**
 *  UIColor -》 NSString
 *
 *  @param aColor UIColor
 *
 *  @return NSString（format: @“#AB12FF”）
 */
+ (NSString *)stringFromColor:(UIColor *)aColor;

@end
