//
//  JSConfirmAddressMapVC.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/25.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "BaseVC.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BMKLocationKit/BMKLocationManager.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSConfirmAddressMapVC : BaseVC
/** 0装货  1卸货 */
@property (nonatomic,assign) NSInteger sourceType;
/** <#object#> */
@property (nonatomic,copy) void (^getAddressinfo)(BMKReverseGeoCodeSearchResult *info);
@property (weak, nonatomic) IBOutlet BMKMapView *bdMapView;
@property (retain, nonatomic)  UIView *titleView;
@property (retain, nonatomic)  UITextField *searchTF;
@property (retain, nonatomic)  UIButton *cityBtn;
@property (retain, nonatomic)  UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *ceterAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *addressNameLab;
@property (weak, nonatomic) IBOutlet UILabel *addressInfoLab;
@property (weak, nonatomic) IBOutlet UIView *centerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getGoodBtnW;
- (IBAction)getAddressInfoAction:(UIButton *)sender;

@end

@interface SearchTabcell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@end

NS_ASSUME_NONNULL_END
