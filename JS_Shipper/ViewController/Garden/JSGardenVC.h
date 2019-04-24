//
//  JSGardenVC.h
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSGardenVC : BaseVC
@property (weak, nonatomic) IBOutlet UIView *titleView;
- (IBAction)titleBtnAction:(UIButton*)sender;
@property (weak, nonatomic) IBOutlet UIView *filterView;

@end

@interface JSGardenTabCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *endAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *iphoneCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendMsgBtn;
@end

@interface FilterButton : UIButton
/** 是否选中 */
@property (nonatomic,assign) BOOL isSelect;
/** icon */
@property (nonatomic,retain)  UIImageView *imgView;
/** 文字 */
@property (nonatomic,retain) UILabel *titleLab;
@end

NS_ASSUME_NONNULL_END
