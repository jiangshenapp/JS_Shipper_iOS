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
+ (void)EaseMobLoginWithUser:(NSString *)name completion:(loginFinishBlock)completion;
@end

NS_ASSUME_NONNULL_END
