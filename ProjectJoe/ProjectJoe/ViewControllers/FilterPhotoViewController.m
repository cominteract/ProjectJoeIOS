//
//  FilterPhotoViewController.m
//  ProjectJoe
//
//  Created by andre insigne on 21/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "FilterPhotoViewController.h"
#import "TagPhotoViewController.h"
#import "FilterPhotoCollectionViewCell.h"
#import "ImageManager.h"
#import "CompletePhotoViewController.h"
@interface FilterPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, ImageProtocol>
{

}
@property (weak, nonatomic) IBOutlet UICollectionView *filterPhotoCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *filterPhotoImageView;





@end

@implementation FilterPhotoViewController
ImageManager *imageManager;

BOOL isUpdated = YES;
- (NSArray <NSString *> *) getFilters
{
    return  @[@"effect_black"
                          ,@"effect_boost_1"
                          ,@"effect_boost_2"
                          ,@"effect_boost_3"
                          ,@"effect_brightness"
                          ,@"effect_color_blue"
                          ,@"effect_color_depth_32"
                          ,@"effect_color_depth_64"
                          ,@"effect_color_green"
                          ,@"effect_color_red"
                          ,@"effect_contrast"
                          ,@"effect_emboss"
                          ,@"effect_engrave"
                          ,@"effect_flea"
                          ,@"effect_gamma"
                          ,@"effect_gaussian_blue"
                          ,@"effect_grayscale"
                          ,@"effect_highlight"
                          ,@"effect_hue"
                          ,@"effect_invert"
                          ,@"effect_mean_remove"
                          ,@"effect_reflaction"
                          ,@"effect_round_corner"
                          ,@"effect_saturation"
                          ,@"effect_sepia_blue"
                          ,@"effect_sepia_green"
                          ,@"effect_sepia"
                          ,@"effect_shading_cyan"
                          ,@"effect_shading_green"
                          ,@"effect_shading_red"
                          ,@"effect_sheding_yellow"
                          ,@"effect_shading"
                          ,@"effect_smooth"
                          ,@"effect_tint"
                          ,@"effect_watermark"];

}

- (NSArray <NSNumber *> *) getFilterConstants
{
    return  @[[NSNumber numberWithInt:kPhotoBlack]
              ,[NSNumber numberWithInt:kPhotoWarm]
              ,[NSNumber numberWithInt:kPhotoBump]
              ,[NSNumber numberWithInt:kPhotoMedianFilter]
              ,[NSNumber numberWithInt:kPhotoBrightness]
              ,[NSNumber numberWithInt:kPhotoBlue]
              ,[NSNumber numberWithInt:kPhotoDecreaseColorDepth]
              ,[NSNumber numberWithInt:kPhotoDecreaseColorDepth]
              ,[NSNumber numberWithInt:kPhotoGreen]
              ,[NSNumber numberWithInt:kPhotoRed]
              ,[NSNumber numberWithInt:kPhotoContrast]
              ,[NSNumber numberWithInt:kPhotoEmboss]
              ,[NSNumber numberWithInt:kPhotoEngrave]
              ,[NSNumber numberWithInt:kPhotoFleaEffect]
              ,[NSNumber numberWithInt:kPhotoGamma]
              ,[NSNumber numberWithInt:kPhotoGaussianBlur]
              ,[NSNumber numberWithInt:kPhotoGreyscale]
              ,[NSNumber numberWithInt:kPhotoColorHole]
              ,[NSNumber numberWithInt:kPhotoHueEffect]
              ,[NSNumber numberWithInt:kPhotoInvertEffect]
              ,[NSNumber numberWithInt:kPhotoMeanRemovalEffect]
              ,[NSNumber numberWithInt:kPhotoNoir]
              ,[NSNumber numberWithInt:kPhotoBoxBlur]
              ,[NSNumber numberWithInt:kPhotoSaturation]
              ,[NSNumber numberWithInt:kPhotoBlue]
              ,[NSNumber numberWithInt:kPhotoGreen]
              ,[NSNumber numberWithInt:kPhotoSepiaToning]
              ,[NSNumber numberWithInt:kPhotoVintage]
              ,[NSNumber numberWithInt:kPhotoVignette]
              ,[NSNumber numberWithInt:kPhotoColorTintTemperature]
              ,[NSNumber numberWithInt:kPhotoFalseColor]
              ,[NSNumber numberWithInt:kPhotoShading]
              ,[NSNumber numberWithInt:kPhotoSmooth]
              ,[NSNumber numberWithInt:kPhotoTint]
              ,[NSNumber numberWithInt:kPhotoBias]];
    
}

- (IBAction)navigateToTagPhoto:(id)sender {

        CompletePhotoViewController *completePhotoViewController  = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"CompletePhotoViewController"];
        completePhotoViewController.image = [imageManager getChangedImage];
        completePhotoViewController.branchName = _branchName;
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:completePhotoViewController];

}

- (IBAction)settingsClicked:(id)sender {
}

- (IBAction)contrastClicked:(id)sender {
}

- (IBAction)brightnessClicked:(id)sender {
    
}
- (void)imageChanged
{
    
}

 - (void)imageChangedWithCurrentFilter
{
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    FilterPhotoCollectionViewCell *cell;
    
    cell = [_filterPhotoCollectionView dequeueReusableCellWithReuseIdentifier:@"FilterPhotoCollectionViewCell" forIndexPath:indexPath];
    [cell.filterPhotoCellImageView setImage:[UIImage imageNamed:[self getFilters][indexPath.row]]];
   
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_queue_t queue = dispatch_queue_create("com.ainsigne.AIBits", NULL);
    if(isUpdated)
    {
        dispatch_async(queue, ^{
            //code to be executed in the background
            isUpdated = NO;
            [imageManager useFilter:[[self getFilterConstants][indexPath.row] intValue]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               [imageManager updateImage];
                isUpdated = YES;
                //code to be executed on the main thread when background task is finished
            });
        });
    }
    else
    {
        NSLog(@" Can't do this yet ");
    }
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self getFilters].count;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    if(_image)
    {
        [_filterPhotoImageView setImage:_image];
    }
    UINib *nib = [UINib nibWithNibName:@"FilterPhotoCollectionViewCell" bundle:nil];
    [_filterPhotoCollectionView registerNib:nib forCellWithReuseIdentifier:@"FilterPhotoCollectionViewCell"];
    UICollectionViewFlowLayout *uiCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    uiCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [_filterPhotoCollectionView setCollectionViewLayout:uiCollectionViewFlowLayout];

    _filterPhotoCollectionView.dataSource = self;
    _filterPhotoCollectionView.delegate = self;
    [_filterPhotoCollectionView reloadData];
    imageManager = [[ImageManager alloc] init];
    [imageManager initManager:self imageView:_filterPhotoImageView];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fragmentInteractionProtocol tabBarFromDiscover:NO];
    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];

    
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
