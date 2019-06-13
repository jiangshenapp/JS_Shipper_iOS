//
//  JSGardenVC.h
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSGardenVC : BaseVC
@property (weak, nonatomic) IBOutlet UIView *titleView;
- (IBAction)titleBtnAction:(UIButton*)sender;
@property (weak, nonatomic) IBOutlet UIView *filterView;

@end

@interface JSGardenTabCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *endAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *countBtn;
@property (weak, nonatomic) IBOutlet UIButton *iphoneCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendMsgBtn;
@end


@interface CityDeliveryTabCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dotNameLab;
@property (weak, nonatomic) IBOutlet UILabel *dustanceLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIButton *navBtn;
@property (weak, nonatomic) IBOutlet UIButton *serviceBtn;
@property (weak, nonatomic) IBOutlet UIImageView *isShowImgView;
@property (weak, nonatomic) IBOutlet UIButton *iphoneCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendMsgBtn;

@end

@interface FilterButton : UIButton
/** 是否选中 */
@property (nonatomic,assign) BOOL isSelect;
/** icon */
@property (nonatomic,retain)  UIImageView *imgView;
/** 文字 */
@property (nonatomic,retain) UILabel *titleLab;
@end

@interface RecordsModel : BaseItem
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *cphm;
@property (nonatomic,copy) NSString *driverPhone;
@property (nonatomic,copy) NSString *classic;
@property (nonatomic,copy) NSString *carModel;
@property (nonatomic,copy) NSString *carModelName;

@property (nonatomic,copy) NSString *carLength;
@property (nonatomic,copy) NSString *carLengthName;

@property (nonatomic,copy) NSString *subscriberId;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *driverName;
@property (nonatomic,copy) NSString *arriveAddressCode;
@property (nonatomic,copy) NSString *startAddressCode;
@property (nonatomic,copy) NSString *startAddressCodeName;
/** arriveAddressCodeName */
@property (nonatomic,copy) NSString *arriveAddressCodeName;
/** receiveAddressCodeName */
@property (nonatomic,copy) NSString *receiveAddressCodeName;
@end

@interface HomeDataModel : BaseItem
/** 数据源 */
@property (nonatomic,retain) NSArray<RecordsModel *> *records;
@property (nonatomic,copy) NSString *size;
@property (nonatomic,copy) NSString *current;
@property (nonatomic,copy) NSString *searchCount;
@property (nonatomic,copy) NSString *pages;
@property (nonatomic,copy) NSString *total;
@end


NS_ASSUME_NONNULL_END
