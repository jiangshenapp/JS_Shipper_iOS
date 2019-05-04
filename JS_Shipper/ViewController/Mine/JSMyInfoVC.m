//
//  JSMyInfoVC.m
//  JS_Shipper
//
//  Created by zhanbing han on 2019/3/29.
//  Copyright © 2019年 zhanbing han. All rights reserved.
//

#import "JSMyInfoVC.h"

@interface JSMyInfoVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation JSMyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户中心";

}

#pragma mark - methods

/* 修改头像 */
- (IBAction)changeHeadImgAction:(id)sender {
    [self.view endEditing:YES]; //隐藏键盘
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"本地相册",@"拍照",  nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.allowsEditing = YES;
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:NO completion:^{}];
        }
            break;
        case 1:
        {
            if ([Utils isCameraPermissionOn]) {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerController.allowsEditing = YES;
                imagePickerController.delegate = self;
                
                if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
                    self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
                }
                [self presentViewController:imagePickerController animated:NO completion:nil];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *iconImage = info[UIImagePickerControllerEditedImage];
    self.headImgView.image = iconImage;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        NSData *imageData = UIImageJPEGRepresentation(iconImage, 0.01);
        NSMutableArray *imageDataArr = [NSMutableArray arrayWithObjects:imageData, nil];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"pigx",@"resourceId", nil];
        [[NetworkManager sharedManager] postJSON:URL_FileUpload parameters:dic imageDataArr:imageDataArr imageName:@"file" completion:^(id responseData, RequestState status, NSError *error) {
            
            if (status == Request_Success) {
                
            }
        }];
    }];
}

/* 修改昵称 */
- (IBAction)changeNickNameAction:(id)sender {
    
}

/* 清除缓存 */
- (IBAction)clearCacheAction:(id)sender {
    
}

/* 安全退出 */
- (IBAction)logoutAction:(id)sender {
    [Utils logout:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
