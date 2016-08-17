/**
 ---------------------------------------------------------------------
 * 文件名：    InputPassword.h
 * 工程名：    SignName
 * 创建者：    Created by YXT on 16/8/16.
 * 所有者：    Copyright © 2016年 YXT. All rights reserved.
 *
 ---------------------------------------------------------------------
 * Date  : 16/8/16
 * Author: YXT
 * Notes :
 *
 ---------------------------------------------------------------------
 */

#import <UIKit/UIKit.h>

@protocol InputPasswordDelegate;

@interface InputPassword : UIView

+ (instancetype)showWithCorrectPassword:(NSString *)password;

@property (nonatomic, weak) id<InputPasswordDelegate>delegate;

@end

@protocol InputPasswordDelegate <NSObject>

@required

- (void)inputPassword:(InputPassword *)inputPassword password:(NSString *)password;

@end

@interface MaskView : UIView

@end