//
//  CustomEaseUtils.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/7/17.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "CustomEaseUtils.h"

@implementation CustomEaseUtils
+ (void)EaseMobLoginWithUser:(NSString *)name completion:(loginFinishBlock)completion {
    [[EMClient sharedClient] loginWithUsername:name password:name completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            [[EMClient sharedClient].options setIsAutoLogin:YES];
            //发送自动登录状态通知
            completion(aUsername,aError);
            return ;
        }
        else {
//            NSString *errorDes = @"登录失败，请重试";
            if (aError.code==EMErrorUserNotFound) {
                [[EMClient sharedClient] registerWithUsername:name password:name completion:^(NSString *aUsername, EMError *aError) {
                    if (!aError) {
                        [CustomEaseUtils EaseMobLoginWithUser:name completion:^(NSString * _Nonnull aName, EMError * _Nonnull error) {
                            if (!aError) {
                                completion(aName,error);
                            }
                        }];
                    }
                }];
            }
            else {
                completion(@"",aError);
            }
            
//            switch (aError.code) {
//                case EMErrorUserNotFound:
//                    errorDes = @"未找到用户ID";
//                    break;
//                case EMErrorNetworkUnavailable:
//                    errorDes = @"网络未连接";
//                    break;
//                case EMErrorServerNotReachable:
//                    errorDes = @"无法连接服务器";
//                    break;
//                case EMErrorUserAuthenticationFailed:
//                    errorDes = aError.errorDescription;
//                    break;
//                case EMErrorUserLoginTooManyDevices:
//                    errorDes = @"登录设备数已达上限";
//                    break;
//                default:
//                    break;
//            }
        }
    }];
}




@end
