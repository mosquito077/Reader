//
//  PopoverAction.h
//  Popover
//
//  Created by StevenLee on 2016/12/10.
//  Copyright © 2016年 lifution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PopoverViewStyle) {
    PopoverViewStyleDefault = 0,    // 默认风格, 白色
    PopoverViewStyleDark,           // 黑色风格
};

@interface PopoverAction : NSObject

@property (nonatomic, strong, readonly) UIImage *image;      // 图标
@property (nonatomic, copy, readonly) NSString *title;       // 标题
@property (nonatomic, copy, readonly) void(^handler)(PopoverAction *action);

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(PopoverAction *action))handler;

+ (instancetype)actionWithImage:(UIImage *)image title:(NSString *)title handler:(void (^)(PopoverAction *action))handler;

@end
