//
//  PassesTableViewCell.h
//  ProjectJoe
//
//  Created by Wylog Mac Mini on 20/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *passImage;
@property (weak, nonatomic) IBOutlet UILabel *passDescription;
@property (weak, nonatomic) IBOutlet UILabel *passTitle;
@property (weak, nonatomic) IBOutlet UILabel *passClaims;

@property (weak, nonatomic) IBOutlet UILabel *passDuration;



@end
