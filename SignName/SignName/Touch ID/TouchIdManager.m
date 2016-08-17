/**
 ---------------------------------------------------------------------
 * 文件名：    TouchIdManager.m
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

#import "TouchIdManager.h"

@implementation TouchIdManager

/**
 *  验证设备是否支持 指纹验证
 */
+ (void)authenticateUser{
    
    //初 始 化 上 下 文 对 象
    LAContext *context = [[LAContext alloc]init];
    
    context.localizedFallbackTitle = @";;";
    
    //错 误 对 象
    NSError  *error = nil;
    
    NSString *result = @"我 要 访 问 你 的 手 机 ！";
    
    //首 先 使 用 canEvaluatePolicy 判 断 设 备 支 持 状 态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                //验 证 成 功，主 线 程 处 理 UI
            
            }else{
                //驗 證 失 敗，失 敗 的 原 因
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"Authentication was cancelled by the system");
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"Authentication was cancelled by the user");
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        NSLog(@"User selected to enter custom password");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
            
                }
            }
        }];
    }else
    {
        //不支持指纹识别，LOG出错误详情
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}

@end
