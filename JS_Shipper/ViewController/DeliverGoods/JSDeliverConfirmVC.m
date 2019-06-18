//
//  JSDeliverConfirmVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/25.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "JSDeliverConfirmVC.h"
#import "ZHPickView.h"
#import "TZImagePickerController.h"
#import "JSConfirmAddressMapVC.h"
#import "FilterCustomView.h"

@interface JSDeliverConfirmVC ()<TZImagePickerControllerDelegate>
{
   __block NSInteger imageType;
}
/** 起止点 */
@property (nonatomic,retain) AddressInfoModel *info1;
/** 终止点 */
@property (nonatomic,retain) AddressInfoModel *info2;
/** 车身车长 */
@property (nonatomic,retain) FilterCustomView *carLengthView;
/** 车长数组 */
@property (nonatomic,retain) NSArray *carLengthArr;
/** 车型数组 */
@property (nonatomic,retain) NSArray *carModelArr;
/** 车长 */
@property (nonatomic,retain) NSDictionary *carLengthDic;
/** 车型 */
@property (nonatomic,retain) NSDictionary *carModelDic;
/** 点击类型  1车长 2车型 */
@property (nonatomic,assign) NSInteger touchType;

/** 运费 */
@property (nonatomic,copy) NSString *fee;
/** 运费类型，1自己出价，2电议 */
@property (nonatomic,copy) NSString *feeType;
/** 货物类型,字典表，多个 */
@property (nonatomic,copy) NSString *goodsType;
/** 货物体积，单位立方米 */
@property (nonatomic,copy) NSString *goodsVolume;
/** 货物重量、吨 */
@property (nonatomic,copy) NSString *goodsWeight;
/** 图1 */
@property (nonatomic,copy) NSString *image1;
/** 图2 */
@property (nonatomic,copy) NSString *image2;
/** 装货时间 */
@property (nonatomic,copy) NSString *loadingTime;
/** 付款方式，1到付，2现付 */
@property (nonatomic,copy) NSString *payType;
/** 支付方式，1线上支付，2线下支付 */
@property (nonatomic,copy) NSString *payWay;
/** 备注 */
@property (nonatomic,copy) NSString *remark;
/** 用车类型，字典 */
@property (nonatomic,copy) NSString *useCarType;
/** 用车类型 */
@property (nonatomic,retain) NSArray *useCarTypeArr;

@end

@implementation JSDeliverConfirmVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_carLengthView hiddenView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    
    _touchType = 0;
    _carLengthView =  [[FilterCustomView alloc]init];
    _carLengthView.viewHeight = HEIGHT-kNavBarH-kTabBarSafeH;;
    _carLengthView.top = kNavBarH;
    __weak typeof(self) weakSelf = self;
    _carLengthView.getPostDic = ^(NSDictionary * _Nonnull dic, NSArray * _Nonnull titles) {
        if (weakSelf.touchType==1) {
            weakSelf.carLengthDic = dic;
            [weakSelf.carLengthBtn setTitle:[titles firstObject] forState:UIControlStateNormal];
        }
        else if (weakSelf.touchType==2) {
            weakSelf.carModelDic = dic;
            [weakSelf.carModelBtn setTitle:[titles firstObject] forState:UIControlStateNormal];
        }
    };
    _image1 = @"";
    _image2 = @"";
    _remark = @"";
    self.feeType = @"1";
    self.payWay = @"1";
    self.payType = @"1";
    if (_isAll) { //综合发货
        _tabHeaderView.height = 1185;
        self.title = @"发货";
    }
    else {
        _tabHeaderView.height = 925;
    }
    if (![Utils isBlankString:self.subscriberId]) { //指定发布
        [_submitBtn setTitle:@"指定发布" forState:UIControlStateNormal];
    } else {
        [_submitBtn setTitle:@"下单" forState:UIControlStateNormal];
    }
    [self.baseTabView reloadData];
    UIButton *otherBtn = [self.view viewWithTag:100];
    [self needLoadGoodsType:otherBtn];
    [self getCarLengthInfo]; //车长
    [self getCarModelInfo]; //车型
    [self getCarTypeInfo]; //用车类型
}

