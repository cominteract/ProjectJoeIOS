//
//  DiscoverLockedTableViewCell.h
//  ProjectJoe
//
//  Created by Wylog Mac Mini on 19/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverLockedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *discoverLockedImage;

@property (weak, nonatomic) IBOutlet UILabel *discoverLockedTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *discoverDeadlineLabel;

@property (weak, nonatomic) IBOutlet UILabel *discoverDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *discoverClaimsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *discoverLockedUnlockImage;








@end
