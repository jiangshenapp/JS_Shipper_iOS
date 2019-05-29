//
//  AddressInfoModel.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/5/29.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "BaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressInfoModel : BaseItem
/** 地址 */
@property (nonatomic,copy) NSString *address;
/** 地址 */
@property (nonatomic,copy) NSString *addressName;
/** 地址 */
@property (nonatomic, assign) CLLocationCoordinate2D pt;
/** 地址 */
@property (nonatomic,copy) NSString *areaCode;
/** 地址 */
@property (nonatomic,copy) NSString *userName;
/** 地址 */
@property (nonatomic,copy) NSString *mobile;
/** 地址 */
@property (nonatomic,copy) NSString *detailAddress;
@end

NS_ASSUME_NONNULL_END
