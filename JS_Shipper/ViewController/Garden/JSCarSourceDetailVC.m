//
//  JSCarSourceDetailVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/8.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "JSCarSourceDetailVC.h"

@interface JSCarSourceDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *carImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carAspect;
@property (weak, nonatomic) IBOutlet UILabel *startAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *endAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *carNumLab;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *carLengthLab;
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;
- (IBAction)callAction:(UIButton *)sender;
- (IBAction)chatAction:(UIButton *)sender;
- (IBAction)createOrderAction:(UIButton *)sender;

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
    NSString *url = [NSString stringWithFormat:@"%@?id=%@",URL_GetGradeDetail,_carSourceID];
    [[NetworkManager sharedManager] postJSON:url parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status == Request_Success) {
            weakSelf.dataModel = [RecordsModel mj_objectWithKeyValues:responseData];
        }
//        [weakSelf refreshUI];
    }];
}

- (void)refreshUI {
    _startAddressLab.text = _dataModel.startAddressCodeName;
    _endAddressLab.text = _dataModel.arriveAddressCodeName;
    _nameLab.text = _dataModel.driverName;
    _carNumLab.text = _dataModel.cphm;
    _carTypeLab.text = _dataModel.carModelName;
    _carLengthLab.text = _dataModel.carLengthName;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)callAction:(UIButton *)sender {
}

- (IBAction)chatAction:(UIButton *)sender {
}

- (IBAction)createOrderAction:(UIButton *)sender {
}
@end
