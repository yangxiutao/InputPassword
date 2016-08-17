/**
 ---------------------------------------------------------------------
 * 文件名：    TouchIdManager.h
 * 工程名：    SignName
 * 创建者：    Created by YXT on 16/8/17.
 * 所有者：    Copyright © 2016年 YXT. All rights reserved.
 *
 ---------------------------------------------------------------------
 * Date  : 16/8/17
 * Author: YXT
 * Notes :
 *
 ---------------------------------------------------------------------
 */

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIdManager : NSObject

+ (void)authenticateUser;

@end
