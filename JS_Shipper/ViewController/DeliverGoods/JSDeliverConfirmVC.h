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
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UITextField *goodAreaTF;
@property (weak, nonatomic) IBOutlet UITextField *goodsTypeTF;
@property (weak, nonatomic) IBOutlet UILabel *goodsTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *useCarTypeLab;
@property (weak, nonatomic) IBOutlet UITextView *markTF;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomRightBtn;

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
/** f付款方式 */
- (IBAction)payTypeAction2:(UIButton *)sender;
/** 底部左按钮点击事件 */
- (IBAction)bottomLeftBtnAction:(UIButton *)sender;
/** 底部右按钮点击事件 */
- (IBAction)bottomRightBtnAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
