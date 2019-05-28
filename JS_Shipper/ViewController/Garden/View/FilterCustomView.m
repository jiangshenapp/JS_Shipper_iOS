//
//  FilterCustomView.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/24.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "FilterCustomView.h"

#define LineCount 4
#define WorkSpace  10
#define ButtonWidth (WIDTH -WorkSpace*(LineCount+1))/LineCount

@interface FilterCustomView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *bgTabView;
    BOOL isClearAll;
}
@end

@implementation FilterCustomView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.frame = CGRectMake(0, kNavBarH+46, WIDTH, HEIGHT-kNavBarH-46-kTabBarSafeH);
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    UIWindow *myWindow= [[[UIApplication sharedApplication] delegate] window];
    [myWindow addSubview:self];
    self.hidden = YES;
    self.viewHeight = self.height;
    bgTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width-12, self.height-autoScaleW(50)) style:UITableViewStyleGrouped];
    bgTabView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    bgTabView.backgroundColor = [UIColor whiteColor];
    bgTabView.delegate = self;
    bgTabView.dataSource = self;
    bgTabView.clipsToBounds = NO;
    [self addSubview:bgTabView];
    
    UIButton *sender = [[UIButton alloc]initWithFrame:CGRectMake(0, self.height-autoScaleW(50), autoScaleW(150), autoScaleW(50))];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [sender setTitle:@"清空条件" forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(clearAllSelect) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sender];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(sender.right, sender.top, WIDTH-sender.width, sender.height)];
    sureBtn.backgroundColor = AppThemeColor;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [sureBtn setTitle:@"确定条件" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, sender.top, WIDTH, 1)];
    lineView.backgroundColor = PageColor;
    [self addSubview:lineView];
    
    [bgTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(0);
    }];
    
    [sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH*0.4, autoScaleW(50)));
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH*0.6, autoScaleW(50)));
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.left.mas_equalTo(sender.mas_right).offset(0);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH, 1));
        make.bottom.mas_equalTo(sender.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];
}

#pragma mark -- dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFilterTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"filterViewCell"];
    if (cell==nil) {
        cell = [[MyFilterTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"filterViewCell"];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *arr = _dataArr[indexPath.section];
    cell.dataSource = arr;
    cell.isSingle = NO;
    cell.getSlectInfo = ^(NSString * _Nonnull info) {
        NSLog(@"%@",info);
    };
    cell.isClear = isClearAll;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = _dataArr[indexPath.section];
    NSInteger count = arr.count+1;
    NSInteger line = count%LineCount==0?(count/LineCount):((count/LineCount)+1);
    CGFloat cellH = WorkSpace+(line*(ButtonWidth*0.5+WorkSpace));
    return cellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, WIDTH/2.0, 20)];
    if (section<_titleArr.count&&section>=0) {
        label.text = _titleArr[section];
    }
    label.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:label];
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    footerView.clipsToBounds = YES;
    UITextField *contentTF = [[UITextField alloc]initWithFrame:CGRectMake(12, 10, WIDTH/2.0, 36)];
    contentTF.placeholder = @"请输入其他车长";
    contentTF.layer.borderColor = RGBValue(0xB4B4B4).CGColor;
    contentTF.layer.borderWidth = 0.5;
    contentTF.layer.cornerRadius =2;
    contentTF.layer.masksToBounds = YES;
    contentTF.font = [UIFont systemFontOfSize:14];
    [footerView addSubview:contentTF];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 1)];
    contentTF.leftView = lineView;
    contentTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, footerView.height-10, WIDTH, 10)];
    bgView.backgroundColor = RGBValue(0xF5f5f5);
    [footerView addSubview:bgView];
    
    return footerView;
}

-(void)setDataArr:(NSArray *)dataArr {
    if (_dataArr!=dataArr) {
        _dataArr = dataArr;
    }
    [bgTabView reloadData];
}

- (void)clearAllSelect{
    isClearAll = YES;
    [bgTabView reloadData];
    isClearAll = NO;
}

- (void)showView {
    __weak typeof(self) weakSelf = self;
    weakSelf.height = 0;
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.height = weakSelf.viewHeight;
    } completion:^(BOOL finished) {
    }];
}


- (void)hiddenView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.height = 0;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation MyFilterTabCell
- (void)setDataSource:(NSArray *)dataSource {
    if (self.dataSource.count>0) {
        return;
    }
    if (_dataSource!=dataSource) {
        _dataSource = dataSource;
    }
    [self createView];
}

- (void)createView {
    self.clipsToBounds = YES;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    allButtonArr = [NSMutableArray array];
    NSInteger count = _dataSource.count+1;
    NSInteger line = count%LineCount==0?(count/LineCount):((count/LineCount)+1);
    NSInteger index = 0;
    for (NSInteger i = 0; i<line; i++) {
        for (NSInteger j =0; j < LineCount; j ++) {
            if (index>count) {
                break;
            }
           MyCustomButton *_button = [[MyCustomButton alloc]initWithFrame:CGRectMake(WorkSpace+(j*(ButtonWidth+WorkSpace)), WorkSpace+(i*(ButtonWidth*0.5+WorkSpace)), ButtonWidth, ButtonWidth*0.5)];
            if (index==0) {
                [_button setTitle:@"不限" forState:UIControlStateNormal];
            }
            else {
                [_button setTitle:_dataSource[index-1][@"label"] forState:UIControlStateNormal];
                _button.dataDic = _dataSource[index-1];
            }
            _button.index = index;
            [_button addTarget:self action:@selector(buttonTouchAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_button];
            [allButtonArr addObject:_button];
            index++;
        }
        if (index>count) {
            break;
        }
    }
}

- (void)buttonTouchAction:(MyCustomButton *)sender {
    if (infoStr==nil) {
        infoStr = @"";
    }
    if (_isSingle) {//是单选
        lastSelectBtn.isSelect = NO;
        lastSelectBtn = sender;
        infoStr = @"";
    }
    else {
        if (sender.index==0) {
            infoStr = @"";
            for (MyCustomButton *btn in allButtonArr) {
                if (btn.index!=0) {
                    btn.isSelect = NO;
                }
            }
        }
        else {
            MyCustomButton *btn = [allButtonArr firstObject];
            btn.isSelect = NO;
        }
    }
    sender.isSelect = !sender.isSelect;
    NSDictionary *dic = sender.dataDic;
    NSString *valueStr = @"";
    if ([dic isKindOfClass:[NSDictionary class]]) {
        valueStr = dic[@"value"];
    }
    if (sender.isSelect) {
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"%@,",valueStr]];
    }
    else {
       infoStr= [infoStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@,",valueStr] withString:@""];
    }
    if (_getSlectInfo) {
        self.getSlectInfo(infoStr);
    }
}

- (void)setIsClear:(BOOL)isClear {
    if (_isClear!=isClear) {
        _isClear = isClear;
    }
    infoStr = @"";
    for (MyCustomButton *btn in allButtonArr) {
            btn.isSelect = NO;
    }
    if (_getSlectInfo) {
        self.getSlectInfo(infoStr);
    }
}

@end

