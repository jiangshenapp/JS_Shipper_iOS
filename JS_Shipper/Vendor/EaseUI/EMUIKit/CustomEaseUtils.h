//
//  CustomEaseUtils.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/7/17.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^loginFinishBlock)(NSString *aName,EMError *error);

@interface CustomEaseUtils : NSObject

/** 注册环信 用户名和密码均为手机号*/
+ (void)EaseMobRegisteWithUser:(NSString *)name completion:(loginFinishBlock)completion;

/** 登录环信 用户名和密码均为用户手机号 */
+ (void)EaseMobLoginWithUser:(NSString *)name completion:(loginFinishBlock)completion;

/** 退出登录 */
+ (void)EaseMobLogout;;

@end

NS_ASSUME_NONNULL_END
