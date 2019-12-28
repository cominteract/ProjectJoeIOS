//
//  UserInteractionInterface.h
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataPasses.h"
@protocol UserInteractionProtocol <NSObject>
- (void)onChangedName:(NSString *)selectedName;
- (void)onSelected:(JoeUser *)selectedJoe;

@end
@interface UserInteractionInterface : NSObject

@end
