//
//  CityDeliveryTabCell.m
//  JS_Shipper
//
//  Created by Jason_zyl on 2019/6/18.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "CityDeliveryTabCell.h"

@implementation CityDeliveryTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _navBtn.layer.borderColor = _navBtn.currentTitleColor.CGColor;
    _navBtn.layer.borderWidth = 1;
    _navBtn.layer.cornerRadius = 10;
    _navBtn.layer.masksToBounds = YES;
}

- (void)setModel:(RecordsModel *)model {
    self.dotNameLab.text = model.companyName;
    self.addressLab.text = model.contactAddress;
    self.isShowImgView.image = model.showFlag?[UIImage imageNamed:@"app_list_arrow_up"]:[UIImage imageNamed:@"app_list_arrow_down"];
}

@end
