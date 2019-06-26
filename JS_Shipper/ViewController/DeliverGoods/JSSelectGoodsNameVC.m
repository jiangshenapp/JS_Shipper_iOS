//
//  JSSelectGoodsNameVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/6/24.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "JSSelectGoodsNameVC.h"

@interface JSSelectGoodsNameVC ()

@end

@implementation JSSelectGoodsNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_sourceType==0) {
        self.title = @"货物名称";
    }
    else if (_sourceType==1) {
        self.title = @"包装类型";
    }
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

@end
