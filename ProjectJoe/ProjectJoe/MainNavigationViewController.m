//
//  MainNavigationViewController.m
//  ProjectJoe
//
//  Created by Wylog Mac Mini on 19/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "MainNavigationViewController.h"
#import "DataPasses.h"
#import "ColorUtilities.h"
@interface MainNavigationViewController ()<FragmentInteractionProtocol>
{
    DataPasses *dataPasses;
    UIStoryboard *uiStoryboard;
    ColorUtilities *colorUtil;
    NSDateFormatter *dateFormatter;
}
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@end

@implementation MainNavigationViewController


- (UIStoryboard *)storyboard
{
    return uiStoryboard;
}

- (NSString *)getCurrentDate
{
    NSDate *todayDate = [NSDate date]; //Get todays date
    if(!dateFormatter)
       dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date.
    [dateFormatter setDateFormat:@"MM-dd-yyyy"]; //Here we can set the format which we need
    NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
    return convertedDateString;
}

- (DataPasses *)onDataPassesRetrieved
{
    return dataPasses;
}

- (void)tabBarFromDiscover:(BOOL)fromDiscover
{
    if(fromDiscover)
        self.tabBar.barTintColor = [colorUtil colorFromHexString:@"#50527A"];
    else
        self.tabBar.barTintColor = [colorUtil colorFromHexString:@"#005B7E"];
}

- (UIColor *)colorFromHex:(NSString *)hexString
{
    return  [colorUtil colorFromHexString:hexString];
}

- (void)showToast:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    int duration = 1; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)onLogout
{
    
}

- (void)onSwitchFrom:(UIViewController *)currentViewController to:(UIViewController *)destinationViewController
{
    [((UINavigationController *)currentViewController) pushViewController:destinationViewController animated:YES];
}

- (void)onSwitchTo:(UIViewController *)destinationViewController
{
    
}

- (void)onTransactionsRetrieved
{
    _isTransactionsRetrieved = YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    colorUtil = [ColorUtilities new];
    dataPasses = [[DataPasses alloc]initWithFragmentInteractionProtocol:self];
    uiStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
