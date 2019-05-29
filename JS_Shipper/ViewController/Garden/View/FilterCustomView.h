//
//  FilterCustomView.h
//  JS_Shipper
//
//  Created by zhanbing han on 2019/4/24.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterCustomView : BaseCustomView
/** 数据源 */
@property (nonatomic,retain) NSArray *dataArr;
/** 标题数组 */
@property (nonatomic,retain) NSArray *titleArr;
/** 单选多选数组  0多选选  1单选 */
@property (nonatomic,retain) NSArray *singleArr;
/** 获取到结果 */
@property (nonatomic,copy) void (^getSelectResultArr)(NSMutableArray *resultArr);
@end

@interface MyCustomView : UIView
{
    MyCustomButton *lastSelectBtn;
    NSMutableArray *allButtonArr;
    NSMutableArray *selectDataDic;
}
/** 是否是单选 */
@property (nonatomic,assign) BOOL isSingle;
/** 是否清空条件 */
@property (nonatomic,assign) BOOL isClear;
/** 数据源 */
@property (nonatomic,retain) NSArray *dataSource;
/** 选中的id */
@property (nonatomic,copy)  void (^getSlectInfo)(NSMutableArray *info);
- (instancetype)initWithdataSource:(NSArray *)dataSource andTilte:(NSString *)titleStr;
@end


NS_ASSUME_NONNULL_END
