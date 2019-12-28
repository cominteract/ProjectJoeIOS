//
//  PostsCollectionViewCell.h
//  ProjectJoe
//
//  Created by Admin on 3/29/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsCollectionViewCell : UICollectionViewCell
    @property (weak, nonatomic) IBOutlet UILabel *postDetails;
    @property (weak, nonatomic) IBOutlet UIImageView *postImage;
    
@end
