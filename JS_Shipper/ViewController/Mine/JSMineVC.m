//
//  JSMineVC.m
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "JSMineVC.h"

@interface JSMineVC ()

@end

@implementation JSMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.hidden = YES;
    
    [self getData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfo) name:kLoginSuccNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfo) name:kUserInfoChangeNotification object:nil];
}

#pragma mark - get data

- (void)getData {
    
    if ([Utils isLoginWithJump:YES]) {
        [self getUserInfo]; //获取用户信息
    }
}

/* 获取用户信息 */
- (void)getUserInfo {
    NSDictionary *dic = [NSDictionary dictionary];
    [[NetworkManager sharedManager] getJSON:URL_Profile parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status == Request_Success) {
            //缓存用户信息
            NSDictionary *userDic = responseData;
            [[UserInfo share] setUserInfo:[userDic mutableCopy]];
            
            //将用户信息解析成model
            UserInfo *userInfo = [UserInfo mj_objectWithKeyValues:(NSDictionary *)responseData];
            
            self.phoneLab.text = userInfo.mobile;
            self.nameLab.text = userInfo.nickName;
            
            if ([userInfo.personConsignorVerified integerValue] == 0
                && [userInfo.companyConsignorVerified integerValue] == 0) {
                self.stateLab.text = @" 申请认证 ";
            }
            
            if ([userInfo.personConsignorVerified integerValue] == 1
                || [userInfo.companyConsignorVerified integerValue] == 1) {
                self.stateLab.text = @" 审核中 ";
            }
           
            NSLog(@"用户手机号：%@，用户昵称：%@", userInfo.mobile, userInfo.nickName);
        }
    }];
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
