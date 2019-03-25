//
//  BaseTabBarVC.m
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "BaseNC.h"

@interface BaseTabBarVC ()

@end

@implementation BaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabBar];
}

- (void)createTabBar {
    //视图数组
    NSArray *controllerArr = @[@"JSGardenVC",@"JSDeliverGoodsVC",@"JSMessageVC",@"JSCommunityVC",@"JSMineVC"];
    //标题数组
    NSArray *titleArr = @[@"园区",@"发货",@"消息",@"社区",@"我的"];
    //图片数组
    NSArray *picArr = @[@"app_menubar_icon_searchcar_black",@"app_menubar_icon_goods_black",@"app_menubar_icon_news_black",@"app_menubar_icon_community_black",@"app_menubar_icon_my_black"];
    
    //storyboard name 数组
    NSArray *storyArr = @[@"Garden",@"DeliverGoods",@"Message",@"Community",@"Mine"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(int i=0; i<picArr.count; i++) {
        UIViewController *controller = [[UIStoryboard storyboardWithName:storyArr[i] bundle:nil] instantiateViewControllerWithIdentifier:controllerArr[i]];
        controller.title = titleArr[i];
        
        BaseNC *nv = [[BaseNC alloc] initWithRootViewController:controller];
        nv.tabBarItem.title = titleArr[i];
        NSString *norName = picArr[i];
        nv.tabBarItem.image = [[UIImage imageNamed:norName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nv.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",[norName stringByReplacingOccurrencesOfString:@"black" withString:@"yellow"]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [array addObject:nv];
    }
    
    //设置字体的颜色和大小
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:AppThemeColor,NSFontAttributeName:[UIFont systemFontOfSize:10.5]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kBlackColor,NSFontAttributeName:[UIFont systemFontOfSize:10.5]} forState:UIControlStateNormal];
    
    //改变tabBar的背景颜色
    UIView *barBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, kTabBarH)];
    barBgView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:barBgView atIndex:0];
    self.tabBar.opaque = YES;
    
    self.viewControllers = array;
}

@end
