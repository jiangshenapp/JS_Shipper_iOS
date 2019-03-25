//
//  JSGardenVC.m
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "JSGardenVC.h"

@interface JSGardenVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JSGardenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleView.top = 7+kStatusBarH;
    _titleView.centerX = WIDTH/2.0;
    [self.navBar addSubview:_titleView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSGardenTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JSGardenTabCell"];
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

- (IBAction)titleBtnAction:(UIButton*)sender {
    
    for (NSInteger tag = 100; tag<103; tag++) {
        UIButton *btn = [self.view viewWithTag:tag];
        if ([btn isEqual:sender]) {
            btn.backgroundColor = AppThemeColor;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else {
            btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}
@end
@implementation JSGardenTabCell

@end
