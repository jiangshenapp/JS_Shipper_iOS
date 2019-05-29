//
//  JSEditAddressVC.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/26.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSEditAddressVC : BaseVC
/** 用户信息 */
@property (nonatomic,retain) NSDictionary *addressInfo;
@property (weak, nonatomic) IBOutlet UILabel *titleAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressLab;
@property (weak, nonatomic) IBOutlet UITextField *userNameLab;
@property (weak, nonatomic) IBOutlet UITextField *iphoneLab;
/** 获取到收货人信息 */
@property (nonatomic,copy) void (^getAddressIgfo)(NSDictionary *getAddressIgfo);
- (IBAction)confirmAddressAction:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
