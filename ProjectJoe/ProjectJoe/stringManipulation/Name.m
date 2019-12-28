//
//  Name.m
//  AIBits
//
//  Created by andre insigne on 05/12/2017.
//  Copyright © 2017 andre insigne. All rights reserved.
//

#import "Name.h"

@implementation Name
- (id)initWith:(Gender )gendr first:(NSString *)first last:(NSString *)last
{
    self = [super init];
    if (self)
    {
        self.firstName = first;
        self.lastName = last;
        self.gender = gendr;
        // Superclass successfully initialized.
    }
    return self;
}
@end
