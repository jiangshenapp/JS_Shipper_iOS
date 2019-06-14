//
//  JSCarSourceDetailVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/8.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "JSCarSourceDetailVC.h"
#import "JSDeliverConfirmVC.h"

@interface JSCarSourceDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *carImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carImgH;
@property (weak, nonatomic) IBOutlet UILabel *startAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *endAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *carNumLab;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *carLengthLab;
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;
@end

@implementation JSCarSourceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车源详情";
    [self refreshUI];
    [self getData];
}

#pragma mark - 获取数据
- (void)getData {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *url = [NSString stringWithFormat:@"%@/%@",URL_GetLineDetail,self.carSourceID];
    [[NetworkManager sharedManager] postJSON:url parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status == Request_Success) {
            weakSelf.dataModel = [RecordsModel mj_objectWithKeyValues:responseData];
            [weakSelf refreshUI];
        }
    }];
}

- (void)refreshUI {
    _startAddressLab.text = self.dataModel.startAddressCodeName;
    _endAddressLab.text = self.dataModel.receiveAddressCodeName;
    _nameLab.text = self.dataModel.driverName;
    _carNumLab.text = self.dataModel.cphm;
    _carTypeLab.text = self.dataModel.carModelName;
    _carLengthLab.text = self.dataModel.carLengthName;
    _remarkTV.text = self.dataModel.remark;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)createOrderAction{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.dataModel.carModel forKey:@"carModel"];
    [dic setObject:self.dataModel.carLength forKey:@"carLength"];
//        [dic setObject:_info1.address forKey:@"sendAddress"];
        [dic setObject:self.dataModel.startAddressCode forKey:@"sendAddressCode"];
//        NSDictionary *locDic = @{@"latitude":@(_info1.pt.latitude),@"longitude":@(_info1.pt.longitude)};
//        [dic setObject:[locDic jsonStringEncoded] forKey:@"sendPosition"];
        [dic setObject:self.dataModel.arriveAddressCode forKey:@"receiveAddressCode"];
            [dic setObject:self.dataModel.driverPhone forKey:@"receiveMobile"];
            [dic setObject:self.dataModel.driverName forKey:@"receiveName"];
    
//        NSDictionary *locDic = @{@"latitude":@(_info2.pt.latitude),@"longitude":@(_info2.pt.longitude)};
//        [dic setObject:[locDic jsonStringEncoded] forKey:@"receivePosition"];
    [[NetworkManager sharedManager] postJSON:URL_AddStepOne parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            JSDeliverConfirmVC *vc = (JSDeliverConfirmVC *)[Utils getViewController:@"DeliverGoods" WithVCName:@"JSDeliverConfirmVC"];
            vc.orderID = [NSString stringWithFormat:@"%@",responseData];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
    
}
@end
