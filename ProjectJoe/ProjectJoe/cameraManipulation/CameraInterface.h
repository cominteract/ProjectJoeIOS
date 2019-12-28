//
//  CameraInterface.h
//  AIBits
//
//  Created by Admin on 3/25/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CameraProtocol<NSObject>
- (void)cameraPictureTakenSuccess;
- (void)cameraPictureTakenFailed;
- (void)cameraPictureTakenError;
- (void)cameraRecordSuccess;
- (void)cameraRecordFailed;
- (void)cameraRecordError;
- (void)selectedPhotoFromLibrary:(UIImage *)image;
- (void)selectedVideoUrlFromLibrary:(NSURL *)videoUrl;
@end
@interface CameraInterface : NSObject

@end
