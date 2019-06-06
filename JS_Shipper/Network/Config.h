//
//  Config.h
//  Chaozhi
//  Notes：接口地址【文档：http://47.96.122.74:9999/swagger-ui.html】
//
//  Created by Jason_hzb on 2018/5/29.
//  Copyright © 2018年 小灵狗出行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

#pragma mark - ---------------接口地址---------------

// 接口地址
NSString *ROOT_URL(void);
// 图片地址
NSString *PIC_URL(void);

#pragma mark - ---------------接口名称---------------

#pragma mark - 上传文件

#define URL_FileUpload @"http://47.96.122.74:9999/admin/file/upload" //上传文件

#define URL_GetDictByType @"/app/dict/getDictByType"//根据类型获取字典

#pragma mark - APP会员注册登录接口

#define URL_Login @"/app/subscriber/login" //密码登录
#define URL_SmsLogin @"/app/subscriber/smsLogin" //短信验证码登录
#define URL_Logout @"/app/subscriber/logout" //退出登录
#define URL_Profile @"/app/subscriber/profile" //获取当前登录人信息
#define URL_Registry @"/app/subscriber/registry" //会员注册
#define URL_ResetPwdStep1 @"/app/subscriber/resetPwdStep1" //重置密码步骤1
#define URL_ResetPwdStep2 @"/app/subscriber/resetPwdStep2" //重置密码步骤2
#define URL_SendSmsCode @"/app/subscriber/sendSmsCode" //发送短信验证码
#define URL_SetPwd @"/app/subscriber/setPwd" //设置密码
#define URL_BindMobile @"/app/subscriber/bindMobile" //绑定手机号
#define URL_ChangeAvatar @"/app/subscriber/changeAvatar" //修改头像
#define URL_ChangeNickname @"/app/subscriber/changeNickname" //修改昵称

#pragma mark - APP会员认证接口

#define URL_CompanyConsignorVerified @"/app/subscriber/verify/companyConsignorVerified" //企业货主认证
#define URL_DriverVerified @"/app/subscriber/verify/driverVerified" //个人司机认证
#define URL_GetCompanyConsignorVerifiedInfo @"/app/subscriber/verify/getCompanyConsignorVerifiedInfo" //获取企业货主认证信息
#define URL_GetDriverVerifiedInfo @"/app/subscriber/verify/getDriverVerifiedInfo" //获取司机认证信息
#define URL_GetParkVerifiedInfo @"/app/subscriber/verify/getParkVerifiedInfo" //获取园区认证信息
#define URL_GetPersonConsignorVerifiedInfo @"/app/subscriber/verify/getPersonConsignorVerifiedInfo" //获取个人货主认证信息
#define URL_ParkVerified @"/app/subscriber/verify/parkVerified" //园区认证
#define URL_PersonConsignorVerified @"/app/subscriber/verify/personConsignorVerified" //个人货主认证


#pragma mark - APP线路相关接口

#define URL_Classic @"/app/line/classic" //精品线路
#define URL_Find @"/app/line/find" //车源

#pragma mark - APP订单相关接口

#define URL_AddStepOne @"/app/order/addStepOne"//发货 --创建订单
#define URL_AddStepTwo @"/app/order/addStepTwo"//发货 --确认订单
#define URL_AgainOrder @"/app/order/again"//重新发货
#define URL_CancelOrderDetail @"/app/order/cancel"//取消订单
#define URL_GetOrderDetail @"/app/order/get"//订单详情
#define URL_OrdeList @"/app/order/list"//我的运单

#pragma mark - APP账户接口
#define URL_Recharge @"/app/account/recharge"//账户充值
#define URL_GetPayRoute @"/pigx-pay-biz/pay/getRoute"//获取支付方式

#pragma mark - ---------------H5地址---------------

NSString *h5Url(void);

#pragma mark - ---------------H5名称---------------

#define H5_Privacy @"#/hybrid/chaozhi/privacy" //隐私协议

@end
