//
//  CityDeliveryTabCell.m
//  JS_Shipper
//
//  Created by Jason_zyl on 2019/6/18.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "CityDeliveryTabCell.h"
#import "XLGMapNavVC.h"

@implementation CityDeliveryTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _navBtn.layer.borderColor = _navBtn.currentTitleColor.CGColor;
    _navBtn.layer.borderWidth = 1;
    _navBtn.layer.cornerRadius = 10;
    _navBtn.layer.masksToBounds = YES;
    [_navBtn addTarget:self action:@selector(showNavAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setModel:(RecordsModel *)model {
    self.dotNameLab.text = model.companyName;
    self.addressLab.text = model.contactAddress;
    self.isShowImgView.image = model.showFlag?[UIImage imageNamed:@"app_list_arrow_up"]:[UIImage imageNamed:@"app_list_arrow_down"];
    
    NSDictionary *contactLocDic = [Utils dictionaryWithJsonString:model.contactLocation];
    NSDictionary *locDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"loc"];
    NSString *distanceStr = [NSString stringWithFormat:@"距离您%@",[Utils distanceBetweenOrderBy:[locDic[@"lat"] floatValue] :[contactLocDic[@"latitude"] floatValue] :[locDic[@"lng"] floatValue] :[contactLocDic[@"longitude"] floatValue]]];
    self.dustanceLab.text = distanceStr;
}

#pragma mark - 导航
/** 导航 */
-(void)showNavAction:(MyCustomButton *)sender {
    RecordsModel *model = sender.dataDic;
    NSDictionary *contactLocDic = [Utils dictionaryWithJsonString:model.contactLocation];
    [XLGMapNavVC share].destionName = model.companyName;
    [XLGMapNavVC startNavWithEndPt:CLLocationCoordinate2DMake([contactLocDic[@"latitude"] floatValue], [contactLocDic[@"longitude"] floatValue])];
}


@end
