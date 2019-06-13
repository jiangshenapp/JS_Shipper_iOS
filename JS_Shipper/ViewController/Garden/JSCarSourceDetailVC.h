//
//  JSCarSourceDetailVC.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/8.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "BaseVC.h"
#import "JSGardenVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSCarSourceDetailVC : BaseVC
/** 车源id */
@property (nonatomic,copy) NSString *carSourceID;
/** 数据源 */
@property (nonatomic,retain) RecordsModel *dataModel;
@end

NS_ASSUME_NONNULL_END
