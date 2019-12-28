//
//  ImageManager.m
//  FilterIOSProject
//
//  Created by Wylog Mac Mini on 13/03/2018.
//  Copyright © 2018 Wylog Mac Mini. All rights reserved.
//

#import "ImageManager.h"
@interface ImageManager()
{
    id<ImageProtocol> imageInterface;
    UIImageView *imageView;
    UIImage *originalImage;
    UIImage *changedImage;
}
@end
@implementation ImageManager

- (void)useFilter:(PhotoFilter)photofilter
{
    switch (photofilter) {
        case kPhotoSepiaToning:
            changedImage = [originalImage sepia];
            break;
        case kPhotoContrast:
            changedImage = [originalImage contrastByFactor:4];
            break;
        case kPhotoBrightness:
            changedImage = [originalImage brightnessByFactor:10];
            break;
        case kPhotoBright:
            changedImage = [originalImage brightnessByFactor:4];
            break;
        case kPhotoHueEffect:
            changedImage = [originalImage hue];
            break;
        case kPhotoSharpen:
            changedImage = [originalImage sharpen];
            break;
        case kPhotoTint:
            changedImage = [originalImage tintWithMinRGB:RGBAMake(2, 2, 2, 90) MaxRGB:RGBAMake(7, 7, 7, 90)];
        case kPhotoGamma:
            changedImage = [originalImage gammaByValue:8];
            break;
        case kPhotoGama:
            changedImage = [originalImage gammaByValue:4];
            break;
        case kPhotoGaussianBlur:
            changedImage = [originalImage gaussianBlur];
            break;
        case kPhotoShading:
            changedImage = [originalImage applyShading];
            break;
        case kPhotoRed:
            changedImage = [originalImage applyRed];
            break;
        case kPhotoGreen:
            changedImage = [originalImage applyGreen];
            break;
        case kPhotoBlue:
            changedImage = [originalImage applyBlue];
            break;
        case kPhotoBlack:
            changedImage = [originalImage applyBlack];
            break;
        case kPhotoGrey:
            changedImage = [originalImage applyGrey];
            break;
        case kPhotoDark:
            changedImage = [originalImage applyDark];
            break;
        case kPhotoBlur:
            changedImage = [originalImage blur];
            break;
        case kPhotoNegative:
            changedImage = [originalImage negative];
            break;
        case kPhotoInvertEffect:
            changedImage = [originalImage negative];
            break;
        case kPhotoBump:
            changedImage = [originalImage bump];
            break;
        case kPhotoBias:
            changedImage = [originalImage biasByFactor:7];
            break;
        case kPhotoSaturation:
            changedImage = [originalImage saturationByFactor:6];
            break;
        case kPhotoGreyscale:
            changedImage = [originalImage grayScale];
            break;
        case kPhotoSmooth:
            changedImage = [originalImage smooth];
            break;
        case kPhotoBoxBlur:
            changedImage = [originalImage boxBlur];
            break;
        case kPhotoDiscBlur:
            changedImage = [originalImage discBlur];
            break;
        case kPhotoMotionBlur:
            changedImage = [originalImage motionBlur];
            break;
        case kPhotoMedianFilter:
            changedImage = [originalImage medianFilter];
            break;
        case kPhotoFleaEffect:
            changedImage = [originalImage fleaEffect];
            break;
            
        case kPhotoDecreaseColorDepth:
            changedImage = [originalImage colorDepth:3];
            break;
        case kPhotoNoir:
            changedImage = [originalImage noir];
            break;
            
        case kPhotoVignette:
            changedImage = [originalImage vignette];
            break;
        case kPhotoVintage:
            changedImage = [originalImage vintage];
            break;
        case kPhotoWarm:
            changedImage = [originalImage warm];
            break;
        case kPhotoColorMap:
            changedImage = [originalImage colorMap];
            break;
        case kPhotoFalseColor:
            changedImage = [originalImage falseColor];
            break;
        case kPhotoColorFilter:
            changedImage = [originalImage colorFilter];
            break;
        case kPhotoMeanRemovalEffect:
            changedImage = [originalImage meanRemoval];
            break;
        case kPhotoColorClamp:
            changedImage = [originalImage colorClamp];
            break;
        case kPhotoColorTintTemperature:
            changedImage = [originalImage colorTemperatureandTint];
            break;
        case kPhotoEmboss:
            changedImage = [originalImage emboss];
            break;
        case kPhotoEngrave:
            changedImage = [originalImage engrave];
            break;
        case kPhotoColorDroste:
            changedImage = [originalImage droste];
            break;
        case kPhotoColorHole:
            changedImage = [originalImage hole];
            break;
        case kPhotoToneCurve:
            changedImage = [originalImage toneCurve];
            break;
        default:
            changedImage = [originalImage tintWithMinRGB:RGBAMake(2, 2, 2, 90) MaxRGB:RGBAMake(7, 7, 7, 90)];
            break;
    }
}

- (void)combineImageAtTopWith:(UIImage *)image
{
    changedImage =  [originalImage imageByCombiningImagewithImageTop:image];
}

- (void)combineImageAtBottomWith:(UIImage *)image
{
    changedImage =  [originalImage imageByCombiningImagewithImageBottom:image];
}

- (void) combineImageWithTextTop:(NSString *)text
{
    changedImage = [originalImage imageByCombiningWithTextTop:text];
}

- (void) combineImageWithTextBottom:(NSString *)text
{
    changedImage = [originalImage imageByCombiningWithTextBottom:text];
}

- (void) combineImageWithTextBottom:(NSString *)text image:(UIImage *)image
{
    changedImage = [originalImage imageByCombiningImageWithTextBottom:text secondImage:image];
}

- (void) combineImageWithTextTop:(NSString *)text image:(UIImage *)image
{
    changedImage = [originalImage imageByCombiningImageWithTextTop:text secondImage:image];
}


- (void)combineImageTop:(UIImage *)image
{
    changedImage = [originalImage overlay:image];
}

- (void)updateImage
{
    [imageView setImage:changedImage];
}

- (void)initManager:(id<ImageProtocol>)imageProtocol imageView:(UIImageView *)imageView_
{
    imageInterface = imageProtocol;
    imageView = imageView_;
    originalImage = imageView.image;
    
}

- (void)sepia
{
    UIImage * newImage = originalImage;
    
    [newImage applyFiltrr:^RGBA (int r, int g, int b, int a) {
        RGBA retVal;
        
        retVal.red = [newImage safe:(r * 0.393) + (g * 0.769) + (b * 0.189)];
        retVal.green = [newImage safe:(r * 0.349) + (g * 0.686) + (b * 0.168)];
        retVal.blue = [newImage safe:(r * 0.272) + (g * 0.534) + (b * 0.131)];
        retVal.alpha = a;
        return retVal;
    }];
    [imageView setImage:newImage];
    
}

- (UIImage *)getChangedImage{
    return changedImage;
}

@end
