//
//  PhotosCheckInTableViewCell.h
//  ProjectJoe
//
//  Created by Wylog Mac Mini on 19/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosCheckInTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *photoCheckinNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoCheckinPostImage;
@property (weak, nonatomic) IBOutlet UILabel *photoCheckinAddressLabel;

@end
