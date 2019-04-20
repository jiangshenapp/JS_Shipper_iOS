//
//  CityCustomView.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/20.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "CityCustomView.h"

#define LineCount 4

@interface CityCustomView()
{
    UIImageView *shadowView;
    UILabel *currentCityLab;
    UIButton *backBtn;
    UIScrollView *bgScro;
    
    NSArray *provinceArr;
    NSArray *cityNameArr;
    NSDictionary *cityDic;

    NSArray *districtArr;
    
    NSInteger provinceIndex;
    NSInteger cityIndex;
    
    CGFloat btnW;
    CGFloat btnH;
}
/** 白背景 */
@property (nonatomic,retain) UIButton *backGroundBtn;
@end

@implementation CityCustomView

-(instancetype)initWithFrame:(CGRect)frame {
    CGRect frame1 = CGRectMake(0, kNavBarH+44, WIDTH, HEIGHT-kNavBarH-44);
    self = [super initWithFrame:frame1];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    shadowView = [[UIImageView alloc]initWithFrame:self.bounds];
    shadowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    [self addSubview:shadowView];
    
    _backGroundBtn = [[UIButton alloc] initWithFrame:self.bounds];
    _backGroundBtn.backgroundColor = [UIColor whiteColor];
//    [bgView addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backGroundBtn];
    
    currentCityLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, WIDTH/2.0, 20)];
    currentCityLab.text = @"选择:全国";
    currentCityLab.font = [UIFont systemFontOfSize:14];
    [_backGroundBtn addSubview:currentCityLab];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-100, 0, 88, 30)];
    [backBtn setTitle:@"返回上一级" forState:UIControlStateNormal];
    [backBtn setTitleColor:AppThemeColor forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    backBtn.hidden = YES;
    [backBtn addTarget:self action:@selector(backPage) forControlEvents:UIControlEventTouchUpInside];
    [_backGroundBtn addSubview:backBtn];
    
    bgScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, backBtn.bottom, WIDTH, _backGroundBtn.height-backBtn.bottom)];
    [_backGroundBtn addSubview:bgScro];
    
    btnW = (WIDTH-12*5)/LineCount;
    btnH = btnW/2.2;;
    
    provinceArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"]];
    NSLog(@"%@",provinceArr);
    [self initProvinceView];
    
}

