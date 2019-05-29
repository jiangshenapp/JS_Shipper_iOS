//
//  JSDeliverGoodsVC.m
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "JSDeliverGoodsVC.h"
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import "FilterCustomView.h"
#import "JSDeliverConfirmVC.h"

@interface JSDeliverGoodsVC ()
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
@property (nonatomic,copy) NSString *carLengthStr;
/** 车型 */
@property (nonatomic,copy) NSString *carModelStr;
/** 点击类型  1车长 2车型 */
@property (nonatomic,assign) NSInteger touchType;

@end

@implementation JSDeliverGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发货";
    [self getCarLengthInfo];
    [self getCarModelInfo];
}

- (void)setupView {
    _carLengthStr = @"2";
    _carModelStr = @"2";
    _touchType = 0;
    _bannerView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554786828281&di=adb087e354b74cf42fffb75077e2c757&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F14%2F37%2F09%2F97a58PICQ6H_1024.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554786828281&di=adb087e354b74cf42fffb75077e2c757&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F14%2F37%2F09%2F97a58PICQ6H_1024.jpg"];
    _bannerView.currentPageDotColor = AppThemeColor;
    _bannerView.pageDotColor = kWhiteColor;
    
    UIButton *sender = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    [sender setTitle:@"我的运单" forState:UIControlStateNormal];
    sender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [sender setTitleColor:kBlackColor forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(showMyOrderAction) forControlEvents:UIControlEventTouchUpInside];
    sender.titleLabel.font = [UIFont systemFontOfSize:12];
    self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:sender];;
    _carLengthView =  [[FilterCustomView alloc]init];
    _carLengthView.viewHeight = HEIGHT-kNavBarH-kTabBarSafeH;;
    _carLengthView.top = kNavBarH;
    __weak typeof(self) weakSelf = self;
    _carLengthView.getSelectResultArr = ^(NSMutableArray * _Nonnull resultArr) {
        NSString *allValueStr = @"";
        NSString *allLabelStr = @"";
        if (resultArr.count>0) {
            NSArray *arr = [resultArr firstObject];
            for (NSDictionary *dataDic in arr) {
                allValueStr = [allValueStr stringByAppendingString:[NSString stringWithFormat:@"%@,",dataDic[@"value"]]];
                allLabelStr = [allLabelStr stringByAppendingString:[NSString stringWithFormat:@"%@,",dataDic[@"label"]]];
            }
        }
        if (allValueStr.length>0) {
            allValueStr = [allLabelStr substringToIndex:allValueStr.length-1];
        }
        if (allLabelStr.length>0) {
            allLabelStr = [allLabelStr substringToIndex:allLabelStr.length-1];
        }

        if (weakSelf.touchType==1) {
            weakSelf.carLengthStr = allValueStr;
            [weakSelf.carLenthBtn setTitle:allLabelStr forState:UIControlStateNormal];
        }
        else if (weakSelf.touchType==2) {
            weakSelf.carModelStr = allValueStr;;
            [weakSelf.carModelBtn setTitle:allLabelStr forState:UIControlStateNormal];
        }
        NSLog(@"label:%@  value:%@  ",allLabelStr,allValueStr);
    };
    
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


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    __weak typeof(self) weakSelf = self;
    JSConfirmAddressMapVC *vc = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"start"]) {
        vc.sourceType = 0;
        vc.getAddressinfo = ^(AddressInfoModel * _Nonnull info) {
            [weakSelf.startAddressBtn setTitle:info.address forState:UIControlStateNormal];
            weakSelf.info1 = info;
            [weakSelf getDistance];
        };
    }
    else if ([segue.identifier isEqualToString:@"end"]) {
        vc.sourceType = 1;
        vc.getAddressinfo = ^(AddressInfoModel * _Nonnull info) {
            [weakSelf.endAddressBtn setTitle:info.address forState:UIControlStateNormal];
            weakSelf.info2 = info;
            [weakSelf getDistance];
        };
    }
}

- (void)getDistance {
    if (!_info1||!_info2) {
        return;
    }
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(_info1.pt.latitude,_info1.pt.longitude));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(_info2.pt.latitude,_info2.pt.longitude));
  float  dist = BMKMetersBetweenMapPoints(point1,point2);
    if (dist<1000) {
        _distanceLab.text = [NSString stringWithFormat:@"总里程：%.2f米",dist];
    }
    else {
        dist = dist/1000;
        _distanceLab.text = [NSString stringWithFormat:@"总里程：%.2f公里",dist];

    }
}

- (void)showMyOrderAction {
    UIViewController *vc = [Utils getViewController:@"Mine" WithVCName:@"JSAllOrderVC"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)sendGoodsAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_carLengthStr forKey:@"carLength"];
    [dic setObject:_carModelStr forKey:@"carModel"];
    if (_info2.address.length==0||_info1.address.length==0) {
        [Utils showToast:@"请选择地址"];
        return;
    }
    if (_info1.address.length>0) {
        [dic setObject:_info1.address forKey:@"sendAddress"];
        [dic setObject:_info1.areaCode forKey:@"sendAddressCode"];
        if (_info1.mobile) {
            [dic setObject:_info1.mobile forKey:@"sendMobile"];
            [dic setObject:_info1.userName forKey:@"sendName"];
            [dic setObject:_info1.detailAddress forKey:@"sendPosition"];
        }
    }
    if (_info2.address.length>0) {
        [dic setObject:_info2.address forKey:@"receiveAddress"];
        [dic setObject:_info2.areaCode forKey:@"receiveAddressCode"];
        if (_info2.mobile.length>0) {
            [dic setObject:_info2.mobile forKey:@"receiveMobile"];
            [dic setObject:_info2.detailAddress forKey:@"receivePosition"];
        }
    }
    [[NetworkManager sharedManager] postJSON:URL_AddStepOne parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            JSDeliverConfirmVC *vc = (JSDeliverConfirmVC *)[Utils getViewController:@"DeliverGoods" WithVCName:@"JSDeliverConfirmVC"];
            vc.orderID = [NSString stringWithFormat:@"%@",responseData];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
    
}

- (IBAction)carLongAction:(UIButton *)sender {
    _touchType = 1;
    self.carLengthView.singleArr = @[@"0"];
    self.carLengthView.titleArr = @[@"车长"];
    self.carLengthView.dataArr = @[_carLengthArr];
    [_carLengthView showView];
}

- (IBAction)carTypeAction:(id)sender {
    _touchType = 2;
    self.carLengthView.singleArr = @[@"1"];
    self.carLengthView.titleArr = @[@"车型"];
    self.carLengthView.dataArr = @[self.carModelArr];
    [_carLengthView showView];
}
@end

