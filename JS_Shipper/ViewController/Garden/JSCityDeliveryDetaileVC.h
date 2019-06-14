//
//  JSCityDeliveryDetaileVC.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/6/14.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "JSHomeDetaileVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSCityDeliveryDetaileVC : JSHomeDetaileVC
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgView;
@property (weak, nonatomic) IBOutlet UILabel *dotNameLab;
@property (weak, nonatomic) IBOutlet UILabel *dotAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@end

NS_ASSUME_NONNULL_END
