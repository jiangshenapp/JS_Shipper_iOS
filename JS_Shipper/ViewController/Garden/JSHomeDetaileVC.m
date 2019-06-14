//
//  JSHomeDetaileVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/6/14.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "JSHomeDetaileVC.h"

@interface JSHomeDetaileVC ()

@end

@implementation JSHomeDetaileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBottomView];
}

- (void)createBottomView {
    CGFloat viewH = 50;
    CGFloat bottomY = HEIGHT-viewH-kTabBarSafeH;
    CGFloat firstViewW = (WIDTH/2.0-30)/2.0;
    self.callBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, bottomY, firstViewW, viewH)];
    [self.callBtn setImage:[UIImage imageNamed:@"home_list_btn_phone"] forState:UIControlStateNormal];
    self.callBtn.backgroundColor = [UIColor whiteColor];
    [self.callBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.callBtn];
    
    self.chatBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.callBtn.right, bottomY, firstViewW, viewH)];
    self.chatBtn.backgroundColor = [UIColor whiteColor];
    [self.chatBtn setImage:[UIImage imageNamed:@"home_list_btn_chat"] forState:UIControlStateNormal];
    [self.chatBtn addTarget:self action:@selector(chatAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chatBtn];
    
    self.cretaeOrderBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.chatBtn.right, bottomY, WIDTH-self.chatBtn.right, viewH)];
    self.cretaeOrderBtn.backgroundColor = AppThemeColor;
    [self.cretaeOrderBtn addTarget:self action:@selector(createOrderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cretaeOrderBtn setTitle:@"立即下单" forState:UIControlStateNormal];
    [self.view addSubview:self.cretaeOrderBtn];
}

- (void)callAction {
    
}

- (void)chatAction {
    
}


- (void)createOrderAction {
    
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
