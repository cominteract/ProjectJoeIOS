//
//  ImageInterface.h
//  FilterIOSProject
//
//  Created by Wylog Mac Mini on 13/03/2018.
//  Copyright © 2018 Wylog Mac Mini. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ImageProtocol <NSObject>
- (void)imageChanged;
- (void)imageChangedWithCurrentFilter;
@end
@interface ImageInterface : NSObject

@end
