//
//  CameraManager.m
//  AIBits
//
//  Created by Admin on 3/25/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import "CameraManager.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface CameraManager()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIViewController *cameraVc;
    UIImage *chosenImage;
    
}

@property(weak,nonatomic)id<CameraProtocol> cameraProtocol;
@end
@implementation CameraManager
BOOL isAllowed = YES;
BOOL takenFromCamera = NO;

- (instancetype)initWith:(id<CameraProtocol>)cameraProtocol_ vc:(UIViewController *)vc
{
    self = [super init];
    if(self)
    {
        self.cameraProtocol = cameraProtocol_;
        cameraVc = vc;
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            isAllowed = NO;
        }
    }
    return self;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    [picker dismissViewControllerAnimated:YES completion:nil];

    if ([mediaType isEqualToString:(NSString *) kUTTypeImage]) {
        chosenImage = info[UIImagePickerControllerEditedImage];
        [_cameraProtocol selectedPhotoFromLibrary:chosenImage];
        if (takenFromCamera) {
           
            UIImageWriteToSavedPhotosAlbum(chosenImage,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
            takenFromCamera = NO;
        }
    }
    else if([mediaType isEqualToString:(NSString *) kUTTypeMovie]){
        [_cameraProtocol selectedVideoUrlFromLibrary:info[UIImagePickerControllerMediaURL]];
        takenFromCamera = NO;
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"Error");
        [_cameraProtocol cameraPictureTakenFailed];
    }
    else
        [_cameraProtocol cameraPictureTakenSuccess];
}

- (void) UIImageWriteToFile:(UIImage *)image fileName:(NSString *)fileName
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = dirPaths[0];
    NSString *filePath = [documentDirectoryPath stringByAppendingPathComponent:fileName];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:filePath atomically:YES];
}

-(void) UIImageReadFromFile:(UIImage **)image fileName:(NSString *)fileName
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = dirPaths[0];
    NSString *filePath = [documentDirectoryPath stringByAppendingPathComponent:fileName];
    
    chosenImage = [UIImage imageWithContentsOfFile:filePath];
}

- (void)captureRecord
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *videoRecorder = [[UIImagePickerController alloc]init];
        videoRecorder.delegate = self;
        if (!isAllowed ) {
            return;
        }
        takenFromCamera = YES;
        videoRecorder.sourceType = UIImagePickerControllerSourceTypeCamera;
        videoRecorder.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeMovie];
        [cameraVc presentViewController:videoRecorder animated:YES completion:NULL];
     
    }
    else {
       
    }
}

- (void)captureImage
{
    if(isAllowed)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        takenFromCamera = YES;
        [cameraVc presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)browseImage
{
    if(isAllowed)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        takenFromCamera = NO;
        [cameraVc presentViewController:picker animated:YES completion:NULL];
    }
}

@end
