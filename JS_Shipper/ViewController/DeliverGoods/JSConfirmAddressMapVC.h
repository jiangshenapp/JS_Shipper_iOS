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

@end

NS_ASSUME_NONNULL_END
