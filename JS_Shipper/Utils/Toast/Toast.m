//
//  Toast.m
//  Chaozhi
//  Notes：
//
//  Created by Jason on 2018/5/9.
//  Copyright © 2018年 小灵狗出行. All rights reserved.
//

#import "Toast.h"

//Toast默认停留时间
#define ToastDispalyDuration 1.2f
//Toast到顶端/底端默认距离
#define ToastSpace 100.0f
//Toast背景颜色
#define ToastBackgroundColor RGBValue(0x222222)

@interface Toast ()
{
    UIButton *_contentView;
    CGFloat  _duration;
}
@end

@implementation Toast

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

- (id)initWithText:(NSString *)text {
    if (self = [super init]) {
        
        UIFont *font = [UIFont systemFontOfSize:16];
        NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
        CGRect rect=[text boundingRectWithSize:CGSizeMake(250,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,rect.size.width + 40, rect.size.height+ 20)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        _contentView.layer.cornerRadius = 10.0f;
        _contentView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        _contentView.alpha = 0.6;
        [_contentView addSubview:textLabel];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
        _contentView.alpha = 0.0f;
        _duration = ToastDispalyDuration;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    }
    
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify {
    [self hideAnimation];
}

-(void)dismissToast {
    [_contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender {
    [self hideAnimation];
}

- (void)setDuration:(CGFloat)duration {
    _duration = duration;
}

-(void)showAnimation {
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)hideAnimation {
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = window.center;
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

- (void)showFromTopOffset:(CGFloat)top {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = CGPointMake(window.center.x, top + _contentView.frame.size.height/2);
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

- (void)showFromBottomOffset:(CGFloat)bottom {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom + _contentView.frame.size.height/2));
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

#pragma mark-中间显示
+ (void)showCenterWithText:(NSString *)text {
    [Toast showCenterWithText:text duration:ToastDispalyDuration];
}

+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration {
    Toast *toast = [[Toast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast show];
}

#pragma mark-上方显示
+ (void)showTopWithText:(NSString *)text {
    [Toast showTopWithText:text  topOffset:ToastSpace duration:ToastDispalyDuration];
}

+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration {
    [Toast showTopWithText:text  topOffset:ToastSpace duration:duration];
}

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset {
    [Toast showTopWithText:text  topOffset:topOffset duration:ToastDispalyDuration];
}

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration {
    Toast *toast = [[Toast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromTopOffset:topOffset];
}

#pragma mark-下方显示
+ (void)showBottomWithText:(NSString *)text {
    [Toast showBottomWithText:text  bottomOffset:ToastSpace duration:ToastDispalyDuration];
}

+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration {
    [Toast showBottomWithText:text  bottomOffset:ToastSpace duration:duration];
}

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset {
    [Toast showBottomWithText:text  bottomOffset:bottomOffset duration:ToastDispalyDuration];
}

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration {
    Toast *toast = [[Toast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromBottomOffset:bottomOffset];
}

@end