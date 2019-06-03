//
//  JSAllOrderVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/3/28.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "JSAllOrderVC.h"
#import "JSBaseOrderDetailsVC.h"
#import "JSReleaseOrderVC.h"
#import "ListOrderModel.h"

@interface JSAllOrderVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *classNameArr;
  __block  NSInteger _page;
}
/** 列表的数据源 */
@property (nonatomic,retain) NSMutableArray *listData;;
/** 分页 从1开始 */
@property (nonatomic,assign) NSInteger page;
@end

@implementation JSAllOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    classNameArr = @[@"JSReleaseOrderVC",@"JSConfirmOrderVC",@"JSDeliveryOrderVC",@"JSCommentOrderVC",@"JSTransportOrderVC",@"JSFinishOrderVC",@"JSCancleOrderVC"];
    if (_typeFlage>0) {
        UIButton *sender = [self.view viewWithTag:100+_typeFlage];
        [self titleBtnAction:sender];
    }
    _listData = [NSMutableArray array];
    _page = 0;
    [self getData];
    __weak typeof(self) weakSelf = self;
    self.baseTabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf getData];
    }];
    self.baseTabView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
         [weakSelf getData];
    }];
    // Do any additional setup after loading the view.
}

- (void)getData {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:@(_typeFlage) forKey:@"state"];
    NSString *urlStr = [NSString stringWithFormat:@"%@?current=%ld&size=%@",URL_OrdeList,_page,PageSize];
    [[NetworkManager sharedManager] postJSON:urlStr parameters:para completion:^(id responseData, RequestState status, NSError *error) {
        if (status==Request_Success) {
            NSInteger count = [responseData[@"total"] integerValue];
            if (weakSelf.page==1) {
                [weakSelf.listData removeAllObjects];
            }
            NSArray *arr = [ListOrderModel mj_objectArrayWithKeyValuesArray:responseData[@"records"]];
            if (weakSelf.listData.count<count) {
                [weakSelf.listData addObjectsFromArray:arr];
                weakSelf.page++;
            }
        }
        [weakSelf.baseTabView reloadData];
        if ([weakSelf.baseTabView.mj_header isRefreshing]) {
            [weakSelf.baseTabView.mj_header endRefreshing];
        }
        if ([weakSelf.baseTabView.mj_footer isRefreshing]) {
            [weakSelf.baseTabView.mj_footer endRefreshing];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderTabCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JSBaseOrderDetailsVC *vc = (JSBaseOrderDetailsVC *)[Utils getViewController:@"Mine" WithVCName:@"JSBaseOrderDetailsVC"];;
//    JSReleaseOrderVC *vc = [UIViewController alloc]initw;
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

- (IBAction)titleBtnAction:(UIButton *)sender {
    for (NSInteger tag = 100; tag<105; tag++) {
        UIButton *btn = [self.view viewWithTag:tag];
        btn.selected = [btn isEqual:sender]?YES:NO;;
    }
    [self.baseTabView reloadData];
}
@end

@implementation MyOrderTabCell

@end
