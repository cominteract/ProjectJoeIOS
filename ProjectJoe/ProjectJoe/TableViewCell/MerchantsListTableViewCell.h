//
//  MerchantsListTableViewCell.h
//  ProjectJoe
//
//  Created by andre insigne on 21/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantsListTableViewCell : UITableViewCell

    @property (weak, nonatomic) IBOutlet UIImageView *merchantImage;
    @property (weak, nonatomic) IBOutlet UILabel *merchantTitle;
    @property (weak, nonatomic) IBOutlet UILabel *merchantDetails;
    
@end
