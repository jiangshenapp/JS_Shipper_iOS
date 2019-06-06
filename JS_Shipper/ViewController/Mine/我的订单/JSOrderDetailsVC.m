//
//  JSOrderDetailsVC.m
//  JS_Shipper
//
//  Created by Jason_zyl on 2019/6/4.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "JSOrderDetailsVC.h"
#import "JSOrderDetailMapVC.h"

@interface JSOrderDetailsVC ()

@end

@implementation JSOrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgScroView.contentSize = CGSizeMake(0, _receiptView.bottom+50);
    self.title = @"我的订单";
    self.tileView1.hidden = YES;
    self.titleView2.hidden = NO;
    
    [self getData];
}

#pragma mark - get data
- (void)getData {
    NSDictionary *dic = [NSDictionary dictionary];
    [[NetworkManager sharedManager] postJSON:[NSString stringWithFormat:@"%@/%@",URL_GetOrderDetail,self.model.ID] parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status == Request_Success) {
            //将用户信息解析成model
            self.model = [ListOrderModel mj_objectWithKeyValues:(NSDictionary *)responseData];
            [self initView];
            [self initData];
        }
    }];
}

#pragma mark - init data
- (void)initData {
    
//    self.model.state = @"9";
    
    [self.headImgView2 sd_setImageWithURL:[NSURL URLWithString:self.model.driverAvatar] placeholderImage:[UIImage imageNamed:@"personalcenter_driver_icon_head_land"]];
    self.nameLab.text = self.model.driverName;
    self.orderNoLab.text = [NSString stringWithFormat:@"订单编号：%@",self.model.orderNo];
    self.orderStatusLab.text = self.model.stateNameConsignor;
    self.startAddressLab.text = self.model.sendAddress;
    self.endAddressLab.text = self.model.receiveAddress;
    self.goodsTomeLab.text = self.model.loadingTime;
    self.carInfoLab.text = [NSString stringWithFormat:@"%@%@米/%@方/%@吨",self.model.carModelName,self.model.carLength,self.model.goodsVolume,self.model.goodsWeight];;
    self.goodsTypeLab.text = self.model.goodsType;
    self.carTypeLab.text = self.model.useCarType;
    if ([self.model.payWay isEqualToString:@"1"]) {
        self.payTypeLab.text = @"线上支付";
    } else {
        self.payTypeLab.text = @"线下支付";
    }
    if ([self.model.feeType isEqualToString:@"1"]) {
        self.orderFeeLab.text = [NSString stringWithFormat:@"￥%@",self.model.fee];
    } else {
        self.orderFeeLab.text = @"面仪";
    }
    if ([self.model.payType isEqualToString:@"1"]) {
        self.goodsPayTypeLab.text = @"到付";
    } else {
        self.goodsPayTypeLab.text = @"现付";
    }
    self.explainLab.text = self.model.remark;
    self.receiptNameLab.text = self.model.receiveName;
    self.receiptNumerLab.text = self.model.receiveMobile;
}

