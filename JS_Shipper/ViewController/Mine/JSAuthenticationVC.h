//
//  JSAuthenticationVC.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/3/26.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSAuthenticationVC : BaseVC
- (IBAction)titleViewAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *personTabHeadView;
@property (weak, nonatomic) IBOutlet UIView *companyTabHeadView;

@end

NS_ASSUME_NONNULL_END