#pragma mark - 车长
/** 车长 */
- (void)getCarLengthInfo {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *url = [NSString stringWithFormat:@"%@?type=carLength",URL_GetDictByType];
    [[NetworkManager sharedManager] postJSON:url parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            NSArray *arr = responseData;
            if ([arr isKindOfClass:[NSArray class]]) {
                weakSelf.carLengthArr = [NSArray arrayWithArray:arr];
            }
        }
    }];
}

#pragma mark - 车型
/** 车型 */
- (void)getCarModelInfo {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *url = [NSString stringWithFormat:@"%@?type=carModel",URL_GetDictByType];
    [[NetworkManager sharedManager] postJSON:url parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            NSArray *arr = responseData;
            if ([arr isKindOfClass:[NSArray class]]) {
                weakSelf.carModelArr = [NSArray arrayWithArray:arr];
            }
        }
    }];
}

#pragma mark - 用车类型
/** 用车类型 */
- (void)getCarTypeInfo {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *url = [NSString stringWithFormat:@"%@?type=useCarType",URL_GetDictByType];
    [[NetworkManager sharedManager] postJSON:url parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            NSArray *arr = responseData;
            if ([arr isKindOfClass:[NSArray class]]) {
                weakSelf.useCarTypeArr = [NSArray arrayWithArray:arr];
            }
        }
    }];
}

#pragma mark - 选择地址
/** 选择地址 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    __weak typeof(self) weakSelf = self;
    JSConfirmAddressMapVC *vc = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"start"]) {
        vc.sourceType = 0;
        vc.getAddressinfo = ^(AddressInfoModel * _Nonnull info) {
            [weakSelf.startAddressBtn setTitle:info.address forState:UIControlStateNormal];
            weakSelf.info1 = info;
            if (weakSelf.info1&&weakSelf.info2) {
                NSString *disStr = [Utils distanceBetweenOrderBy:weakSelf.info1.pt.latitude :weakSelf.info2.pt.latitude :weakSelf.info1.pt.longitude :weakSelf.info2.pt.longitude];
                weakSelf.distanceLab.text = [NSString stringWithFormat:@"总里程:%@",disStr];
            }
        };
    }
    else if ([segue.identifier isEqualToString:@"end"]) {
        vc.sourceType = 1;
        vc.getAddressinfo = ^(AddressInfoModel * _Nonnull info) {
            [weakSelf.endAddressBtn setTitle:info.address forState:UIControlStateNormal];
            weakSelf.info2 = info;
            if (weakSelf.info1&&weakSelf.info2) {
                NSString *disStr = [Utils distanceBetweenOrderBy:weakSelf.info1.pt.latitude :weakSelf.info2.pt.latitude :weakSelf.info1.pt.longitude :weakSelf.info2.pt.longitude];
                weakSelf.distanceLab.text = [NSString stringWithFormat:@"总里程:%@",disStr];
            }
        };
    }
}

#pragma mark - 选择车长
/** 选择车长 */
- (IBAction)carLengthAction:(id)sender {
    if (_carLengthArr.count==0) {
        return;
    }
    _touchType = 1;
    self.carLengthView.dataDic = @{@"carLength":self.carLengthArr};
    [_carLengthView showView];
}

#pragma mark - 选择车型
/** 选择车型 */
- (IBAction)carModelAction:(id)sender {
    if (_carModelArr.count==0) {
        return;
    }
    _touchType = 2;
    self.carLengthView.dataDic = @{@"carModel":self.carModelArr};
    [_carLengthView showView];
}

#pragma mark - 选择货物类型
/** 选择货物类型 */
- (IBAction)selectGoodsTypeAction:(id)sender {
    
}

#pragma mark - 选择装货时间
/** 选择装货时间 */
- (IBAction)selectGoodsTimeAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    ZHPickView *pickView = [[ZHPickView alloc] init];
    [pickView setDateViewWithTitle:@"装货时间"];
    [pickView showPickView:self];
    pickView.block = ^(NSString *selectedStr) {
        weakSelf.loadingTime = selectedStr;
        weakSelf.goodsTimeLab.text = selectedStr;
        weakSelf.goodsTimeLab.textColor = [UIColor grayColor];
    };
}

