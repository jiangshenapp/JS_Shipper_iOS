//
//  JSEditAddressVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/26.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "JSEditAddressVC.h"

@interface JSEditAddressVC ()

@end

@implementation JSEditAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货人";
    _titleAddressLab.text = _addressInfo[@"title"];
    _addressLab.text = _addressInfo[@"address"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmAddressAction:(UIButton *)sender {
    if (_userNameLab.text.length==0) {
        [Utils showToast:@"请填写收货人姓名"];
        return;
    }
    if (_iphoneLab.text.length==0) {
        [Utils showToast:@"请填写收货人手机号"];
        return;
    }
    NSString *text = @"";
    if (_detailAddressLab.text.length>0) {
        text = _detailAddressLab.text;
    }
    NSDictionary *addressDic = @{@"mobel":_iphoneLab.text,@"userName":_userNameLab.text,@"detaileAddress":text};
    if (self.getAddressIgfo) {
        self.getAddressIgfo(addressDic);
    }
    [self backAction];
}
@end
