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

@interface JSDeliverConfirmVC ()<TZImagePickerControllerDelegate>
{
   __block NSInteger imageType;
}
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
@end

@implementation JSDeliverConfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    _image1 = @"";
    _image2 = @"";
    _remark = @"";
    self.feeType = @"1";
    self.payWay = @"1";
    self.payType = @"1";
    UIButton *otherBtn = [self.view viewWithTag:100];
    [self needLoadGoodsType:otherBtn];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectGoodsTypeAction:(id)sender {
}

- (IBAction)selectGoodsTimeAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    ZHPickView *pickView = [[ZHPickView alloc] init];
    [pickView setDateViewWithTitle:@"装货时间"];
    [pickView showPickView:self];
    pickView.block = ^(NSString *selectedStr) {
        selectedStr = [NSString stringWithFormat:@"%@:00",selectedStr];
        weakSelf.loadingTime = selectedStr;
        weakSelf.goodsTimeLab.text = selectedStr;
        weakSelf.goodsTimeLab.textColor = [UIColor grayColor];
    };
}

- (IBAction)selectUseCarTypeAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    ZHPickView *pickView = [[ZHPickView alloc] init];
    [pickView setDataViewWithItem:@[@"零担",@"整车"] title:@"用车类型"];
    [pickView showPickView:self];
    pickView.block = ^(NSString *selectedStr) {
        weakSelf.useCarType = selectedStr;
        weakSelf.useCarTypeLab.text = selectedStr;
        weakSelf.useCarTypeLab.textColor = [UIColor grayColor];
    };
}

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

- (IBAction)feeSelectAction:(UIButton *)sender {
    self.feeType = sender.tag==110?@"1":@"2";
    sender.selected = YES;
    NSInteger otherTag = sender.tag==110?111:110;
    UIButton *otherBtn = [self.view viewWithTag:otherTag];
    otherBtn.selected = NO;
}

- (IBAction)payTypeAction:(UIButton *)sender {
    self.payWay = sender.tag==120?@"1":@"2";
    sender.selected = YES;
    NSInteger otherTag = sender.tag==120?121:120;
    UIButton *otherBtn = [self.view viewWithTag:otherTag];
    otherBtn.selected = NO;
}

- (IBAction)payTypeAction2:(UIButton *)sender {
    self.payType = sender.tag==130?@"1":@"2";
    sender.selected = YES;
    NSInteger otherTag = sender.tag==130?131:130;
    UIButton *otherBtn = [self.view viewWithTag:otherTag];
    otherBtn.selected = NO;
}
- (IBAction)bottomLeftBtnAction:(UIButton *)sender {
}

- (void)postImage:(UIImage *)iconImage {
    __weak typeof(self) weakSelf = self;
    NSData *imageData = UIImageJPEGRepresentation(iconImage, 0.01);
    NSMutableArray *imageDataArr = [NSMutableArray arrayWithObjects:imageData, nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"pigx",@"resourceId", nil];
    [[NetworkManager sharedManager] postJSON:URL_FileUpload parameters:dic imageDataArr:imageDataArr imageName:@"file" completion:^(id responseData, RequestState status, NSError *error) {
        if (status == Request_Success) {
            NSString *photo = responseData;
            if (imageType==1) {
                weakSelf.image1 = photo;
            }
            else if (imageType==2) {
                weakSelf.image2 = photo;
            }
        }
    }];
}

- (IBAction)bottomRightBtnAction:(UIButton *)sender {
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
        if ([NSString isEmpty:_goodsTypeTF.text]) {
            [Utils showToast:@"请输入价格"];
            return;
        }
        _fee = _goodsTypeTF.text;
    }
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:_useCarType forKey:@"useCarType"];
    [postDic setObject:_loadingTime forKey:@"loadingTime"];
    [postDic setObject:_goodsTypeTF.text forKey:@"goodsType"];
    [postDic setObject:_goodAreaTF.text forKey:@"goodsVolume"];
    [postDic setObject:_image1 forKey:@"image1"];
    [postDic setObject:_image2 forKey:@"image2"];
    [postDic setObject:_remark forKey:@"remark"];
    [postDic setObject:_feeType forKey:@"feeType"];
    [postDic setObject:_fee forKey:@"fee"];
    [postDic setObject:_payWay forKey:@"payWay"];
    [postDic setObject:_payType forKey:@"payType"];
    [[NetworkManager sharedManager] postJSON:URL_AddStepTwo parameters:postDic completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            [Utils showToast:@"下单成功"];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}
@end