#pragma mark - 选择用车类型
/** 选择用车类型 */
- (IBAction)selectUseCarTypeAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    ZHPickView *pickView = [[ZHPickView alloc] init];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in self.useCarTypeArr) {
        [arr addObject:dic[@"label"]];
    }
    [pickView setDataViewWithItem:arr title:@"用车类型"];
    [pickView showPickView:self];
    pickView.block = ^(NSString *selectedStr) {
        weakSelf.useCarType = weakSelf.useCarTypeArr[[arr indexOfObject:selectedStr]][@"value"];
        weakSelf.useCarTypeLab.text = selectedStr;
        weakSelf.useCarTypeLab.textColor = [UIColor grayColor];
    };
}

#pragma mark - 上传照片左
/** 上传照片左 */
- (IBAction)selectPhotoAction1:(UIButton *)sender {
    imageType = 1;
    __weak typeof(self) weakSelf = self;
    TZImagePickerController *vc = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];;
    vc.naviTitleColor = kBlackColor;
    vc.barItemTextColor = AppThemeColor;
    vc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count>0) {
            UIImage *firstimg = [photos firstObject];
            [sender setImage:firstimg forState:UIControlStateNormal];
            [weakSelf postImage:firstimg];
        }
    };
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 上传照片右
/** 上传照片右 */
- (IBAction)selectPhotoAction2:(UIButton *)sender {
    imageType = 2;
    __weak typeof(self) weakSelf = self;
    TZImagePickerController *vc = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];;
    vc.naviTitleColor = kBlackColor;
    vc.barItemTextColor = AppThemeColor;
    vc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count>0) {
            UIImage *firstimg = [photos firstObject];
            [sender setImage:firstimg forState:UIControlStateNormal];
            [weakSelf postImage:firstimg];
        }
    };
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 上传照片
/** 上传照片 */
- (void)postImage:(UIImage *)iconImage {
    __weak typeof(self) weakSelf = self;
    NSData *imageData = UIImageJPEGRepresentation(iconImage, 0.01);
    NSMutableArray *imageDataArr = [NSMutableArray arrayWithObjects:imageData, nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"pigx",@"resourceId", nil];
    [[NetworkManager sharedManager] postJSON:URL_FileUpload parameters:dic imageDataArr:imageDataArr imageName:@"file" completion:^(id responseData, RequestState status, NSError *error) {
        if (status == Request_Success) {
            NSString *photo = responseData;
            if (self->imageType==1) {
                weakSelf.image1 = photo;
            }
            else if (self->imageType==2) {
                weakSelf.image2 = photo;
            }
        }
    }];
}

#pragma mark - 需要搬货/卸货
/** 需要搬货/卸货 */
- (IBAction)needLoadGoodsType:(UIButton *)sender {
    sender.selected = YES;
    sender.borderColor = AppThemeColor;
    sender.borderWidth = 1;
    sender.cornerRadius = 5;
    
    NSInteger otherTag = sender.tag==100?101:100;
    UIButton *otherBtn = [self.view viewWithTag:otherTag];
    otherBtn.selected = NO;
    otherBtn.borderColor = RGBValue(0xc8c8c8);
    otherBtn.borderWidth = 1;
    otherBtn.cornerRadius = 5;
}

#pragma mark - 自己出价/电议
/** 自己出价/电议 */
- (IBAction)feeSelectAction:(UIButton *)sender {
    self.feeType = sender.tag==110?@"1":@"2";
    sender.selected = YES;
    NSInteger otherTag = sender.tag==110?111:110;
    UIButton *otherBtn = [self.view viewWithTag:otherTag];
    otherBtn.selected = NO;
}

#pragma mark - 支付方式
/** 支付方式 */
- (IBAction)payTypeAction:(UIButton *)sender {
    self.payWay = sender.tag==120?@"1":@"2";
    sender.selected = YES;
    NSInteger otherTag = sender.tag==120?121:120;
    UIButton *otherBtn = [self.view viewWithTag:otherTag];
    otherBtn.selected = NO;
}

#pragma mark - 付款方式
/** 付款方式 */
- (IBAction)payTypeAction2:(UIButton *)sender {
    self.payType = sender.tag==130?@"1":@"2";
    sender.selected = YES;
    NSInteger otherTag = sender.tag==130?131:130;
    UIButton *otherBtn = [self.view viewWithTag:otherTag];
    otherBtn.selected = NO;
}

