//
//  ImageManager.h
//  FilterIOSProject
//
//  Created by Wylog Mac Mini on 13/03/2018.
//  Copyright © 2018 Wylog Mac Mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Filtrr.h"
#import "ImageInterface.h"
typedef enum {
    kPhotoContrast,
    kPhotoBrightness,
    kPhotoSaturation,

    kPhotoBlack,
    kPhotoEmboss,
    kPhotoEngrave,
    kPhotoColorFilter,
    kPhotoFleaEffect,
    kPhotoDecreaseColorDepth,
    kPhotoGamma,
    kPhotoGaussianBlur,
    kPhotoGreyscale,
    kPhotoHighlightEffect,
    kPhotoHueEffect,
    kPhotoInvertEffect,
    kPhotoMeanRemovalEffect,

    kPhotoShading,
    kPhotoSepiaToning,
    kPhotoSharpen,
    kPhotoSmooth,
    kPhotoTint,
    kPhotoGama,
    kPhotoDark,
    kPhotoBright,
    kPhotoGreen,
    kPhotoBlue,
    kPhotoRed,
    kPhotoGrey,
    kPhotoBump,
    kPhotoNegative,
    kPhotoBlur,
    kPhotoBias,
    kPhotoBoxBlur,
    kPhotoDiscBlur,
    kPhotoMedianFilter,
    kPhotoMotionBlur,
    kPhotoVignette,
    kPhotoVintage,
    kPhotoWarm,
    kPhotoColorMap,
    kPhotoFalseColor,
    kPhotoNoir,
    kPhotoColorClamp,
    kPhotoColorTintTemperature,
    kPhotoColorDroste,
    kPhotoColorHole,
    kPhotoToneCurve
} PhotoFilter;



@interface ImageManager : NSObject
- (void)initManager:(id<ImageProtocol>)imageProtocol imageView:(UIImageView *)imageView_;
- (void)useFilter:(PhotoFilter)photofilter;
- (void)updateImage;
- (void)combineImageTop:(UIImage *)image;
- (void) combineImageWithTextTop:(NSString *)text;
- (void) combineImageWithTextBottom:(NSString *)text;
- (void)combineImageAtTopWith:(UIImage *)image;
- (void)combineImageAtBottomWith:(UIImage *)image;
- (void) combineImageWithTextBottom:(NSString *)text image:(UIImage *)image;
- (void) combineImageWithTextTop:(NSString *)text image:(UIImage *)image;
- (UIImage *)getChangedImage;
@end
