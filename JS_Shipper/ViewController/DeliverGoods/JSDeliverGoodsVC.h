//
//  JSDeliverGoodsVC.h
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "BaseVC.h"
#import "SDCycleScrollView.h"
#import "JSConfirmAddressMapVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSDeliverGoodsVC : BaseVC
@property (weak, nonatomic) IBOutlet UIButton *startAddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *endAddressBtn;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;

- (IBAction)sendGoodsAction:(UIButton *)sender;
- (IBAction)carLongAction:(UIButton *)sender;
- (IBAction)carTypeAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
