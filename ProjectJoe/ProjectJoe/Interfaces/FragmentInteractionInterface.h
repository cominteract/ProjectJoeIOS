//
//  FragmentInteractionInterface.h
//  ProjectJoe
//
//  Created by andre insigne on 21/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataPasses;

@protocol FragmentInteractionProtocol <NSObject>
- (void)onSwitchTo:(UIViewController *)destinationViewController;
- (void)onSwitchFrom:(UIViewController *)currentViewController to:(UIViewController *)destinationViewController;
- (DataPasses *)onDataPassesRetrieved;
- (void)onTransactionsRetrieved;
- (void)onLogout;
- (UIStoryboard *)storyboard;
- (void)showToast:(NSString *)message;
- (void)tabBarFromDiscover:(BOOL)fromDiscover;
- (UIColor *)colorFromHex:(NSString *)hexString;
- (NSString *)getCurrentDate;
@end
@interface FragmentInteractionInterface : NSObject

@end
