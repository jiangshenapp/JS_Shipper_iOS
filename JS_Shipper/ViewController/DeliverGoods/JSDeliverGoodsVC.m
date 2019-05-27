//
//  JSDeliverGoodsVC.m
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "JSDeliverGoodsVC.h"
#import <BaiduMapAPI_Utils/BMKGeometry.h>

@interface JSDeliverGoodsVC ()
/** 起止点 */
@property (nonatomic,retain) BMKReverseGeoCodeSearchResult *info1;
/** 终止点 */
@property (nonatomic,retain) BMKReverseGeoCodeSearchResult *info2;
@end

@implementation JSDeliverGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发货";
    _bannerView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554786828281&di=adb087e354b74cf42fffb75077e2c757&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F14%2F37%2F09%2F97a58PICQ6H_1024.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554786828281&di=adb087e354b74cf42fffb75077e2c757&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F14%2F37%2F09%2F97a58PICQ6H_1024.jpg"];
    _bannerView.currentPageDotColor = AppThemeColor;
    _bannerView.pageDotColor = kWhiteColor;
    
    UIButton *sender = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    [sender setTitle:@"我的运单" forState:UIControlStateNormal];
    sender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [sender setTitleColor:kBlackColor forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:12];
    self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:sender];;
    
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    __weak typeof(self) weakSelf = self;
    JSConfirmAddressMapVC *vc = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"start"]) {
        vc.sourceType = 0;
        vc.getAddressinfo = ^(BMKReverseGeoCodeSearchResult * _Nonnull info) {
            NSString *infoStr  =[NSString stringWithFormat:@"%@",info.address];
            [weakSelf.startAddressBtn setTitle:infoStr forState:UIControlStateNormal];
            weakSelf.info1 = info;
            [weakSelf getDistance];
        };
    }
    else if ([segue.identifier isEqualToString:@"end"]) {
        vc.sourceType = 1;
        vc.getAddressinfo = ^(BMKReverseGeoCodeSearchResult * _Nonnull info) {
            NSString *infoStr  =[NSString stringWithFormat:@"%@",info.address];
            [weakSelf.endAddressBtn setTitle:infoStr forState:UIControlStateNormal];
            weakSelf.info2 = info;
            [weakSelf getDistance];
        };
    }
}

- (void)getDistance {
    if (!_info1||!_info2) {
        return;
    }
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(_info1.location.latitude,_info1.location.longitude));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(_info2.location.latitude,_info2.location.longitude));
  float  dist = BMKMetersBetweenMapPoints(point1,point2);
    if (dist<1000) {
        _distanceLab.text = [NSString stringWithFormat:@"总里程：%.2f米",dist];
    }
    else {
        dist = dist/1000;
        _distanceLab.text = [NSString stringWithFormat:@"总里程：%.2f公里",dist];

    }
}


- (IBAction)startAddressAction:(UIButton *)sender {
}

- (IBAction)endAddressAction:(id)sender {
}
- (IBAction)sendGoodsAction:(UIButton *)sender {
}

- (IBAction)carLongAction:(UIButton *)sender {
}

- (IBAction)carTypeAction:(id)sender {
}
@end
