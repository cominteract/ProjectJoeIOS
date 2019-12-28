//
//  CameraManager.h
//  AIBits
//
//  Created by Admin on 3/25/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraInterface.h"
#import <UIKit/UIKit.h>


@interface CameraManager : NSObject
- (void) UIImageWriteToFile:(UIImage *)image fileName:(NSString *)fileName;
- (void) UIImageReadFromFile:(UIImage **)image fileName:(NSString *)fileName;
- (void) captureImage;
- (void) browseImage;
- (void)captureRecord;
- (instancetype)initWith:(id<CameraProtocol>)cameraProtocol_ vc:(UIViewController *)vc;
@end


