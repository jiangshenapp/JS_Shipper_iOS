//
//  JSConfirmAddressMapVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/25.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "JSConfirmAddressMapVC.h"
#import "MKMapView+ZoomLevel.h"

@interface JSConfirmAddressMapVC ()<MKMapViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
  __block  NSDictionary *addreeDic;
  __block  NSArray *searchAddressArr;
}
/** 定位管理 */
@property (nonatomic,retain) CLLocationManager *locationManager;
/** 用户当前位置 */
@property (nonatomic,retain) MKUserLocation *myUserLoc;
@end

@implementation JSConfirmAddressMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView {
    self.locationManager=[[CLLocationManager alloc]init];;
    //判断当前设备定位服务是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"设备尚未打开定位服务");
    }
    //判断当前设备版本大于iOS8以后的话执行里面的方法
    if ([UIDevice currentDevice].systemVersion.floatValue >=8.0) {
        //当用户使用的时候授权
        [self.locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        NSString *message = @"您的手机目前未开启定位服务，如欲开启定位服务，请至设定开启定位服务功能";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }
    _gdMapView.showsUserLocation = YES;
    _gdMapView.delegate = self;
    [_gdMapView setZoomLevel:13 animated:YES];
    
    [self.navBar addSubview:_titleView];
    _titleView.top = kStatusBarH;
    _titleView.centerX = self.navBar.width/2.0;
    _titleView.cornerRadius = 2;
    _titleView.borderColor = PageColor;
    _titleView.borderWidth = 1;
    
    UIImage *image = [UIImage imageNamed:@"delivergoods_map_bg_location"];
    _centerView.layer.contents = (__bridge id)image.CGImage;
    self.baseTabView.hidden = YES;
}
/**
 *  跟踪到用户位置时会调用该方法
 *  @param mapView   地图
 *  @param userLocation 大头针模型
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [self.locationManager stopUpdatingLocation];
    _myUserLoc = userLocation;
    [self.gdMapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

- (void)fetchNearbyInfo:(CLLocationDegrees )latitude andT:(CLLocationDegrees )longitude {
    __weak typeof(self) weakSelf = self;
    //根据经纬度获取省份城市
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];;
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler: ^(NSArray *placemarks,NSError *error) {
        if (placemarks.count>0) {
                CLPlacemark *placemark = [placemarks firstObject];
                self->addreeDic = placemark.addressDictionary;
                [weakSelf refreshUI];
        }
        
    }];
}


- (void)refreshUI {
    NSLog(@"%@",addreeDic);
   _ceterAddressLab.text =[NSString stringWithFormat:@"%@",addreeDic[@"Name"]];
    _addressNameLab.text =[NSString stringWithFormat:@"%@",addreeDic[@"Name"]];
    NSString *street = addreeDic[@"Street"];
    if ([NSString isEmpty:street]) {
        street = @"";
    }
    _addressInfoLab.text =[NSString stringWithFormat:@"%@%@",addreeDic[@"SubLocality"],street];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.center= centerCoordinate;
    [self fetchNearbyInfo:centerCoordinate.latitude andT:centerCoordinate.longitude];
}

#pragma mark - UITextField代理
/** UITextField代理 */
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.baseTabView.hidden = NO;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    NSString *textStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textStr.length==0) {
        searchAddressArr = nil;
        self.baseTabView.hidden = YES;
        return YES;
    }
     self.baseTabView.hidden = NO;
//    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
//    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location, 1 ,1 );
    MKLocalSearchRequest *requst = [[MKLocalSearchRequest alloc] init];
//    requst.region = region;
    __weak typeof(self) weakSelf = self;
    requst.naturalLanguageQuery = textStr; //想要的信息
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:requst];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        if (!error){
            self->searchAddressArr = response.mapItems;
            [weakSelf.baseTabView reloadData];
        }
    }];
    return YES;
}


#pragma mark - tablewView代理
/**  */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return searchAddressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTabcell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTabcell"];
     MKMapItem *mapIm = searchAddressArr[indexPath.row];
    cell.nameLab.text = mapIm.name;
    NSString *street = mapIm.placemark.addressDictionary[@"Street"];
    if ([NSString isEmpty:street]) {
        street = @"";
    }
    cell.addressLab.text = [NSString stringWithFormat:@"%@%@",mapIm.placemark.addressDictionary[@"SubLocality"],street];;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [Utils getViewController:@"DeliverGoods" WithVCName:@"JSEditAddressVC"];
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


@implementation SearchTabcell

@end