#pragma mark - 指定发布/下单
/** 指定发布/下单 */
- (IBAction)submitAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr = URL_AddStepTwo;
    if (_isAll) { //综合发布
        urlStr = URL_AddOrder;
        [dic addEntriesFromDictionary:_carLengthDic];
        [dic addEntriesFromDictionary:_carModelDic];
        if (_info1.address.length==0) {
            [Utils showToast:@"请选择发货地址"];
            return;
        }
        if (_info2.address.length==0) {
            [Utils showToast:@"请选择收获地址"];
            return;
        }
        if (_info1.address.length>0) {
            [dic setObject:_info1.address forKey:@"sendAddress"];
            [dic setObject:_info1.areaCode forKey:@"sendAddressCode"];
            if (_info1.mobile) {
                [dic setObject:_info1.mobile forKey:@"sendMobile"];
                [dic setObject:_info1.userName forKey:@"sendName"];
            }
            NSDictionary *locDic = @{@"latitude":@(_info1.pt.latitude),@"longitude":@(_info1.pt.longitude)};
            [dic setObject:[locDic jsonStringEncoded] forKey:@"sendPosition"];
        }
        if (_info2.address.length>0) {
            [dic setObject:_info2.address forKey:@"receiveAddress"];
            [dic setObject:_info2.areaCode forKey:@"receiveAddressCode"];
            if (_info2.mobile.length>0) {
                [dic setObject:_info2.mobile forKey:@"receiveMobile"];
                [dic setObject:_info2.userName forKey:@"receiveName"];
            }
            NSDictionary *locDic = @{@"latitude":@(_info2.pt.latitude),@"longitude":@(_info2.pt.longitude)};
            [dic setObject:[locDic jsonStringEncoded] forKey:@"receivePosition"];
        }
    }
    if ([NSString isEmpty:_weightTF.text]) {
        [Utils showToast:@"请输入货物重量"];
        return;
    }
    if ([NSString isEmpty:_goodAreaTF.text]) {
        [Utils showToast:@"请输入货物体积"];
        return;
    }
    if ([NSString isEmpty:_goodsTypeTF.text]) {
        [Utils showToast:@"请输入货物类型"];
        return;
    }
    if ([NSString isEmpty:_loadingTime]) {
        [Utils showToast:@"请选择装货时间"];
        return;
    }
    if ([NSString isEmpty:_useCarType]) {
        [Utils showToast:@"请选择用车类型"];
        return;
    }
    if (_markTF.text.length>0) {
        _remark = _markTF.text;
    }
    _fee = @"";
    if ([_feeType integerValue]==1) {
        if ([NSString isEmpty:_priceLab.text]) {
            [Utils showToast:@"请输入价格"];
            return;
        }
        _fee = _priceLab.text;
    }
    
    if (![Utils isBlankString:_subscriberId]) {
        [dic setObject:_subscriberId forKey:@"matchId"];
    }
    if (![Utils isBlankString:_orderID]) {
        [dic setObject:_orderID forKey:@"id"];
    }
    [dic setObject:_useCarType forKey:@"useCarType"];
    [dic setObject:_loadingTime forKey:@"loadingTime"];
    [dic setObject:_goodsTypeTF.text forKey:@"goodsType"];
    [dic setObject:_weightTF.text forKey:@"goodsWeight"];
    [dic setObject:_goodAreaTF.text forKey:@"goodsVolume"];
    [dic setObject:_image1 forKey:@"image1"];
    [dic setObject:_image2 forKey:@"image2"];
    [dic setObject:_remark forKey:@"remark"];
    [dic setObject:_feeType forKey:@"feeType"];
    [dic setObject:_fee forKey:@"fee"];
    [dic setObject:_payWay forKey:@"payWay"];
    [dic setObject:_payType forKey:@"payType"];
    [[NetworkManager sharedManager] postJSON:urlStr parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            if ([Utils isBlankString:self.subscriberId]) {
                [Utils showToast:@"下单成功"];
            } else {
                [Utils showToast:@"指定发布成功"];
            }
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

@end
