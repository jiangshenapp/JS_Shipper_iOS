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
    TZImagePickerController *vc = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];;
    vc.naviTitleColor = kBlackColor;
    vc.barItemTextColor = AppThemeColor;
    vc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    };
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)selectPhotoAction2:(UIButton *)sender {
}

- (IBAction)needLoadGoodsType:(UIButton *)sender {
}

- (IBAction)feeSelectAction:(UIButton *)sender {
}

- (IBAction)payTypeAction:(UIButton *)sender {
}

- (IBAction)payTypeAction2:(UIButton *)sender {
}
- (IBAction)bottomLeftBtnAction:(UIButton *)sender {
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
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:_useCarType forKey:@"useCarType"];
    [postDic setObject:_loadingTime forKey:@"loadingTime"];
    [postDic setObject:_goodsTypeTF.text forKey:@"goodsType"];
    [postDic setObject:_goodAreaTF.text forKey:@"goodsVolume"];
}
@end
