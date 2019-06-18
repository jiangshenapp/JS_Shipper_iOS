//
//  JSDeliverConfirmVC.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/25.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSDeliverConfirmVC : BaseVC

/** 订单ID */
@property (nonatomic,copy) NSString *orderID;
/** 分配会员，线路/园区关联的subscriberId */
@property (nonatomic,copy) NSString *subscriberId;
/** 是否是综合发货 */
@property (nonatomic,assign) BOOL isAll;

@property (weak, nonatomic) IBOutlet UIView *tabHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *startAddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *endAddressBtn;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
@property (weak, nonatomic) IBOutlet UIButton *carLengthBtn;
@property (weak, nonatomic) IBOutlet UIButton *carModelBtn;

@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UITextField *goodAreaTF;
@property (weak, nonatomic) IBOutlet UITextField *goodsTypeTF;
@property (weak, nonatomic) IBOutlet UILabel *goodsTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *useCarTypeLab;
@property (weak, nonatomic) IBOutlet UITextView *markTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet UITextField *priceLab;
/** 选择货物类型 */
- (IBAction)selectGoodsTypeAction:(id)sender;
/** 选择装货时间 */
- (IBAction)selectGoodsTimeAction:(id)sender;
/** 选择货物类型 */
- (IBAction)selectUseCarTypeAction:(id)sender;
/** 上传照片1 */
- (IBAction)selectPhotoAction1:(UIButton *)sender;
/** a上传照片2 */
- (IBAction)selectPhotoAction2:(UIButton *)sender;
/** 需要装货 卸货 */
- (IBAction)needLoadGoodsType:(UIButton *)sender;
/** 运费 */
- (IBAction)feeSelectAction:(UIButton *)sender;
/** 支付方式 */
- (IBAction)payTypeAction:(UIButton *)sender;
/** 付款方式 */
- (IBAction)payTypeAction2:(UIButton *)sender;
/** 指定发布/下单点击事件 */
- (IBAction)submitAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
