//
//  ListOrderModel.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/6/3.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "BaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListOrderModel : BaseItem
/**  */
@property  (nonatomic , copy) NSString *jdSubscriberId;
/**  */
@property  (nonatomic , copy) NSString *goodsType;
/** 2 */
@property  (nonatomic , copy) NSString *receivePosition;
/** 2 */
@property  (nonatomic , copy) NSString *sendMobile;
/** 2 */
@property  (nonatomic , copy) NSString *receiveMobile;
/** 6 */
@property  (nonatomic , copy) NSString *ID;
/**  */
@property  (nonatomic , copy) NSString *image2;
/**  */
@property  (nonatomic , copy) NSString *goodsWeight;
/**  */
@property  (nonatomic , copy) NSString *payTime;
/** 1 */
@property  (nonatomic , copy) NSString *state;
/**  */
@property  (nonatomic , copy) NSString *finishTime;
/**  */
@property  (nonatomic , copy) NSString *payWay;
/**  */
@property  (nonatomic , copy) NSString *image1;
/**  */
@property  (nonatomic , copy) NSString *matchState;
/**  */
@property  (nonatomic , copy) NSString *remark;
/**  */
@property  (nonatomic , copy) NSString *goodsVolume;
/**  */
@property  (nonatomic , copy) NSString *payType;
/** 2 */
@property  (nonatomic , copy) NSString *carLength;
/** 2 */
@property  (nonatomic , copy) NSString *createBy;
/** 2 */
@property  (nonatomic , copy) NSString *sendAddressCode;
/**  */
@property  (nonatomic , copy) NSString *feeType;
/**  */
@property  (nonatomic , copy) NSString *fee;
/**  */
@property  (nonatomic , copy) NSString *loadingTime;
/**  */
@property  (nonatomic , copy) NSString *driverId;
/** 12019052911380644265990155155748 */
@property  (nonatomic , copy) NSString *orderNo;
/** 2 */
@property  (nonatomic , copy) NSString *sendAddress;
/** 2 */
@property  (nonatomic , copy) NSString *sendPosition;
/** 2 */
@property  (nonatomic , copy) NSString *receiveAddressCode;
/**  */
@property  (nonatomic , copy) NSString *transferTime;
/** 2 */
@property  (nonatomic , copy) NSString *sendName;
/** 2 */
@property  (nonatomic , copy) NSString *receiveAddress;
/** 2019-05-29 11:38:06 */
@property  (nonatomic , copy) NSString *createTime;
/**  */
@property  (nonatomic , copy) NSString *receiveName;
/**  */
@property  (nonatomic , copy) NSString *matchSubscriberId;
/**  */
@property  (nonatomic , copy) NSString *useCarType;
/** 2 */
@property  (nonatomic , copy) NSString *carModel;
@end

NS_ASSUME_NONNULL_END
