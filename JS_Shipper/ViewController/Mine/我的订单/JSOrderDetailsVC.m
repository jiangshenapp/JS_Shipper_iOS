//
//  JSOrderDetailsVC.m
//  JS_Shipper
//
//  Created by Jason_zyl on 2019/6/4.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "JSOrderDetailsVC.h"

@interface JSOrderDetailsVC ()

@end

@implementation JSOrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgScroView.contentSize = CGSizeMake(0, _receiptView.bottom+50);
    self.title = @"我的订单";
    self.tileView1.hidden = YES;
    self.titleView2.hidden = NO;
    
    [self initData];
}

#pragma mark - init data
- (void)initData {
    
}

- (IBAction)bottomLeftBtnAction:(UIButton *)sender {
    
}

- (IBAction)bottomRightBtnAction:(UIButton *)sender {
    
}

- (IBAction)bottomBtnAction:(UIButton *)sender {
    
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
