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
    [self initView];
}

-(void)initView {
    _titleView.top = 7+kStatusBarH;
    _titleView.centerX = WIDTH/2.0;
    [self.navBar addSubview:_titleView];
    CGFloat btW = WIDTH/4.0;
    for (NSInteger index = 0; index<4; index++) {
        FilterButton *sender = [[FilterButton alloc]initWithFrame:CGRectMake(index*btW, 0, btW, self.filterView.height)];
//        [sender setImage:[UIImage imageNamed:@"app_tab_arrow_down"] forState:UIControlStateNormal];
        [sender setTitle:@"起嘎嘎嘎g哈哈" forState:UIControlStateNormal];
        [self.filterView addSubview:sender];
    }
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

@implementation FilterButton
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width-20, self.height)];
    _titleLab.textAlignment = NSTextAlignmentRight;
    _titleLab.font = [UIFont systemFontOfSize:14];
    _titleLab.minimumScaleFactor = 0.5;
    _titleLab.adjustsFontSizeToFitWidth=YES;
    [self addSubview:_titleLab];
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-20, (self.height-8)/2.0, 12, 8)];
    _imgView.image = [UIImage imageNamed:@"app_tab_arrow_down"];
    [self addSubview:_imgView];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    _titleLab.text = title;
}



@end
