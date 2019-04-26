//
//  JSConfirmAddressMapVC.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/25.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "BaseVC.h"
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSConfirmAddressMapVC : BaseVC
@property (weak, nonatomic) IBOutlet MKMapView *gdMapView;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *ceterAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *addressNameLab;
@property (weak, nonatomic) IBOutlet UILabel *addressInfoLab;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@end

@interface SearchTabcell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@end

NS_ASSUME_NONNULL_END