- (void)initProvinceView {
    [bgScro.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    backBtn.hidden = YES;
    cityNameArr = nil;
    districtArr = nil;
    NSInteger index = 0;
    NSInteger line = provinceArr.count%LineCount==0?provinceArr.count/LineCount:provinceArr.count/LineCount+1;
    for (NSInteger i = 0; i<line; i++) {
        for (NSInteger j = 0; j<4; j++) {
            if (index>=provinceArr.count+1) {
                break;
            }
            NSString *title;
            if (index==0) {
                title = @"全国";
            }
            else {
                NSDictionary *dataDic = provinceArr[index-1];
                title = [dataDic.allKeys firstObject];
            }
            UIButton *sender = [self createButton];
            sender.frame = CGRectMake(12+j*(btnW+12), 12+i*(btnH+12), btnW, btnH);
            [sender setTitle:title forState:UIControlStateNormal];
            [sender addTarget:self action:@selector(getCityAction:) forControlEvents:UIControlEventTouchUpInside];
            sender.tag = 2000+index;
            if (sender.tag==provinceIndex) {
                sender.selected = YES;
                sender.borderColor = kWhiteColor;
                [sender setBackgroundColor:AppThemeColor];
            }
            [bgScro addSubview:sender];
            index++;
        }
    }
    bgScro.contentSize = CGSizeMake(0, MAX(bgScro.height+1, line*(btnH+12)));
}


- (void)getCityAction:(UIButton *)sender {
    sender.selected = YES;
    sender.backgroundColor = AppThemeColor;
    if (sender.tag==2000) {
        return;
    }
    currentCityLab.text = [NSString stringWithFormat:@"选择：%@",sender.currentTitle];
    backBtn.hidden = NO;
    provinceIndex = sender.tag;
    cityIndex = 0;
    NSDictionary *dic = provinceArr[sender.tag-2000-1];
    cityDic = dic[sender.currentTitle];
    cityNameArr = cityDic.allKeys;
    NSLog(@"%@",cityNameArr);
    [self initCityView];
}

- (void)initCityView {
    districtArr = nil;
    [bgScro.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger index = 0;
    NSInteger line = cityNameArr.count%LineCount==0?cityNameArr.count/LineCount:cityNameArr.count/LineCount+1;
    for (NSInteger i = 0; i<line; i++) {
        for (NSInteger j = 0; j<4; j++) {
            if (index>=cityNameArr.count+1) {
                break;
            }
            NSString *title;
            if (index==0) {
                title = @"全省";
            }
            else {
                title = cityNameArr[index-1];
            }
            UIButton *sender = [self createButton];
            sender.frame = CGRectMake(12+j*(btnW+12), 12+i*(btnH+12), btnW, btnH);
            [sender setTitle:title forState:UIControlStateNormal];
            [sender addTarget:self action:@selector(getDistrictAction:) forControlEvents:UIControlEventTouchUpInside];
            sender.tag = 3000+index;
            if (sender.tag==cityIndex) {
                sender.selected = YES;
                sender.borderColor = kWhiteColor;
                [sender setBackgroundColor:AppThemeColor];
            }
            [bgScro addSubview:sender];
            index++;
        }
    }
    bgScro.contentSize = CGSizeMake(0, MAX(bgScro.height+1, line*(btnH+12)));
}

- (void)getDistrictAction:(UIButton *)sender {
    sender.selected = YES;
    sender.backgroundColor = AppThemeColor;
    if (sender.tag==3000) {
        [self hiddenView];
        return;
    }
    currentCityLab.text = [NSString stringWithFormat:@"选择：%@",sender.currentTitle];
    backBtn.hidden = NO;
    cityIndex = sender.tag;
    districtArr = cityDic[sender.currentTitle];
    [self initDistrictView];
}

- (void)initDistrictView {
    [bgScro.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger index = 0;
    NSInteger line = districtArr.count%LineCount==0?districtArr.count/LineCount:districtArr.count/LineCount+1;
    for (NSInteger i = 0; i<line; i++) {
        for (NSInteger j = 0; j<4; j++) {
            if (index>=districtArr.count+1) {
                break;
            }
            NSString *title;
            if (index==0) {
                title = @"全市";
            }
            else {
                title = districtArr[index-1];
            }
            UIButton *sender = [self createButton];
            sender.frame = CGRectMake(12+j*(btnW+12), 12+i*(btnH+12), btnW, btnH);
            [sender setTitle:title forState:UIControlStateNormal];
            [sender addTarget:self action:@selector(getNameAction:) forControlEvents:UIControlEventTouchUpInside];
            sender.tag = 4000+index;
            [bgScro addSubview:sender];
            index++;
        }
    }
    bgScro.contentSize = CGSizeMake(0, MAX(bgScro.height+1, line*(btnH+12)));
}

- (void)getNameAction:(UIButton *)sender {
    if (sender.tag==4000) {
        [self hiddenView];
        return;
    }
    sender.selected = YES;
    sender.backgroundColor = AppThemeColor;
    sender.borderColor = kWhiteColor;
    currentCityLab.text = [NSString stringWithFormat:@"选择：%@",sender.currentTitle];
    [self hiddenView];
}

- (void)backPage {
    if (districtArr.count==0&&cityNameArr.count>0) {//当前城市级别
        [self initProvinceView];
    }
    else if (districtArr.count>0&&cityNameArr.count>0) {
        [self initCityView];
    }
}



-(UIButton *)createButton{
    UIButton *sender = [[UIButton alloc]init];
    sender.layer.borderColor = [UIColor blackColor].CGColor;
    sender.layer.borderWidth = 0.5;
    sender.layer.cornerRadius =2;
    sender.layer.masksToBounds = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:14];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [sender setTitleColor:AppThemeColor forState:UIControlStateHighlighted];
    return sender;
}



- (void)hiddenView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.backGroundBtn.top = -HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
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
