//
//  ZZQUserSetting.h
//  FloatingButton
//
//  Created by r_zhou on 16/5/17.
//  Copyright © 2016年 r_zhous. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  聊天按钮悬浮窗口位置
 */
static NSString * const ORSettingsRobotPosition = @"ORSettingsRobotPosition";

@interface ZZQUserSetting : NSObject
+ (NSString *)stringOfKey:(NSString *)aKey;
+ (void)setString:(NSString *)aString forKey:(NSString *)aKey;

+ (BOOL)boolOfKey:(NSString *)aKey;
+ (void)setBool:(BOOL)aBool forKey:(NSString *)aKey;

+ (NSNumber *)numberOfKey:(NSString *)aKey;
+ (void)setNumber:(NSNumber *)aNumber forKey:(NSString *)aKey;

+ (NSDictionary *)dictionaryOfKey:(NSString *)aKey;
+ (void)setDictionary:(NSDictionary *)aDictionary forKey:(NSString *)aKey;

+ (NSData *)dataOfKey:(NSString *)aKey;
+ (void)setData:(NSData *)aData forKey:(NSString *)aKey;

+ (NSValue *)valueOfKey:(NSString *)aKey;
+ (void)setValue:(NSValue *)aValue forKey:(NSString *)aKey;

+ (CGPoint)pointOfKey:(NSString *)aKey;
+ (void)setPoint:(CGPoint)aPoint forKey:(NSString *)aKey;

+ (NSDictionary *)dictionaryFromPListFile:(NSString *)aPListFile;

+ (void)synchronize;
+ (void)removeObjectForKey:(NSString *)aKey;
@end

