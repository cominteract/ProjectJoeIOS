//
//  UserLeaderboardTableViewCell.h
//  ProjectJoe
//
//  Created by Admin on 3/29/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLeaderboardTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UIImageView *userLeaderboardImage;
    @property (weak, nonatomic) IBOutlet UILabel *userLeaderboardName;
    @property (weak, nonatomic) IBOutlet UILabel *userLeaderboardPoints;
    
@end
