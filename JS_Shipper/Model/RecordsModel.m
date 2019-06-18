//
//  RecordsModel.m
//  JS_Shipper
//
//  Created by Jason_zyl on 2019/6/18.
//  Copyright © 2019 zhanbing han. All rights reserved.
//

#import "RecordsModel.h"

@implementation RecordsModel

- (NSString *)image1 {
    if (![_image1 containsString:@"http"]) {
        _image1 = [NSString stringWithFormat:@"%@%@",PIC_URL(),_image1];
    }
    return _image1;
}

- (NSString *)image2 {
    if (![_image2 containsString:@"http"]) {
        _image2 = [NSString stringWithFormat:@"%@%@",PIC_URL(),_image2];
    }
    return _image2;
}

- (NSString *)image3 {
    if (![_image3 containsString:@"http"]) {
        _image3 = [NSString stringWithFormat:@"%@%@",PIC_URL(),_image3];
    }
    return _image3;
}

- (NSString *)image4 {
    if (![_image4 containsString:@"http"]) {
        _image4 = [NSString stringWithFormat:@"%@%@",PIC_URL(),_image4];
    }
    return _image4;
}

@end