#pragma mark - init view
- (void)initView {
    
    
    //1发布中，2待司机接单，3待司机确认，4待支付，5待司机接货, 6待收货，7待评价，8已完成，9已取消，10已关闭
    NSInteger state = [self.model.state integerValue];
    switch (state) {
        case 1:
            self.tileView1.hidden = NO;
            self.titleView2.hidden = YES;
            self.bookTimeLab.text = [NSString stringWithFormat:@"已为您通知%@个司机",self.model.driverNum];
            [self.bottomLeftBtn setTitle:@"取消发布" forState:UIControlStateNormal];
            [self.bottomRightBtn setTitle:@"再发一次" forState:UIControlStateNormal];
            break;
        case 2:
            
            break;
        case 3: //车主待确认
            [self.bottomLeftBtn setTitle:@"取消发布" forState:UIControlStateNormal];
            [self.bottomRightBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            self.bottomRightBtn.userInteractionEnabled = NO;
            self.bottomRightBtn.backgroundColor = RGBValue(0xB4B4B4);
            break;
        case 4: //车主已确认，待支付
            [self.bottomLeftBtn setTitle:@"取消发布" forState:UIControlStateNormal];
            [self.bottomRightBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            break;
        case 5: //待配送
            self.bottomBtn.hidden = NO;
            self.bottomLeftBtn.hidden = YES;
            self.bottomRightBtn.hidden = YES;
            [self.bottomBtn setTitle:@"取消发货" forState:UIControlStateNormal];
            break;
        case 6: //运输中，待收货
            [self.bottomLeftBtn setTitle:@"查看路线" forState:UIControlStateNormal];
            [self.bottomRightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            break;
        case 7: //待评价
            [self.bottomLeftBtn setTitle:@"查看路线" forState:UIControlStateNormal];
            [self.bottomRightBtn setTitle:@"评价" forState:UIControlStateNormal];
            break;
        case 8: //已完成
            self.orderStatusLab.hidden = YES;
            [self.bottomLeftBtn setTitle:@"查看路线" forState:UIControlStateNormal];
            [self.bottomRightBtn setTitle:@"重新发货" forState:UIControlStateNormal];
            break;
        case 9: //已取消
            self.bottomBtn.hidden = NO;
            self.bottomLeftBtn.hidden = YES;
            self.bottomRightBtn.hidden = YES;
            [self.bottomBtn setTitle:@"重新发货" forState:UIControlStateNormal];
            break;
        case 10:
            
            break;
        default:
            break;
    }
}

- (IBAction)bottomLeftBtnAction:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    if ([title isEqualToString:@"取消发布"]) {
        [Utils showToast:@"取消发布"];
        [self cancleOrder];
    }
    if ([title isEqualToString:@"查看路线"]) {
        [Utils showToast:@"查看路线"];
        [self showRoutOrder];
    }
}

- (IBAction)bottomRightBtnAction:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    if ([title isEqualToString:@"再发一次"]) {
        [Utils showToast:@"再发一次"];
        [self againPushlishOrder];
    }
    if ([title isEqualToString:@"立即支付"]) {
        [Utils showToast:@"立即支付"];
        [self payOrder];
    }
    if ([title isEqualToString:@"确认收货"]) {
        [Utils showToast:@"确认收货"];
        [self confirmGoodsOrder];
    }
    if ([title isEqualToString:@"评价"]) {
        [Utils showToast:@"评价"];
        [self commentOrder];
    }
    if ([title isEqualToString:@"重新发货"]) {
        [Utils showToast:@"重新发货"];
        [self renewDeliverOrder];
    }
}

- (IBAction)bottomBtnAction:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    if ([title isEqualToString:@"取消发货"]) {
        [Utils showToast:@"取消发货"];
        [self cancleDeliverOrder];
    }
    if ([title isEqualToString:@"重新发货"]) {
        [Utils showToast:@"重新发货"];
         [self renewDeliverOrder];
    }
}

#pragma mark - 取消订单
/** 取消订单 */
- (void)cancleOrder {
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [NSDictionary dictionary];
    [[NetworkManager sharedManager] postJSON:[NSString stringWithFormat:@"%@/%@",URL_CancelOrderDetail,self.model.ID] parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status == Request_Success) {
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
        }
    }];
}

#pragma mark - 再发一次
/** 再发一次 */
- (void)againPushlishOrder {
//    __weak typeof(self) weakSelf = self;
}

#pragma mark - 重新发货
/** 重新发货 */
- (void)renewDeliverOrder {
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [NSDictionary dictionary];
    [[NetworkManager sharedManager] postJSON:[NSString stringWithFormat:@"%@/%@",URL_AgainOrder,self.model.ID] parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status == Request_Success) {
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
        }
    }];
}

#pragma mark - 取消发货
/** 取消发货 */
- (void)cancleDeliverOrder {
//    __weak typeof(self) weakSelf = self;
//    NSDictionary *dic = [NSDictionary dictionary];
//    [[NetworkManager sharedManager] postJSON:[NSString stringWithFormat:@"%@/%@",URL_CancelOrderDetail,self.model.ID] parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
//        if (status == Request_Success) {
//            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
//        }
//    }];
}


#pragma mark - 评价
/** 评价 */
- (void)commentOrder {
//    __weak typeof(self) weakSelf = self;
//    NSDictionary *dic = [NSDictionary dictionary];
//    [[NetworkManager sharedManager] postJSON:[NSString stringWithFormat:@"%@/%@",URL_CancelOrderDetail,self.model.ID] parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
//        if (status == Request_Success) {
//            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
//        }
//    }];
}

#pragma mark - 确认收货
/** 确认收货 */
- (void)confirmGoodsOrder {
    __weak typeof(self) weakSelf = self;
//    NSDictionary *dic = [NSDictionary dictionary];
//    [[NetworkManager sharedManager] postJSON:[NSString stringWithFormat:@"%@/%@",URL_CancelOrderDetail,self.model.ID] parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
//        if (status == Request_Success) {
//            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
//        }
//    }];
}

#pragma mark - 立即支付
/** 立即支付 */
- (void)payOrder {
   
}
#pragma mark - 查看路线
/** 查看路线 */
- (void)showRoutOrder {
    JSOrderDetailMapVC *vc = [Utils getViewController:@"Mine" WithVCName:@"JSOrderDetailMapVC"];
    [self.navigationController pushViewController:vc animated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
