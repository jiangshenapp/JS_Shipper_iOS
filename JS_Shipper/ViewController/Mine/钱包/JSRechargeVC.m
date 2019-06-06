//
//  JSRechargeVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/3/27.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "JSRechargeVC.h"
#import "PayRouteModel.h"
#import <AlipaySDK/AlipaySDK.h>

@interface JSRechargeVC ()

/** 支付路由数组 */
@property (nonatomic,retain) NSMutableArray *listData;
/** 支付宝支付路由 */
@property (nonatomic,retain) PayRouteModel *alipayRoute;
/** 微信支付路由 */
@property (nonatomic,retain) PayRouteModel *wechatRoute;

@end

@implementation JSRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    
    [self getData];
}

#pragma mark - get data

- (void)getData {
    // business_id 1、运力端充值 2、货主端充值 3、货主端支付运费
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr = [NSString stringWithFormat:@"%@?business=%d&merchantId=%d",URL_GetPayRoute,2,1];
    [[NetworkManager sharedManager] postJSON:urlStr parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            self.listData = [PayRouteModel mj_objectArrayWithKeyValuesArray:responseData];
            for (PayRouteModel *payRouteModel in self.listData) {
                if ([payRouteModel.channelType isEqualToString:@"1"]) {
                    self.alipayRoute = payRouteModel;
                }
                if ([payRouteModel.channelType isEqualToString:@"2"]) {
                    self.wechatRoute = payRouteModel;
                }
            }
        }
    }];
}

#pragma mark - methods

//支付宝选中
- (IBAction)alipaySelectAction:(id)sender {
    self.alipayBtn.selected = YES;
    self.wechatBtn.selected = NO;
}

//微信选中
- (IBAction)wechetSelectAction:(id)sender {
    self.alipayBtn.selected = NO;
    self.wechatBtn.selected = YES;
}

//充值
- (IBAction)payAction:(id)sender {
    if ([Utils isBlankString:self.priceTF.text]) {
        [Utils showToast:@"请输入充值金额"];
        return;
    }
    if (self.alipayBtn.isSelected == YES) {
        [self alipay];
    }
    if (self.wechatBtn.isSelected == YES) {
        [self wechatPay];
    }
}

#pragma mark - 支付宝支付
- (void)alipay {
    [Utils showToast:@"支付宝支付"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr = [NSString stringWithFormat:@"%@?channelType=%@&money=%@&routeId=%@",URL_Recharge,_alipayRoute.channelType,self.priceTF.text,_alipayRoute.routeId];
    [[NetworkManager sharedManager] postJSON:urlStr parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            
        }
    }];
}

#pragma mark - 微信支付
- (void)wechatPay {
    [Utils showToast:@"微信支付"];
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
