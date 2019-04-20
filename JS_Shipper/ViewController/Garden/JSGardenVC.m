//
//  JSGardenVC.m
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "JSGardenVC.h"
#import "CityCustomView.h"

@interface JSGardenVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArr1;
    NSArray *titleArr2;
    CityCustomView *cityView;
}
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
    titleArr1 = @[@"发货地",@"收货地",@"默认排序",@"筛选"];
    for (NSInteger index = 0; index<4; index++) {
        FilterButton *sender = [[FilterButton alloc]initWithFrame:CGRectMake(index*btW, 0, btW, self.filterView.height)];
//        [sender setImage:[UIImage imageNamed:@"app_tab_arrow_down"] forState:UIControlStateNormal];
        sender.tag = 2000+index;
        [sender setTitle:titleArr1[index] forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(showViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.filterView addSubview:sender];
    }
    
    cityView = [[CityCustomView alloc]init];
    [self.view addSubview:cityView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSGardenTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JSGardenTabCell"];
    return cell;
}

#pragma mark - 筛选按钮选择
/** 筛选按钮选择 */
- (void)showViewAction:(UIButton *)sender {
    switch (sender.tag) {
        case 2000:
        {
            cityView = [[CityCustomView alloc]init];
            [self.view addSubview:cityView];
        }
            break;
            
        default:
            break;
    }
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
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-15, (self.height-4)/2.0, 6, 4)];
    _imgView.image = [UIImage imageNamed:@"app_tab_arrow_down"];
    [self addSubview:_imgView];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    _titleLab.text = title;
}



@end
