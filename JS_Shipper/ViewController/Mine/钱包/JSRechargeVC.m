//
//  JSRechargeVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/3/27.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "JSRechargeVC.h"

@interface JSRechargeVC ()

@end

@implementation JSRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    [self getData];
    // Do any additional setup after loading the view.
}

-(void)getData {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"business"];
    [dic setObject:@"1" forKey:@"merchantId"];
    [[NetworkManager sharedManager] postJSON:URL_GetPayRoute parameters:dic imageDataArr:nil imageName:nil completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            
        }
    }];
//    [[NetworkManager sharedManager] postJSON:URL_GetPayRoute parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
//
//    }];
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
