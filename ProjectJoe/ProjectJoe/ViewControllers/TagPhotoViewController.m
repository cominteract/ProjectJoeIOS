//
//  TagPhotoViewController.m
//  ProjectJoe
//
//  Created by andre insigne on 21/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "TagPhotoViewController.h"
#import "CompletePhotoViewController.h"
#import "DataPasses.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CameraManager.h"
#import "FilterPhotoViewController.h"
#import "ImageManager.h"
@interface TagPhotoViewController ()<UITableViewDelegate,UITableViewDataSource,CameraProtocol,ImageProtocol>
{
    NSMutableArray <Branch *> *branchList;
    CameraManager *cameraManager;
    ImageManager *imageManager;
}
@property (weak, nonatomic) IBOutlet UITableView *tagPhotoTableView;
@property (weak, nonatomic) IBOutlet UIImageView *tagPhotoImageView;

@end

@implementation TagPhotoViewController
NSString *branchName;

- (void)cameraPictureTakenSuccess{
    
}
- (void)cameraPictureTakenFailed
{
    
}
- (void)cameraPictureTakenError{
        
}
- (void)cameraRecordSuccess{
        
}
- (void)cameraRecordFailed{
        
}
- (void)cameraRecordError
{
        
}
- (void)imageChanged
{
    
}

 - (void)imageChangedWithCurrentFilter
{
    
}

- (void)selectedPhotoFromLibrary:(UIImage *)image
{
    [_tagPhotoImageView setImage:image];
    imageManager = [[ImageManager alloc] init];
    [imageManager initManager:self imageView:_tagPhotoImageView];
    
}
- (void)selectedVideoUrlFromLibrary:(NSURL *)videoUrl
{
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.detailTextLabel.text = branchList[indexPath.row].branchName;
    cell.textLabel.text = branchList[indexPath.row].branchAddress;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [self.fragmentInteractionProtocol colorFromHex:@"#2A6370"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    branchName = branchList[indexPath.row].branchAddress;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager loadImageWithURL:[NSURL URLWithString:branchList[indexPath.row].branchMerchant.merchantImage]
                      options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                          
                      } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                          dispatch_queue_t queue = dispatch_queue_create("com.ainsigne.AIBits", NULL);
                          dispatch_async(queue, ^{
                              //code to be executed in the background
                              [imageManager combineImageWithTextBottom:branchList[indexPath.row].branchMerchant.merchantCaption image:image];
                              //[imageManager combineImageWithTextBottom:branchList[indexPath.row].branchMerchant.merchantCaption];
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [imageManager updateImage];
                                  FilterPhotoViewController *filterPhotoViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"FilterPhotoViewController"];
                                  filterPhotoViewController.image = [imageManager getChangedImage];
                                  filterPhotoViewController.branchName = branchName;
                                  [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:filterPhotoViewController];
                                  //code to be executed on the main thread when background task is finished
                              });
                          });
                      }];
    

//    CompletePhotoViewController *completePhotoViewController  = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"CompletePhotoViewController"];
//    [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:completePhotoViewController];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return branchList.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    branchList = [self.fragmentInteractionProtocol onDataPassesRetrieved].branchList;
    _tagPhotoTableView.dataSource = self;
    _tagPhotoTableView.delegate = self;
   
    [_tagPhotoTableView reloadData];
    cameraManager = [[CameraManager alloc]initWith:self vc:self];
    [cameraManager captureImage];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fragmentInteractionProtocol tabBarFromDiscover:NO];
    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];

    
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
