//
//  FilterCustomView.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/24.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "FilterCustomView.h"

#define HeaderHeight 30
#define LineCount 4
#define WorkSpace  10
#define ButtonWidth (WIDTH -WorkSpace*(LineCount+1))/LineCount

@interface FilterCustomView ()
{
    BOOL isClearAll;
    UIScrollView *bgScrollView;
    NSMutableArray *allCellViewArr;
}
/** 所选择的数组 */
@property (nonatomic,retain) NSMutableArray *selectArr;
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
    _selectArr = [NSMutableArray array];
    self.frame = CGRectMake(0, kNavBarH+46, WIDTH, HEIGHT-kNavBarH-46-kTabBarSafeH);
    self.backgroundColor = PageColor;
    self.clipsToBounds = YES;
    UIWindow *myWindow= [[[UIApplication sharedApplication] delegate] window];
    [myWindow addSubview:self];
    self.hidden = YES;
    self.viewHeight = self.height;
    
    bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width-12, self.height-autoScaleW(50))];
    [self addSubview:bgScrollView];
    
    UIButton *sender = [[UIButton alloc]initWithFrame:CGRectMake(0, self.height-autoScaleW(50), autoScaleW(150), autoScaleW(50))];
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [sender setTitle:@"清空" forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(clearAllSelect) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sender];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(sender.right, sender.top, WIDTH-sender.width, sender.height)];
    sureBtn.backgroundColor = AppThemeColor;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(confirmSelect) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, sender.top, WIDTH, 1)];
    lineView.backgroundColor = PageColor;
    [self addSubview:lineView];
    
    [bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
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

-(void)confirmSelect {
    if (self.getSelecObjectArr) {
        self.getSelecObjectArr(self.selectArr);
    }
    [self hiddenView];
}

- (void)refreshUI {
    allCellViewArr = [NSMutableArray array];
    CGFloat maxViewBottom = 0;
    __weak typeof(self) weakSelf = self;
    for (NSInteger index = 0; index < _dataArr.count; index++) {
        BOOL isSingle = NO;
        NSArray *arr = _dataArr[index];
        NSString *titleStr = _titleArr[index];
        if ([titleStr containsString:@"用车"]) {
            isSingle = YES;
        }
        else {
            titleStr = [titleStr stringByAppendingString:@":(可多选)"];
        }
        MyCustomView *view = [[MyCustomView alloc]initWithdataSource:arr andTilte:titleStr];
        view.top = maxViewBottom;
//        BOOL isSingle = [_singleArr[index] boolValue];
        view.isSingle = isSingle;
        maxViewBottom = view.height+maxViewBottom;
        view.getSlectInfo = ^(NSArray * _Nonnull info) {
            [weakSelf.selectArr replaceObjectAtIndex:index withObject:info];
        };
        [bgScrollView addSubview:view];
        [allCellViewArr addObject:view];
    }
    bgScrollView.contentSize = CGSizeMake(0, MAX(bgScrollView.height+1, maxViewBottom));
}

-(void)setDataArr:(NSArray *)dataArr {
    if (_dataArr!=dataArr) {
        _dataArr = dataArr;
    }
    [_selectArr removeAllObjects];
    [bgScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSInteger index = 0; index<_dataArr.count; index++) {
        [_selectArr addObject:@""];
    }
    [self refreshUI];
}

- (void)clearAllSelect{
    isClearAll = YES;
    for (MyCustomView *view in allCellViewArr) {
        view.isClear = YES;
    }
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


@implementation MyCustomView

- (instancetype)initWithdataSource:(NSArray *)dataSource andTilte:(NSString *)titleStr {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        selectDataDic = [NSMutableArray array];
        allButtonArr = [NSMutableArray array];
        NSInteger count = dataSource.count+1;
        NSInteger line = count%LineCount==0?(count/LineCount):((count/LineCount)+1);
        CGFloat cellH = HeaderHeight+ WorkSpace+(line*(ButtonWidth*0.5+WorkSpace))+20;
        self.frame = CGRectMake(0, 0, WIDTH, cellH);
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, WIDTH/2.0, HeaderHeight)];
        titleLab.text = titleStr;
        titleLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleLab];
        
        NSInteger index = 0;
        for (NSInteger i = 0; i<line; i++) {
            for (NSInteger j =0; j < LineCount; j ++) {
                if (index>=count) {
                    break;
                }
                MyCustomButton *_button = [[MyCustomButton alloc]initWithFrame:CGRectMake(WorkSpace+(j*(ButtonWidth+WorkSpace)), HeaderHeight+WorkSpace+(i*(ButtonWidth*0.5+WorkSpace)), ButtonWidth, ButtonWidth*0.5)];
                if (index==0) {
                    [_button setTitle:@"不限" forState:UIControlStateNormal];
                    _button.dataDic = @{@"value":@"",@"label":@"不限"};
                }
                else {
                    [_button setTitle:dataSource[index-1][@"label"] forState:UIControlStateNormal];
                    _button.dataDic = dataSource[index-1];
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
        UITextField *contentTF = [[UITextField alloc]initWithFrame:CGRectMake(12, 10, WIDTH/2.0, 36)];
        contentTF.placeholder = @"请输入其他车长";
        contentTF.layer.borderColor = RGBValue(0xB4B4B4).CGColor;
        contentTF.layer.borderWidth = 0.5;
        contentTF.layer.cornerRadius =2;
        contentTF.layer.masksToBounds = YES;
        contentTF.hidden = YES;
        contentTF.font = [UIFont systemFontOfSize:14];
        [self addSubview:contentTF];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 1)];
        contentTF.leftView = lineView;
        contentTF.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-10, WIDTH, 10)];
        bgView.backgroundColor = PageColor;
        [self addSubview:bgView];
    }
    return self;
}

- (void)buttonTouchAction:(MyCustomButton *)sender {
    if (_isSingle) {//是单选
        lastSelectBtn.isSelect = NO;
        lastSelectBtn = sender;
        [selectDataDic removeAllObjects];
    }
    else {
        if (sender.index==0) {
           [selectDataDic removeAllObjects];
            for (MyCustomButton *btn in allButtonArr) {
                if (btn.index!=0) {
                    btn.isSelect = NO;
                }
            }
        }
        else {
            MyCustomButton *btn = [allButtonArr firstObject];
            btn.isSelect = NO;
            [selectDataDic removeObject:btn.dataDic];
        }
    }
    sender.isSelect = !sender.isSelect;
    if (sender.isSelect) {
        if (![selectDataDic containsObject:sender.dataDic]) {
            [selectDataDic addObject:sender.dataDic];
        }
    }
    else {
        [selectDataDic removeObject:sender.dataDic];
    }
    if (_getSlectInfo) {
        self.getSlectInfo(selectDataDic);
    }
}

- (void)setIsClear:(BOOL)isClear {
    if (_isClear!=isClear) {
        _isClear = isClear;
    }
    [selectDataDic removeAllObjects];
    for (MyCustomButton *btn in allButtonArr) {
        btn.isSelect = NO;
    }
    if (_getSlectInfo) {
        self.getSlectInfo(selectDataDic);
    }
}
@end

