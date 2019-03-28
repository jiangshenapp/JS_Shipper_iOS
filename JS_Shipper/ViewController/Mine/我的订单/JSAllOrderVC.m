//
//  JSAllOrderVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/3/28.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "JSAllOrderVC.h"

@interface JSAllOrderVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JSAllOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderTabCell"];
    return cell;
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
}
@end

@implementation MyOrderTabCell

@end
