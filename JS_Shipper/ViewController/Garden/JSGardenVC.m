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
    NSArray *titleViewArr;
    CityCustomView *cityView1;
     CityCustomView *cityView2;
    SortView *mySortView;
    FilterCustomView *filteView;
    NSMutableArray *showFlagArr;
}
/** 0车源  1城市配送 2精品路线 */
@property (nonatomic,assign) NSInteger pageFlag;
/** 传参字典 0 */
@property (nonatomic,retain) NSDictionary *postUrlDic;
/** 区域编码1 */
@property (nonatomic,copy) NSString *areaCode1;
/** 区域编码2 */
@property (nonatomic,copy) NSString *areaCode2;
/** 数据源 */
@property (nonatomic,retain) NSMutableArray *dataSource;
/** <#object#> */
@property (nonatomic,retain) HomeDataModel *dataModels;
@end

@implementation JSGardenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self getNetData];
}

-(void)initView {
    _pageFlag = 0;
    _titleView.top = 7+kStatusBarH;
    _titleView.centerX = WIDTH/2.0;
    [self.navBar addSubview:_titleView];
    CGFloat btW = WIDTH/4.0;
    titleArr1 = @[@"发货地",@"收货地",@"默认排序",@"筛选"];
    showFlagArr = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    for (NSInteger index = 0; index<4; index++) {
        FilterButton *sender = [[FilterButton alloc]initWithFrame:CGRectMake(index*btW, 0, btW, self.filterView.height)];
//        [sender setImage:[UIImage imageNamed:@"app_tab_arrow_down"] forState:UIControlStateNormal];
        sender.tag = 20000+index;
        [sender setTitle:titleArr1[index] forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(showViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.filterView addSubview:sender];
    }
    __weak typeof(self) weakSelf = self;
    cityView1 = [[CityCustomView alloc]init];
    cityView1.getCityData = ^(NSDictionary * _Nonnull dataDic) {
        FilterButton *tempBtn = [weakSelf.view viewWithTag:20000];
        tempBtn.isSelect = NO;
        [tempBtn setTitle:dataDic[@"address"] forState:UIControlStateNormal];
        weakSelf.areaCode1 = dataDic[@"code"];
        [weakSelf getNetData];
    };
    cityView2 = [[CityCustomView alloc]init];
    cityView2.getCityData = ^(NSDictionary * _Nonnull dataDic) {
        FilterButton *tempBtn = [weakSelf.view viewWithTag:20001];
        [tempBtn setTitle:dataDic[@"address"] forState:UIControlStateNormal];
        weakSelf.areaCode2 = dataDic[@"code"];
        tempBtn.isSelect = NO;
        [weakSelf getNetData];
    };
    mySortView = [[SortView alloc]init];
    filteView = [[FilterCustomView alloc]init];
    titleViewArr = @[cityView1,cityView2,mySortView,filteView];
    _postUrlDic = @{@(0):URL_Find,@(1):URL_Find,@(2):URL_Classic};
    _areaCode1 = @"";
    _areaCode2 = @"";
    _dataSource = [NSMutableArray array];
}

#pragma mark - 获取数据
- (void)getNetData {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_areaCode1 forKey:@"arriveAddressCode"];
    [dic setObject:_areaCode2 forKey:@"startAddressCode"];
    NSString *url = _postUrlDic[@(_pageFlag)];
    [[NetworkManager sharedManager] postJSON:url parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        if (status == Request_Success) {
            weakSelf.dataModels = [HomeDataModel mj_objectWithKeyValues:responseData];
        }
        [weakSelf.baseTabView reloadData];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataModels.records.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordsModel *model =self.dataModels.records[indexPath.section];
    if (_pageFlag==0||_pageFlag==2) {
        JSGardenTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JSGardenTabCell"];
        cell.countBtn.hidden = _pageFlag;
        
        return cell;
    }
    else if (_pageFlag==1) {
        CityDeliveryTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityDeliveryTabCell"];
        [cell.serviceBtn addTarget:self action:@selector(showDevileryText:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, autoScaleW(80))];
    view.backgroundColor = PageColor;
    view.clipsToBounds = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, view.width-24, view.height-20)];
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    label.text = @"哈达款到发货静安寺开发的哈快递费哈卡士大夫哈速度快放假";
    [label sizeToFit];
    label.width = view.width-24;
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_pageFlag==1) {
        NSInteger isShow = [showFlagArr[section] integerValue];
        if (isShow) {
            return autoScaleW(80);
        }
    }
    return 0.01;
}

- (void)showDevileryText:(UIButton*)sender {
    sender.selected = !sender.selected;
    NSString *flag = [NSString stringWithFormat:@"%d",sender.selected];
    CityDeliveryTabCell *cell = (CityDeliveryTabCell *)sender.superview.superview;
    cell.isShowImgView.image = sender.selected?[UIImage imageNamed:@"app_list_arrow_up"]:[UIImage imageNamed:@"app_list_arrow_down"];
    NSIndexPath *indexPath = [self.baseTabView indexPathForCell:cell];
    [showFlagArr replaceObjectAtIndex:indexPath.section withObject:flag];
    [self.baseTabView reloadData];
}

#pragma mark - 筛选按钮选择
/** 筛选按钮选择 */
- (void)showViewAction:(FilterButton *)sender {
    sender.userInteractionEnabled = NO;
    sender.isSelect = !sender.isSelect;
    for (NSInteger index = 0; index<4; index++) {
        FilterButton *tempBtn = [self.view viewWithTag:20000+index];
        BaseCustomView *vv = titleViewArr[index];
        if (![sender isEqual:tempBtn]) {
            tempBtn.isSelect = NO;
            [vv hiddenView];
        }
        else {
            if (sender.isSelect) {
                [vv showView];
            }
            else {
                [vv hiddenView];
            }
        }
    }
    sender.userInteractionEnabled = YES;
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
    _pageFlag = sender.tag-100;
    [self getNetData];
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
    [self.baseTabView reloadData];
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


@implementation CityDeliveryTabCell
-(void)awakeFromNib {
    [super awakeFromNib];
    _navBtn.layer.borderColor = _navBtn.currentTitleColor.CGColor;
    _navBtn.layer.borderWidth = 1;
    _navBtn.layer.cornerRadius = 12;
    _navBtn.layer.masksToBounds = YES;
}
@end

@implementation RecordsModel


@end

@implementation HomeDataModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"records":[RecordsModel class]};
}
@end
