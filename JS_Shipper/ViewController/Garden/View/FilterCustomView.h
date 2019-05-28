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
@end

@interface MyFilterTabCell : UITableViewCell
{
    MyCustomButton *lastSelectBtn;
    NSString *infoStr;
    NSMutableArray *allButtonArr;
}
/** 是否是单选 */
@property (nonatomic,assign) BOOL isSingle;
/** 是否清空条件 */
@property (nonatomic,assign) BOOL isClear;
/** 数据源 */
@property (nonatomic,retain) NSArray *dataSource;
/** 选中的id */
@property (nonatomic,copy)  void (^getSlectInfo)(NSString *info);
@end


NS_ASSUME_NONNULL_END
