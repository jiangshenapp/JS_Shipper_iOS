//
//  JSCityDeliveryDetaileVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/6/14.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "JSCityDeliveryDetaileVC.h"

@interface JSCityDeliveryDetaileVC ()

@end

@implementation JSCityDeliveryDetaileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"城市配送详情";
    
    [self refreshUI];
    [self getData];
}

#pragma mark - 获取数据
- (void)getData {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *url = [NSString stringWithFormat:@"%@?id=%@",URL_GetParkDetail,self.carSourceID];
    [[NetworkManager sharedManager] postJSON:url parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status == Request_Success) {
            weakSelf.dataModel = [RecordsModel mj_objectWithKeyValues:responseData];
            [weakSelf refreshUI];
        }
    }];
}

- (void)refreshUI {
    
    if ([self.dataModel.isCollect isEqualToString:@"1"]) {
        self.collectBtn.selected = YES;
    } else {
        self.collectBtn.selected = NO;
    }
    self.parkImgH.constant = 0; //园区地址二期
    self.dotNameLab.text = self.dataModel.companyName;
//    self.dotAddressLab.text = [NSString stringWithFormat:@"距离您xxkm"];
    self.nameLab.text = self.dataModel.contactName;
    self.addressLab.text = self.dataModel.contactAddress;
    self.contentTV.text = self.dataModel.remark;
}

#pragma mark - methods

/** 收藏 */
- (void)collectAction {
    
    if (self.collectBtn.isSelected) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self.carSourceID forKey:@"parkId"];
        [[NetworkManager sharedManager] postJSON:URL_ParkRemove parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
            if (status == Request_Success) {
                [Utils showToast:@"取消收藏成功"];
                self.collectBtn.selected = !self.collectBtn.isSelected;
            }
        }];
    } else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self.carSourceID forKey:@"parkId"];
        [[NetworkManager sharedManager] postJSON:URL_ParkAdd parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
            if (status == Request_Success) {
                [Utils showToast:@"收藏成功"];
                self.collectBtn.selected = !self.collectBtn.isSelected;
            }
        }];
    }
}

/** 打电话 */
- (void)callAction {
    if (![Utils isBlankString:self.dataModel.contractPhone]) {
        [Utils call:self.dataModel.contractPhone];
    } else {
        [Utils showToast:@"手机号码为空"];
    }
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
