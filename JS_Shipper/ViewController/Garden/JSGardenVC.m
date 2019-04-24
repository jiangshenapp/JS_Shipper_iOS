//
//  JSGardenVC.m
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "JSGardenVC.h"
#import "CityCustomView.h"
#import "SortView.h"
#import "FilterCustomView.h"

@interface JSGardenVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArr1;
    NSArray *titleArr2;
    CityCustomView *cityView1;
     CityCustomView *cityView2;
    SortView *mySortView;
    FilterCustomView *filteView;
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
        sender.tag = 20000+index;
        [sender setTitle:titleArr1[index] forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(showViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.filterView addSubview:sender];
    }
    cityView1 = [[CityCustomView alloc]init];
    cityView2 = [[CityCustomView alloc]init];
    mySortView = [[SortView alloc]init];
    filteView = [[FilterCustomView alloc]init];
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
- (void)showViewAction:(FilterButton *)sender {
    for (NSInteger index = 0; index<4; index++) {
        FilterButton *tempBtn = [self.view viewWithTag:20000+index];
        if ([sender isEqual:tempBtn]) {
            sender.isSelect = !sender.isSelect;
        }
        else {
            if (tempBtn.isSelect) {
                [self hiddenAllView:index];
            }
         tempBtn.isSelect = NO;
        }
    }
    NSLog(@"%d",sender.isSelect);
    if (sender.isSelect==NO) {
        [self hiddenAllView:-1];
        return;
    }
    switch (sender.tag-20000) {
        case 0:
        {
            [cityView1 showView];
        }
            break;
        case 1:
        {
            [cityView2 showView];
           
        }
            break;
        case 2:
        {
            [mySortView showView];
        }
            break;
        case 3:
        {
            [filteView showView];
        }
            break;
            
        default:
            break;
    }
}

- (void)hiddenAllView:(NSInteger)tag{
    switch (tag) {
        case 0:
        {
          [cityView1 hiddenView];
            break;
        }
        case 1:
        {
           [cityView2 hiddenView];
             break;
        }
        case 2:
        {
           [mySortView hiddenView];
             break;
        }
        case 3:
        {
            [filteView hiddenView];
             break;
        }
        default:
        {
            [cityView1 hiddenView];
            [cityView2 hiddenView];
            [mySortView hiddenView];
            [filteView hiddenView];
        }
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
-(void)setIsSelect:(BOOL)isSelect {
    if (_isSelect!=isSelect) {
        _isSelect = isSelect;
    }
    if (isSelect) {
        _titleLab.textColor = AppThemeColor;
        _imgView.image = [UIImage imageNamed:@"app_tab_arrow_up"];
    }
    else {
        _titleLab.textColor = kBlackColor;
        _imgView.image = [UIImage imageNamed:@"app_tab_arrow_down"];
    }
}


@end
