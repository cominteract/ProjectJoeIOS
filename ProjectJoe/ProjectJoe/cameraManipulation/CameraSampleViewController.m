//
//  CameraSampleViewController.m
//  AIBits
//
//  Created by Admin on 3/25/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import "CameraSampleViewController.h"
#import "CameraManager.h"
@interface CameraSampleViewController ()<CameraProtocol>
{
    CameraManager *cameraManager;
}

@property (weak, nonatomic) IBOutlet UIImageView *cameraSampleImageView;


@end

@implementation CameraSampleViewController
- (IBAction)takePhotoClicked:(id)sender {
    [cameraManager captureImage];
}

- (IBAction)cameraSampleImageViewClicked:(id)sender {
    [cameraManager browseImage];
}

- (IBAction)recordCameraClicked:(id)sender {
    [cameraManager captureRecord];
}

- (void)selectedVideoUrlFromLibrary:(NSURL *)videoUrl
{
    
}

- (void)cameraRecordSuccess
{
    
}
- (void)cameraPictureTakenSuccess

{
    
}


- (void)cameraPictureTakenFailed
{
    
}
- (void)cameraRecordFailed
{
    
}
- (void)cameraRecordError
{
    
}
- (void)cameraPictureTakenError
{
    
}
- (void)selectedPhotoFromLibrary:(UIImage *)image
{
    [_cameraSampleImageView setImage:image];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    cameraManager = [[CameraManager alloc]initWith:self vc:self];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
