//
//  DataPasses.m
//  ProjectJoe
//
//  Created by andre insigne on 20/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "DataPasses.h"

@implementation DataPasses
int maxpass = 40;
NSDateFormatter *formatter;

NSMutableDictionary *passDetails;
NSMutableDictionary *passNews;
NSMutableDictionary *passAds;

    - (instancetype)initWithFragmentInteractionProtocol:(id<FragmentInteractionProtocol>)protocol{
    self = [super init];
    if(self)
    {
        _availablePasses = [NSMutableArray new];
        _availablePostList = [NSMutableArray new];
        _currentPassList = [NSMutableArray new];
        _currentPostList = [NSMutableArray new];
        _allTransactionList = [NSMutableArray new];
        _merchantList = [NSMutableArray new];
        _branchList = [NSMutableArray new];
        _joeUserList = [NSMutableArray new];
        _nearbyAvailablePasses = [NSMutableArray new];
        _trendingPasses = [NSMutableArray new];
        _fragmentInteractionProtocol = protocol;
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
        
    }
    return self;
}



- (TransactionType )getTransactionType:(int)identifier
{
    if(identifier == 0)
        return TransactionGivingPoints;
    else if(identifier == 1)
        return TransactionUsingPoints;
    else if(identifier == 2)
        return TransactionReceivingPoints;
    else if(identifier == 3)
        return TransactionEarningPoints;
    else if(identifier == 4)
        return TransactionReceivingPass;
    else if(identifier == 5)
        return TransactionGivingPass;
    else if(identifier == 6)
        return TransactionPost;
    else
        return TransactionUsingPass;
}
- (int)randInt:(int)min max:(int)max
{
    return (min + arc4random_uniform(max - min + 1));
}
- (Transaction *)getTransaction :(int)identifier forCurrentUser:(BOOL)forCurrentUser
{
    TransactionType ttype = [self getTransactionType:identifier];
    Transaction *transaction;
    JoeUser *joeUser;
    if(forCurrentUser)
        joeUser = self.joeUser;
    else
        joeUser = _joeUserList[[self randInt:0 max:_joeUserList.count-1]];
    if(ttype == TransactionGivingPass || ttype == TransactionReceivingPass || ttype == TransactionUsingPass)
    {
        transaction = [[Transaction alloc]initWith:_joeUserList[[self randInt:0 max:_joeUserList.count-1]] transactionDate:[formatter stringFromDate:[self getRandomDate]] transactionPass:_availablePasses[[self randInt:0 max:_availablePasses.count-1]] transactionType:ttype];
        [transaction setOtherTransactionUser:joeUser];
    }
    else if(ttype == TransactionReceivingPoints || ttype == TransactionGivingPoints || ttype == TransactionUsingPoints || ttype == TransactionEarningPoints)
    {
        transaction = [[Transaction alloc]initWith:_joeUserList[[self randInt:0 max:_joeUserList.count-1]] transactionDate:[formatter stringFromDate:[self getRandomDate]] transactionPoints:[self randInt:2 max:100] transactionType:ttype];
        [transaction setOtherTransactionUser:joeUser];
    }
    else
    {
        transaction = [[Transaction alloc]initWith:_joeUserList[[self randInt:0 max:_joeUserList.count-1]] transactionDate:[formatter stringFromDate:[self getRandomDate]] transactionPost:_availablePostList[[self randInt:0 max:_availablePostList.count-1]] transactionType:ttype];
        [transaction setOtherTransactionUser:joeUser];
    }
    return transaction;
}

- (NSDate *)getRandomDate
{
    NSDate *now = [NSDate date];
    NSDate *monthsAgo = [now dateByAddingTimeInterval:-50*24*60*60];
    return [self getSubtractDate:monthsAgo end:now];
}

- (NSDate *)getSubtractDate:(NSDate *)start end:(NSDate *)end
{
    NSTimeInterval timeBetweenDates = [end timeIntervalSinceDate:start];
    NSTimeInterval randomInterval = ((NSTimeInterval)arc4random() / 0x100000000) * timeBetweenDates;
    NSDate *randomDate = [start dateByAddingTimeInterval:randomInterval];
    return randomDate;
}

- (NSMutableArray <JoeUser * > *) getUsersListFromMerchant:(Merchant *)merchant
{
    NSMutableArray<JoeUser *> *joeUserList = [NSMutableArray new];
    for(JoeUser *joeUser in self.joeUserList)
    {
        for(Points *points in joeUser.pointsList)
        {
            if([points.pointsMerchant.merchantName.lowercaseString isEqualToString:merchant.merchantName.lowercaseString] && ![joeUserList containsObject:joeUser])
            {
                joeUser.merchantPoints = points.point;
                [joeUserList addObject:joeUser];
            }
        }
    }
    return joeUserList;
}

- (NSMutableArray<GoogleMapLocation *> *)getLocationsFromMerchant:(Merchant *)merchant
    {
        NSMutableArray<GoogleMapLocation *> *locations = [NSMutableArray new];
        for(GoogleMapLocation *googleMapLocation in self.nearestGoogleMapLocationList)
        {
            if([googleMapLocation.locationName.lowercaseString isEqualToString:merchant.merchantName.lowercaseString])
            {
                [locations addObject:   googleMapLocation];
            }
        }
        return locations;
    }
    
- (NSMutableArray<Post *> *)getPostsFromMerchant:(Merchant *)merchant
{
    NSMutableArray<Post *> *posts = [NSMutableArray new];
    for(Post *post in self.availablePostList)
    {
        if(post.postBranch.branchMerchant!=nil && [post.postBranch.branchMerchant.merchantName.lowercaseString isEqualToString:merchant.merchantName.lowercaseString])
        {
            [posts addObject:post];
        }
    }
    return posts;
}

- (NSMutableArray<Pass *> *)getPassesFromMerchant:(Merchant *)merchant
{
    NSMutableArray<Pass *> *passes = [NSMutableArray new];
    for(Pass *pass in self.availablePasses)
    {
        if(pass.passMerchant!=nil && [pass.passMerchant.merchantName.lowercaseString isEqualToString:merchant.merchantName.lowercaseString])
        {
            [passes addObject:pass];
        }
    }
    return passes;
}

- (NSMutableArray<Branch *> *)getBranchesFromMerchant:(Merchant *)merchant
{
    NSMutableArray<Branch *> *branches = [NSMutableArray new];
    for(Branch *branch in self.branchList)
    {
        if(branch.branchMerchant!=nil && [branch.branchMerchant.merchantName.lowercaseString isEqualToString:merchant.merchantName.lowercaseString])
        {
            [branches addObject:branch];
        }
    }
    return branches;
}

- (NSMutableArray<Post *> *)getAvailablePostList
{
    if(_availablePostList.count < 1 && [self getBranchList].count > 0)
    {
            for(Branch *branch in _branchList)
            {
                Post *post = [Post new];
                post.postBranch = branch;
                post.postCaption = [NSString stringWithFormat:@" Here at %@",branch.branchName];
                post.postDate = [formatter stringFromDate:[self getRandomDate]];
                post.postDetails = [NSString stringWithFormat:@" Taken at %@ with %d points by %@",branch.branchName, post.postPoints,_joeUser.fullName];
                if(branch.branchMerchant!=nil)
                    [_availablePostList addObject:post];
            }
            [self getJoeUserList];
            _joeUser.friendList = [NSMutableArray new];
           
            for(int n = 0;n<6;n++)
            {
                JoeUser *joeUser = _joeUserList[[self randInt:0 max:_joeUserList.count-1] ];
                [joeUser.friendList addObject:joeUser];
                
            }
            _joeUser.transactionList = [NSMutableArray new];
            for(int n = 0;n<500;n++)
            {
                Transaction *transaction = [self getTransaction:[self randInt:0 max:7] forCurrentUser:false];
                [_allTransactionList addObject:transaction];
                if((transaction.transactionJoeUserGiver!=nil && [transaction.transactionJoeUserGiver isEqual:_joeUser]) ||
                   (transaction.transactionJoeUserReceiver!=nil && [transaction.transactionJoeUserReceiver isEqual:_joeUser]))
                {
                    [_joeUser.transactionList addObject:transaction];
                }
            }
            for(JoeUser *joeUser in _joeUserList)
            {
                for(int n = 0;n< 8;n++)
                {
                    [joeUser.friendList addObject:_joeUserList[[self randInt:0 max:_joeUserList.count-1]]];
                }
                joeUser.transactionList = [self getTransactionFromUser:joeUser];
            }
    }
    return _availablePostList;
}

- (void)setBranchListFrom:(NSMutableArray<GoogleMapLocation *> *)googleMapLocationList
{
    if(_branchList.count<1)
    {
        for(GoogleMapLocation *googleMapLocation in googleMapLocationList)
        {
            Branch *branch = [Branch new];
            branch.branchName = googleMapLocation.locationName;
            branch.branchAddress = googleMapLocation.locationAddress;
            branch.branchContact = googleMapLocation.locationDesc;
            branch.branchDetails = @"Shaking in baking";
            branch.googleMapLocation = googleMapLocation;
            for(Merchant *merchant in _merchantList)
            {
                if([googleMapLocation.locationName.lowercaseString containsString:merchant.merchantGeoName.lowercaseString] )
                {
                    branch.branchMerchant = merchant;
                    branch.branchTaggedPost = [NSMutableArray new];
                    [_branchList addObject:branch];
                    break;
                }
            }
        }
        [self getAvailablePostList];
        _isRetrieved = YES;
        [_fragmentInteractionProtocol onTransactionsRetrieved];
    }
}


- (NSMutableArray <Pass *> *) getCurrentPassList
{
    if(_currentPassList.count<1)
    {
        for(Pass *pass in [self getAvailablePasses])
        {
            if(_currentPassList.count<4 && ([pass.passType isEqualToString:@"DEAL"] || [pass.passType isEqualToString:@"COUPON"] || [pass.passType isEqualToString:@"FREE"] ))
            {
                
                [_currentPassList addObject:pass];
                
            }
            else if(_currentPassList.count==4)
                break;
        }
        for(Pass *pass in _currentPassList)
        {
            if([[self getAvailablePasses] containsObject: pass])
            [[self getAvailablePasses] removeObject:pass];
        }
    }
    return _currentPassList;
}

- (NSMutableArray <Post *> *)getCurrentPostList
{
    return _currentPostList;
}
    
- (NSMutableArray<Pass *> *)getAvailablePassesFrom:(NSString *)category
{
    NSMutableArray<Pass *> *passes = [NSMutableArray new];
    for(Pass *pass in [self getAvailablePasses])
    {
        if([pass.passMerchant.merchantCategory isEqualToString:category])
            [passes addObject:pass];
    }
    return passes;
}

- (NSMutableArray<Pass *> *)getAvailablePasses
{
    if(_availablePasses.count < 1)
    {
        for(int n = 0;n<maxpass;n++)
        {
            Pass *pass = [Pass new];
            pass.passMerchant = [self getMerchantList][[self randInt:0 max:_merchantList.count-1]];
            pass.passPrice = [self randInt:1 max:500];
            pass.passType = [self passType][[self randInt:0 max:[self passType].count-1]];
            pass.passDuration = [NSString stringWithFormat:@" %d days left",[self randInt:1 max:7]];
            pass.passClaimCount = [self randInt:1 max:99];
            pass.passClaims = [NSString stringWithFormat:@" %d claims ",pass.passClaimCount];
            pass.passPoints = [Points new];
            pass.passPoints.pointsMerchant = pass.passMerchant;
            pass.passPoints.point = [self randInt:1 max:100];
            pass.isLocked = NO;
            if(pass.passType==[self passType][5])
            {
                pass.passDescription = [self getPassAds][pass.passMerchant.merchantName][0];
                pass.passImage = [self getPassAds][pass.passMerchant.merchantName][1];
                pass.passLink = [self getPassAds][pass.passMerchant.merchantName][2];
                
                
            }
            else if(pass.passType==[self passType][4])
            {
                pass.passDescription = [self getPassNews][pass.passMerchant.merchantName][0];
                pass.passImage = [self getPassNews][pass.passMerchant.merchantName][1];
                pass.passLink = [self getPassNews][pass.passMerchant.merchantName][2];
                
            }
            else {
                int lockNumber = [self randInt:0 max:2];
                pass.isLocked = NO;
                if(lockNumber<1)
                    pass.isLocked = YES;

                if(pass.isLocked)
                    pass.lockType = ((LockType )[self passLock][[self randInt:0 max:2]]);
                pass.passDescription = [self getPassDetails][pass.passMerchant.merchantName][[self randInt:0 max:(int)((NSArray *)[self getPassDetails][pass.passMerchant.merchantName]).count -1] ];
                pass.passImage = pass.passMerchant.merchantImage;
    
            }
            if([self randInt:0 max:5]<1)
                [_trendingPasses addObject:pass];
            [_availablePasses addObject:pass];
            
        }
    }
    return _availablePasses;
}

- (void)addTransaction:(Transaction *)transaction
{
    if(_allTransactionList!=nil && _joeUser.transactionList!=nil)
    {
        [_allTransactionList addObject:transaction];
        [_joeUser.transactionList addObject:transaction];
    }
}




- (NSMutableArray<Merchant *> *)getMerchantList
{
    if(_merchantList.count<1)
    {
        for(int n = 0;n<[self merchantNames].count;n++)
        {
            Merchant *merchant = [Merchant new];
            merchant.merchantName = [self merchantNames][n];
            merchant.merchantImage = [self merchantLogos][n];
            merchant.merchantCategory = [self merchantCategories][n];
            merchant.merchantDetails = [self merchantDetails][n];
            merchant.merchantCaption = [self merchantCaptions][n];
            merchant.merchantImageResource = [self merchantResource][n];
            merchant.merchantGeoType = [self merchantGeotypes][n];
            merchant.merchantGeoName = [self merchantGeoNames][n];
            merchant.merchantContact = [self merchantContacts][n];
            [_merchantList addObject:merchant];
        }
    }
    return _merchantList;
}

- (JoeUser *)currentJoeUser
{
    if(!_joeUser)
    {
        _joeUser = [JoeUser new];
        _joeUser.email = @"cominteract@gmail.com";
        _joeUser.fullName = @"Andre Insigne";
        _joeUser.userName = @"cominteract@gmail.com";
        _joeUser.birthday = [formatter stringFromDate:[self getRandomDate]];
        _joeUser.facebook = @"https://www.facebook.com/dre.noctis";
        _joeUser.phone = @"2939128398";
//        GoogleMapLocation googleMapLocation = new GoogleMapLocation().locationAddress("Random Address")
//        .locationDesc(joeUser.phone).locationName("House")
//        .locationLatitude(randDouble(14.7,15.7)).locationLongitude(randDouble(120.0,121.5))
//        .locationIcon(R.drawable.photo_marker_button);
        GoogleMapLocation *googleMapLocation = [GoogleMapLocation new];
        googleMapLocation.locationAddress = @"Random Address";
        googleMapLocation.locationDesc = @"joeUser.phone";
        googleMapLocation.locationName = @"House";
        googleMapLocation.locationLatitude = 14.543847;
        googleMapLocation.locationLongitude = 120.543847;
        googleMapLocation.locationIcon = @"photo_marker_button";
        
        _joeUser.googleMapLocation = googleMapLocation;
        _joeUser.currentPoints = [self randInt:100 max:5000];
        _joeUser.earnedPoints = [self randInt:0 max:500];
        _joeUser.givenPoints = [self randInt:0 max:500];
        _joeUser.receivedPoints = [self randInt:0 max:500];
        _joeUser.usedPoints = [self randInt:0 max:500];
        _joeUser.image = @"https://yt3.ggpht.com/-jMRGITTAJ20/AAAAAAAAAAI/AAAAAAAAAAA/F21oQNPPOE4/s108-c-k-no-mo-rj-c0xffffff/photo.jpg";
    }
    return _joeUser;
}

- (NSMutableArray<Branch *> *)getBranchList
{
    return _branchList;
}



- (NSMutableArray<JoeUser *> *)getJoeUserList
{
    if(_joeUserList.count < 1)
    {
        for(int n = 0;n<[self userNames].count;n++)
        {
            JoeUser *joeUser = [JoeUser new];
            joeUser.fullName = [self userFullNames][n];
            joeUser.userName = [self userNames][n];
            joeUser.birthday = [formatter stringFromDate:[self getRandomDate]];
            joeUser.facebook = @"https://www.facebook.com/dre.noctis";
            joeUser.phone = @"09167515690";
            GoogleMapLocation *googleMapLocation = [GoogleMapLocation new];
            googleMapLocation.locationAddress = @"Random Address";
            googleMapLocation.locationDesc = @"joeUser.phone";
            googleMapLocation.locationName = @"House";
            googleMapLocation.locationLatitude = [self randDouble:14.7 max:15.7];
            googleMapLocation.locationLongitude = [self randDouble:120.0 max:121.5];
            googleMapLocation.locationIcon = @"photo_marker_button";
            joeUser.googleMapLocation = googleMapLocation;
            joeUser.image = [self userPhotos][n];
            joeUser.currentPoints = [self randInt:100 max:5000];
            joeUser.postList = [NSMutableArray new];
            joeUser.passList = [NSMutableArray new];
            joeUser.pointsList = [NSMutableArray new];
            joeUser.friendList = [NSMutableArray new];
            joeUser.transactionList = [NSMutableArray new];
            joeUser.earnedPoints = [self randInt:0 max:500];
            joeUser.givenPoints = [self randInt:0 max:500];
            joeUser.usedPoints = [self randInt:0 max:500];
            joeUser.receivedPoints = [self randInt:0 max:500];
            for(int y = 0;y< joeUser.currentPoints/100;y++)
            {
                Pass *joePass = [self getAvailablePasses][[self randInt:0 max:[self getAvailablePasses].count -1]];
                [joeUser.passList addObject:joePass];
                [joeUser.pointsList addObject:joePass.passPoints];
                int rand = [self randInt:0 max:[self getAvailablePostList].count-1];
                _availablePostList[rand].postUser = joeUser;
                _availablePostList[rand].postImage = joeUser.image;
                [joeUser.postList addObject:_availablePostList[rand]];
            }
            [_joeUserList addObject:joeUser];
        }
            for(Post *post in _availablePostList)
            {
                if(post.postUser == nil)
                {
                    int rand = [self randInt:0 max:_joeUserList.count-1];
                    post.postUser = _joeUserList[rand];
                    [_joeUserList[rand].postList addObject:post];
                }
            }
            [self currentJoeUser];
            _joeUser.passList = [self getCurrentPassList];
            _joeUser.pointsList = [NSMutableArray new];
            _joeUser.postList = [NSMutableArray new];
            for(int y = 0;y<_joeUser.currentPoints/100;y++)
            {
                Pass *joePass = [self getAvailablePasses][[self randInt:0 max:[self getAvailablePasses].count - 1]];
                [_joeUser.pointsList addObject:joePass.passPoints];
                int rand = [self randInt:0 max:[self getAvailablePostList].count-1];
                _availablePostList[rand].postUser = _joeUser;
                [_joeUser.postList addObject:_availablePostList[rand]];
            }
            [_joeUserList addObject:_joeUser];
            for(Merchant *merchant in [self getMerchantList])
            {
                merchant.merchantJoePassList = [NSMutableArray new];
                merchant.merchantPostList = [NSMutableArray new];
                merchant.merchantBranchesList = [NSMutableArray new];
                merchant.merchantJoeUserList = [NSMutableArray new];
                for(Pass *pass in [self getAvailablePasses])
                {
                    if([pass.passMerchant isEqual:merchant])
                    {
                        [merchant.merchantJoePassList addObject:pass];
                    }
                }
                for(Post *post in [self getAvailablePostList])
                {
                    if([post.postBranch.branchMerchant isEqual:merchant])
                    {
                        [merchant.merchantPostList addObject:post];
                        if(![merchant.merchantJoeUserList containsObject:post.postUser])
                            [merchant.merchantJoeUserList addObject:post.postUser];
                    }
                }
                for(Branch *branch in [self getBranchList])
                {
                    if([branch.branchMerchant isEqual:merchant])
                    {
                        [merchant.merchantBranchesList addObject:branch];
                    }
                }
            
            
        }
        
    }
    return _joeUserList;
}

- (double)randDouble:(double)min max:(double)max
{
    double diff = max - min;
    return (((double) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + min;
}

- (NSMutableArray<Transaction *> *)getTransactionFromUser:(JoeUser *)joeUser
{
    NSMutableArray<Transaction *> *transactions = [NSMutableArray new];
    for(Transaction *transaction in _allTransactionList)
    {
        if((transaction.transactionJoeUserGiver!=nil &&
            [transaction.transactionJoeUserGiver isEqual:joeUser])
            || (transaction.transactionJoeUserReceiver!=nil && [transaction.transactionJoeUserReceiver isEqual:joeUser]))
           [transactions addObject:transaction];
    }
    return transactions;
}
- (NSArray *)passType
{
    return @[@"DEAL",@"COUPON",@"FREE",@"CHALLENGE",@"NEWS",@"AD"];
}

- (NSArray *)userPhotos
{
    return @[ @"https://randomuser.me/api/portraits/med/women/6.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/22.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/25.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/47.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/95.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/27.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/14.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/87.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/89.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/72.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/53.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/68.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/53.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/42.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/30.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/46.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/70.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/39.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/33.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/29.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/40.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/26.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/86.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/32.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/69.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/27.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/50.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/93.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/70.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/36.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/30.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/49.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/62.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/57.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/85.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/34.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/47.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/37.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/92.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/76.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/49.jpg"
              ,@"https://randomuser.me/api/portraits/med/women/91.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/24.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/24.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/51.jpg"
              ,@"https://randomuser.me/api/portraits/med/men/10.jpg"];
}

- (NSArray *)userEmail
{
    return @[@"ariane.scott@example.com"
             ,@"jen.dunn@example.com"
             ,@"caroline.hansen@example.com"
             ,@"mason.price@example.com"
             ,@"same.may@example.com"
             ,@"eloïse.clement@example.com"
             ,@"aymeric.sanchez@example.com"
             ,@"maria.madsen@example.com"
             ,@"ayhan.vlemmix@example.com"
             ,@"claude.riley@example.com"
             ,@"borre.tolenaars@example.com"
             ,@"carmen.byrd@example.com"
             ,@"juliette.wilson@example.com"
             ,@"julia.lord@example.com"
             ,@"bilge.denboef@example.com"
             ,@"leonaura.aragão@example.com"
             ,@"mustafa.akgül@example.com"
             ,@"carlo.leeflang@example.com"
             ,@"batur.bolatlı@example.com"
             ,@"morgane.michel@example.com"
             ,@"vicki.franklin@example.com"
             ,@"pinja.sakala@example.com"
             ,@"mia.thomas@example.com"
             ,@"nicolas.martin@example.com"
             ,@"wilma.schmitz@example.com"
             ,@"topias.peura@example.com"
             ,@"andreas.nielsen@example.com"
             ,@"aitor.diez@example.com"
             ,@"stella.arnaud@example.com"
             ,@"oğuzhan.yeşilkaya@example.com"
             ,@"becky.george@example.com"
             ,@"cameron.day@example.com"
             ,@"ewen.lemoine@example.com"
             ,@"ronald.kelley@example.com"
             ,@"gregorio.marin@example.com"
             ,@"ernest.hall@example.com"
             ,@"gilbert.rodriquez@example.com"
             ,@"victor.gauthier@example.com"
             ,@"coline.denis@example.com"
             ,@"holly.kumar@example.com"
             ,@"kuzey.karaer@example.com"
             ,@"eva.lynch@example.com"
             ,@"jaime.cortes@example.com"
             ,@"taoufik.rosenberg@example.com"
             ,@"russell.banks@example.com"
             ,@"micah.geurten@example.com"];
}

- (NSArray *)userFullNames
{
    return @[@"mrs ariane scott"
             ,@"ms jen dunn"
             ,@"ms caroline hansen"
             ,@"mr mason price"
             ,@"mr same may"
             ,@"ms eloise clement"
             ,@"mr aymeric sanchez"
             ,@"mrs maria madsen"
             ,@"mr ayhan vlemmix"
             ,@"mr claude riley"
             ,@"mr borre tolenaars"
             ,@"ms carmen byrd"
             ,@"ms juliette wilson"
             ,@"mrs julia lord"
             ,@"mrs bilge den boef"
             ,@"ms leonaura aragao"
             ,@"mr mustafa akgul"
             ,@"mr carlo leeflang"
             ,@"mr batur bolatli"
             ,@"ms morgane michel"
             ,@"ms vicki franklin"
             ,@"ms pinja sakala"
             ,@"mrs mia thomas"
             ,@"mr nicolas martin"
             ,@"ms wilma schmitz"
             ,@"mr topias peura"
             ,@"mr andreas nielsen"
             ,@"mr aitor diez"
             ,@"mrs stella arnaud"
             ,@"mr oguzhan yeşilkaya"
             ,@"mrs becky george"
             ,@"mr cameron day"
             ,@"mr ewen lemoine"
             ,@"mr ronald kelley"
             ,@"mr gregorio marin"
             ,@"mr ernest hall"
             ,@"mr gilbert rodriguez"
             ,@"mr victor gauthier"
             ,@"ms coline denis"
             ,@"mrs holly kumar"
             ,@"mr kuzey karaer"
             ,@"ms eva lynch"
             ,@"mr jaime cortes"
             ,@"mr taoufik rosenberg"
             ,@"mr russell banks"
             ,@"mr micah geurten"];
}

- (NSArray *)userNames
{
    return @[ @"biglion848"
              ,@"purplebutterfly355"
              ,@"organictiger653"
              ,@"ticklishrabbit682"
              ,@"yellowfish547"
              ,@"redbear998"
              ,@"ticklishdog395"
              ,@"yellowrabbit911"
              ,@"blueelephant326"
              ,@"tinykoala433"
              ,@"yellowpanda168"
              ,@"whitepanda924"
              ,@"blackbear723"
              ,@"smallbear637"
              ,@"bigduck549"
              ,@"redrabbit491"
              ,@"greenbear131"
              ,@"goldenpanda177"
              ,@"greenbird755"
              ,@"greenfish500"
              ,@"yellowelephant335"
              ,@"biglion771"
              ,@"bluepanda322"
              ,@"blackbear464"
              ,@"tinymeercat470"
              ,@"whitepanda158"
              ,@"lazyfrog151"
              ,@"crazyfish646"
              ,@"blackkoala749"
              ,@"ticklishostrich356"
              ,@"goldenswan883"
              ,@"greenladybug550"
              ,@"smallsnake385"
              ,@"organiclion784"
              ,@"greenbutterfly641"
              ,@"ticklishgorilla690"
              ,@"reddog435"
              ,@"organicrabbit704"
              ,@"greendog921"
              ,@"blackfish168"
              ,@"purpledog586"
              ,@"tinybear524"
              ,@"blackdog563"
              ,@"brownmeercat206"
              ,@"silverbutterfly420"];
}

- (NSArray *)merchantContacts
{
    return @[@"09175874654",@"87-000" ,@"86-236",@"55-555",@"77-777",@"1800-1888-6453",@"1800-1888-6453",@"+6320844",@"0203-0141818",@"857-7240",@"+632-7020-888",@"+632-637-2879",@"+632-374-2442"];
}

- (NSArray<NSNumber *> *) passLock
{
    return @[[NSNumber numberWithInt:LockRedeem],[NSNumber numberWithInt:LockSurvey],[NSNumber numberWithInt:LockSurvey]];
}

- (NSArray *)isLocked
{
    return @[@NO,@YES,@NO];
}

- (NSArray *)merchantResource
{
    return @[@"guess",@"jollibee",@"mcdo",@"greenwich",@"shakeys",@"nike",@"jordan",@"etude",@"easports",@"honda",@"cebupacific",@"mercurydrug",@"papemelroti"];
}

- (NSArray *)merchantNames
{
    return @[@"GUESS",@"JOLLIBEE",@"MCDO",@"GREENWICH",@"SHAKEYS",@"NIKE",@"JORDAN",@"ETUDE",@"EA",@"HONDA",@"CEBU PACIFIC",@"MERCURY DRUG",@"PAPEMELROTI"];
}

- (NSArray *)merchantGeoNames
{
    return @[@"GUESS",@"JOLLIBEE",@"MCDO",@"GREENWICH",@"SHAKEYS",@"NIKE",@"JORDAN",@"ETUDE",@"DATA BLITZ,GAMEONE",@"HONDA",@"CEBU PACIFIC",@"MERCURY DRUG",@"PAPEMELROTI"];
}

- (NSArray *)merchantGeotypes
{
    return @[@"clothing_store",@"food",@"food",@"food",@"food",@"shoe_store",@"shoe_store",@"store",@"store",@"car_dealer",@"airport",@"pharmacy",@"store"];
}

- (NSArray *)merchantCategories
{
    return @[@"Lifestyle" ,@"Food",@"Food",@"Food",@"Food" ,@"Lifestyle",@"Lifestyle",@"Fashion",@"Entertainment",@"Cars",@"Travel",@"Health",@"Arts"];
}
- (NSArray *)merchantCaptions
{
    return @[@"Uncompromising Quality",@"Bida ang sarap",@"Love ko to!",@"Beyond Every Pizza Box",@"Fun, Family, Pizza",@"Just do it",@"Do whatever it takes",@"Love is etude, Love is pink",@"It's in the game",@"The power of dreams",@"Change is in the air",@"Nakasisiguro gamot ay laging bago",@"hands to work, hearts to God"];
}

- (NSArray *)merchantLogos
{
    return @[@"https://botw-pd.s3.amazonaws.com/styles/logo-original-577x577/s3/062015/guess.png?itok=wVNOgHKI"
             , @"https://vignette.wikia.nocookie.net/logopedia/images/0/03/Jollibee_ph_logo.jpeg/revision/latest?cb=20130821014824"
             , @"https://vignette.wikia.nocookie.net/logopedia/images/a/a9/Mcdonalds-90s-logo.svg/revision/latest/scale-to-width-down/200?cb=20100717060808"
             , @"https://vignette.wikia.nocookie.net/logopedia/images/1/17/Home_logo2.gif/revision/latest?cb=20130902103629"
             , @"data:image/png;base64,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"
             , @"https://www.soundgrovemusic.sg/wp-content/uploads/2017/02/branding-nike-logo.png"
             , @"data:image/png;base64,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"
             , @"https://yt3.ggpht.com/-qREE3vjYwd8/AAAAAAAAAAI/AAAAAAAAAAA/sJT6qWvLdj4/s88-c-k-no-mo-rj-c0xffffff"
             , @"https://vignette.wikia.nocookie.net/starwars/images/2/22/EA_logo.png/revision/latest/scale-to-width-down/480?cb=20151117033701"
             , @"data:image/png;base64,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"
             , @"https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAtp0RU.img?h=370&w=624&m=6&q=60&o=f&l=f"
             , @"https://iliganjobs.com/wp-content/uploads/job-manager-uploads/company_logo/2017/02/mercury-drug.jpg"
             , @"http://3.bp.blogspot.com/-PjzrumPMgPU/WNxZxWaHvCI/AAAAAAAAH8c/M092SwagHPsd6zmuxm-kYNmDbrLRwA2nwCK4B/s1600/header.jpg"];
}

- (NSArray *)merchantDetails
{
    return @[@"(styled as GUESS or Guess?) is an American clothing brand and retailer. In addition to clothing for both men and women, Guess markets other fashion accessories such as watches, jewelry, perfumes, and shoes."
             , @"Jollibee is the largest fast food chain in the Philippines, operating a nationwide network of over 750 stores. A dominant market leader in the Philippines, Jollibee enjoys the lion's share of the local market that is more than all the other multinational brands combined."
             , @"is a fast food company that was founded in 1940 as a restaurant operated by Richard and Maurice McDonald, in San Bernardino, California, United States. They rechristened their business as a hamburger stand. The first time a McDonald's franchise used the Golden Arches logo was in 1953 at a location in Phoenix, Arizona. In 1955, Ray Kroc, a businessman, joined the company as a franchise agent and proceeded to purchase the chain from the McDonald brothers. McDonald's had its original headquarters in Oak Brook, Illinois, but has approved plans to move its global headquarters to Chicago by 2018"
             , @"founded in 1971 by Cresida Tueres, is a pizza and pasta chain in the Philippines.\nIn 1994, Jollibee Foods Corporation acquired 80% of Greenwich shares.[1] Then, in 2006, Jollibee bought out the remaining shares of its partners in Greenwich for PHP384 million, giving rise to a new company known as the Greenwich Pizza Corporation. The franchise experienced rapid expansion from the original 50 stores in 1994 to over 240 stores with an annual revenue of over PHP4 billion in 2005. Expanding further through 2011, the corporation had opened over 330 stores.[2]\nGreenwich Pizza later became a brand managed by Fresh N Famous Foods, a subsidiary of Jollibee Foods Corporation"
             , @"is a pizza restaurant chain based in the United States.[1] Founded in 1954, it was the first franchise pizza chain in the United States.[2][3] In 1968, the chain had 342 locations.[4] The chain currently has about 500 stores globally, and about 60 in the United States."
             , @"Nike, Inc. is an American multinational corporation that is engaged in the design, development, manufacturing, and worldwide marketing and sales of footwear, apparel, equipment, accessories, and services"
             , @"Air Jordan is a brand of basketball footwear and athletic clothing produced by Nike. It was created for former professional basketball player Michael Jordan"
             , @"Etude House is a South Korean cosmetics brand owned by Amore Pacific. The brand name 'Etude' comes from Frederic Chopin's studies of the piano. Etude simply means study in French"
             , @"Electronic Arts Inc. is an American video game company headquartered in Redwood City, California. Founded and incorporated on May 28, 1982 by Trip Hawkins"
             , @"Honda Motor Company, Ltd. is a Japanese public multinational conglomerate corporation primarily known as a manufacturer of automobiles, aircraft, motorcycles, and power equipmen"
             , @"Cebu Air, Inc., operating as Cebu Pacific, is a Philippine low-cost airline based on the grounds of Ninoy Aquino International Airport, Pasay City, Metro Manila, in the Philippines"
             , @"Mercury Drug is the leading trusted and caring drugstore in the Philippines, whose founder has been hailed as the 'Father of Philippine Health and Wellness Retailing.'"
             , @"We are a family-run company that has been producing original, eco-friendly gifts, stationery, and home décor since 1967"
             ];
}

- (NSArray *)passDescsGuess
{
    return @[@"GUESS 30 % OFF APPAREL", @"GUESS 15% OFF WATCHES", @"GUESS 30% OFF BAGS" ];
}
- (NSArray *)passDescsJollibee
{
    return @[@"JOLLIBEE BUY 1 TAKE 1 BURGER", @"JOLLIBEE BUY SPAGETTI VALUE MEAL FREE HAMBURGER",
             @"JOLLIBEE FREE YUM CHEESEBURGER FOR EVERY 6-PC CHICKENJOY BUCKET", @"JOLLIBEE GRAB AN 8-PC BUCKET GET 2 PCS FREE",@"JOLLIBEE CHAMP 50 % OFF"];
}
- (NSArray *)passDescsMcdo
{
    return @[@"MCDO FREE MEDIUM FRIES WHEN YOU BUY MEDIUM COCA COLA/SOFT DRINKS", @"MCDO 2 16OZ GOLDEN ROOTBEER MCFLOAT", @"MCDO 2 PC CHICKEN MCDO FOR 99PHP", @"MCDO GET FREE 1 PC CHICKEN MCDO FOR EVERY HAPPY MEAL" ];
}
- (NSArray *)passDescsShakeys
{
    return @[@"SHAKEYS ENJOY A BASKET OF MOJOS FOR 40 PHP", @"SHAKEYS 40% OFF CHICKEN 'N' MOJOS", @"SHAKEYS SCALLOP PRIMO 30% DISCOUNT" ];
}
- (NSArray *)passDescsGreenwich
{
    return @[@"GREENWICH 50% OFF MIN ORDER 600 MAXDISCOUNT 800",@"GREENWICH BUY 1 GET 1 FREE BARKADA HAWAIIAN SPECIAL" ];
}
- (NSArray *)passDescsNike
{
    return @[ @"NIKE 60 % OFF ",@" NIKE SALE 30-50% ON SELECTED ITEMS " ];
}
- (NSArray *)passDescsJordan
{
    return @[@"JORDAN 30 % OFF CLEARANCE ",@" JORDAN SALE 30-50% ON SELECTED ITEMS " ];
}
- (NSArray *)passDescsEtude
{
    return @[@"ETUDE 30 % OFF APPAREL" , @"ETUDE 30 % DISCOUNT ALL ITEMS", @"ETUDE SALE UP TO 75% ON SELECTED ITEMS", @"ETUDE 30% DISCOUNT FOR ALL + 20% OFF FOR MEMBERS" ];
}
- (NSArray *)passDescsEA
{
    return @[@"EA 75% XMAS SALE ", @"EA FREE EA GAMES FOR LIMITED TIME" ];
}
- (NSArray *)passDescsHonda
{
    return @[@"HONDA ZERO DOWNPAYMENT PRE BUDGET PRICE BENEFITES ", @"HONDA DOUBLE BONUSES AND EXCLUSIVE GIFT"];
}
- (NSArray *)passDescsCebuPacific
{
    return @[@"CEBU PACIFIC 350PHP FOR SELECT PHILIPPINE DESTINATIONS ", @"CEBU PACIFIC 1,575PHP MANILA TO HONGKONG",@"CEBU PACIFIC 50% OFF ON ALL INTERNATIONAL DESTINATIONS", @"CEBU PACIFIC 88PHP ON ALL DOMESTIC DESTINATIONS", @"CEBU PACIFIC 50%OFF PAYDAY SEAT SALE",@"CEBU PACIFIC 1PHP TO ALL PHILIPPINE DESTINATIONS"];
}

- (NSArray *)passDescsMercuryDrug
{
    return @[@"MERCURY DRUG VISINE OPTHALMIC DROPS P12.00 OFF", @"MERCURY DRUG AMBROLEX OD CAPSULE P5.00 OFF", @"MERCURY DRUG AMBROLEX ORAL DROPS P9.00 OFF",@"MERCURY DRUG IBUPROFEN DOLAN P5.00 OFF"];
}

- (NSArray *)passDescsPapemelroti
{
    return @[@"PAPEMELROTI DISCOUNTED JEWELRY AND PAPER PRODUCTS 10 TO 15% ", @"PAPEMELROTI UP TO 50% OFF" ];
}

- (NSMutableDictionary *)getPassDetails
{
    if(!passDetails)
        passDetails = [NSMutableDictionary new];
    if([passDetails allKeys].count < 1)
    {
        [passDetails setObject:[self passDescsGuess] forKey:@"GUESS"];
        [passDetails setObject:[self passDescsJollibee] forKey:@"JOLLIBEE"];
        [passDetails setObject:[self passDescsMcdo] forKey:@"MCDO"];
        [passDetails setObject:[self passDescsShakeys] forKey:@"SHAKEYS"];
        [passDetails setObject:[self passDescsGreenwich] forKey:@"GREENWICH"];
        [passDetails setObject:[self passDescsNike] forKey:@"NIKE"];
        [passDetails setObject:[self passDescsJordan] forKey:@"JORDAN"];
        [passDetails setObject:[self passDescsEtude] forKey:@"ETUDE"];
        [passDetails setObject:[self passDescsEA] forKey:@"EA"];
        [passDetails setObject:[self passDescsHonda] forKey:@"HONDA"];
        [passDetails setObject:[self passDescsCebuPacific] forKey:@"CEBU PACIFIC"];
        
        [passDetails setObject:[self passDescsMercuryDrug] forKey:@"MERCURY DRUG"];
        [passDetails setObject:[self passDescsPapemelroti] forKey:@"PAPEMELROTI"];
        [passDetails setObject:[self passDescsGuess] forKey:@"GUESS"];
    }
    return passDetails;
}

- (NSMutableDictionary *)getPassAds
{
    if(!passAds)
        passAds = [NSMutableDictionary new];
    if([passAds allKeys].count < 1)
    {
        [passAds setObject:@[passAdGuess, passAdGuessImage,passAdGuessLink] forKey:@"GUESS"];
        [passAds setObject:@[passAdJollibee, passAdJollibeeImage,passAdJollibeeLink] forKey:@"JOLLIBEE"];
        [passAds setObject:@[passAdMcdo, passAdMcdoImage,passAdMcdoLink] forKey:@"MCDO"];
        [passAds setObject:@[passAdShakeys, passAdShakeysImage,passAdShakeysLink] forKey:@"SHAKEYS"];
        [passAds setObject:@[passAdGreenwich, passAdGreenwichImage,passAdGreenwichLink] forKey:@"GREENWICH"];
        [passAds setObject:@[passAdNike, passAdNikeImage,passAdNikeLink] forKey:@"NIKE"];
        [passAds setObject:@[passAdJordan, passAdJordanImage,passAdJordanLink] forKey:@"JORDAN"];
        [passAds setObject:@[passAdEtude, passAdEtudeImage,passAdEtudeLink] forKey:@"ETUDE"];
        [passAds setObject:@[passAdEA, passAdEAImage,passAdEALink] forKey:@"EA"];
        [passAds setObject:@[passAdHonda, passAdHondaImage,passAdHondaLink] forKey:@"HONDA"];
        [passAds setObject:@[passAdCebuPacific, passAdCebuPacificImage,passAdCebuPacificLink] forKey:@"CEBU PACIFIC"];
        
        [passAds setObject:@[passAdMercuryDrug, passAdMercuryDrugImage,passAdMercuryDrugLink] forKey:@"MERCURY DRUG"];
        [passAds setObject:@[passAdPapemelroti, passAdPapemelrotiImage,passAdPapemelrotiLink] forKey:@"PAPEMELROTI"];
        [passAds setObject:@[passAdGuess, passAdGuessImage,passAdGuessLink] forKey:@"GUESS"];
        
        
    }
    return passAds;
}

- (NSMutableDictionary *)getPassNews
{
    if(!passNews)
        passNews = [NSMutableDictionary new];
    if([passNews allKeys].count < 1)
    {
        [passNews setObject:@[passNewsGuess, passNewsGuessImage,passNewsGuessLink] forKey:@"GUESS"];
        [passNews setObject:@[passNewsJollibee, passNewsJollibeeImage,passNewsJollibeeLink] forKey:@"JOLLIBEE"];
        [passNews setObject:@[passNewsMcdo, passNewsMcdoImage,passNewsMcdoLink] forKey:@"MCDO"];
        [passNews setObject:@[passNewsShakeys, passNewsShakeysImage,passNewsShakeysLink] forKey:@"SHAKEYS"];
        [passNews setObject:@[passNewsGreenwich, passNewsGreenwichImage,passNewsGreenwichLink] forKey:@"GREENWICH"];
        [passNews setObject:@[passNewsNike, passNewsNikeImage,passNewsNikeLink] forKey:@"NIKE"];
        [passNews setObject:@[passNewsJordan, passNewsJordanImage,passNewsJordanLink] forKey:@"JORDAN"];
        [passNews setObject:@[passNewsEtude, passNewsEtudeImage,passNewsEtudeLink] forKey:@"ETUDE"];
        [passNews setObject:@[passNewsEA, passNewsEAImage,passNewsEALink] forKey:@"EA"];
        [passNews setObject:@[passNewsHonda, passNewsHondaImage,passNewsHondaLink] forKey:@"HONDA"];
        [passNews setObject:@[passNewsCebuPacific, passNewsCebuPacificImage,passNewsCebuPacificLink] forKey:@"CEBU PACIFIC"];
        
        [passNews setObject:@[passNewsMercuryDrug, passNewsMercuryDrugImage,passNewsMercuryDrugLink] forKey:@"MERCURY DRUG"];
        [passNews setObject:@[passNewsPapemelroti, passNewsPapemelrotiImage,passNewsPapemelrotiLink] forKey:@"PAPEMELROTI"];
        [passNews setObject:@[passNewsGuess, passNewsGuessImage,passNewsGuessLink] forKey:@"GUESS"];
        
        
    }
    return passNews;
}


NSString *passNewsShakeys = @"You read that right! The P2018 Meal Deal is EXTENDED! Enjoy until March 31, 2018. #Lucky2018\nWhat are you waiting for? Order now at www.shakeyspizza.ph or dial 77-777!\n*Available for dine-in, carry-out and delivery\n**Dine-in & carry-out price is P2,018.00 and Delivery price is P2,118.00\nDTI FTEB PERMIT NO. 17510 SERIES OF 2017";
NSString *passNewsShakeysImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28279497_1850632808312076_7481219612953047337_n.jpg?oh=161e62246e420c4046c5889a0ac4c79b&oe=5B0ADC79";
NSString *passNewsShakeysLink = @"https://www.facebook.com/ShakeysPH/photos/a.168836723138454.34115.148370235185103/1773326716022772/?type=3&theater";
NSString *passAdShakeys = @"Try the NEW Louisiana Shrimp Pizza today! Fresh and succulent shrimps marinated in Cajun spice blend topped with fresh basil leaves spread over our famous thin crust pizza with special herbed-garlic sauce";
NSString *passAdShakeysImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/27973489_1764107353611375_5739802757888151949_n.jpg?oh=753d64c3afacb1d18100dcf26f4e2495&oe=5B487CEE";
NSString *passAdShakeysLink = @"https://www.facebook.com/ShakeysPH/videos/1764033930285384/";

NSString *passNewsGuess = @"THIS JUST IN! Today is the re-opening of GUESS Baby and Kids boutique in Ayala Cebu! Be sure to drop by ";
NSString *passNewsGuessImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/27657459_1766048993690354_685913358039780692_n.jpg?oh=7b77cd9539e073723cbf1bda40b287d9&oe=5B4DF124";
NSString *passNewsGuessLink = @"https://www.facebook.com/GUESSPhil/posts/1766049177023669";
NSString *passAdGuess = @"Big thanks to our Cebu family who joined us last February 3 for #LoveGUESSCebu! See you on our next event!";
NSString *passAdGuessImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/27657573_1766388733656380_3987200793822438350_n.jpg?oh=4344c2f5c9befb53c3fcac44e20e99ff&oe=5B0D4692";
NSString *passAdGuessLink = @"https://www.facebook.com/GUESSPhil/posts/1766388776989709";

NSString *passNewsMcdo = @"McDonald’s continues to grow with more new stores this 2018. Visit our latest branch at Madison, Greenhills featuring a new and contemporary design!";
NSString *passNewsMcdoImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28166248_1685461124836474_5047436972351650339_n.jpg?oh=b46541005af153a7b53ef8ee65c98774&oe=5B4A61B0";
NSString *passNewsMcdoLink = @"https://www.facebook.com/McDo.ph/posts/1685462488169671";
NSString *passAdMcdo = @"Bagong desal para sa bagong umaga! Try our NEW Longgadesal today for only P42! Price varies.";
NSString *passAdMcdoImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/27972430_1691886510860602_5672213395465519901_n.jpg?oh=036961cc2c1099b16cfdb2c4f77aaaa0&oe=5B0696C1";
NSString *passAdMcdoLink = @"https://www.facebook.com/McDo.ph/posts/1691886907527229";
//
NSString *passNewsGreenwich = @"SPOTTED: The newest members of the Greenwich Barkada (insert Yassi Pressman) here at #GWorldPizzaDay! #GWithTheBarkada";
NSString *passNewsGreenwichImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/27544793_2003745482976040_7900943225789429898_n.jpg?oh=c0d78dcf8b7296b37af6daf2792ae59d&oe=5B49978E";
NSString *passNewsGreenwichLink = @"https://www.facebook.com/GreenwichPizza/posts/2003745836309338";
NSString *passAdGreenwich = @"Greenwich Overload Pizza, Loaded sa toppings, Over sa sarap. Starts at Presyong Kaibigan of only P219!";
NSString *passAdGreenwichImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/27540062_1995708410446414_8261048103677544787_n.jpg?oh=bacaea5397676d14f7ea31f7af206bbd&oe=5B01BC5B";
NSString *passAdGreenwichLink = @"https://www.facebook.com/GreenwichPizza/posts/1995708590446396";

NSString *passNewsJollibee = @"Looking for a fun summer experience for your kids? Enroll them to Jollibee Mini Managers Camp where they can learn the values of service and leadership while having fun! Inquire now at participating Jollibee stores.\n\nFor details, please see http://bit.ly/2oHBztt";
NSString *passNewsJollibeeImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28279091_1747986201914265_7850783130145934258_n.jpg?oh=781d55e5bd65b74ab1c34d2d6911d970&oe=5B4D04D6";
NSString *passNewsJollibeeLink = @"https://www.facebook.com/JollibeePhilippines/photos/a.177020915677476.36028.170055766373991/1747986201914265/?type=3&theater";
NSString *passAdJollibee = @"Free yourself from the guilt. Enjoy a bite of Tuna Pie after a good run 🏃";
NSString *passAdJollibeeImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28167226_1747879441924941_1540256596170843114_n.jpg?oh=616ab55c5be2ed0d9a91bf59c06929e8&oe=5B46CCB7";
NSString *passAdJollibeeLink = @"https://www.facebook.com/JollibeePhilippines/posts/1747879611924924";

NSString *passNewsEA = @"Save the Date: EA PLAY is coming this June!";
NSString *passNewsEAImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28279552_10156173479219190_2085511535561902209_n.jpg?oh=c5f40eccf8c81872e264284693ab2215&oe=5B07118A";
NSString *passNewsEALink = @"https://www.facebook.com/EA/photos/a.464072989189.252660.68678914189/10156173479219190/?type=3";
NSString *passAdEA = @"Jump into a classic shooter with EA Access.\nSee all the games in the Vault: x.ea.com/44638";
NSString *passAdEAImage = @"https://media.contentapi.ea.com/content/dam/ea-access-refresh-prototype/news/eax-news-hero-16-9.jpg.adapt.1456w.jpg";
NSString *passAdEALink = @"https://www.facebook.com/EA/posts/10156072547094190";

NSString *passNewsEtude = @"Visit us at SM City Baguio (official) this weekend for their 3 Day Sale! Celebrate Panagbenga Festival with Etude House for free gifts and more! ";
NSString *passNewsEtudeImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28055682_1753465424676084_1623208960457042331_n.jpg?oh=462991c563bea1e24e1af94329e3bc92&oe=5B4181BB";
NSString *passNewsEtudeLink = @"https://www.facebook.com/etudehousephilippines/photos/a.156310611058248.31367.156132414409401/1753465424676084/?type=3";
NSString *passAdEtude = @"When you had to give yourself a break for long lectures and breathe in for a while. Retouch! It's therapeutic. Take your Dear My Lips Talk with you! #DearMyLipsTalk #FromPrincesstoGirlBoss #EtudeHousePH\n\nP578";
NSString *passAdEtudeImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28576361_1762024713820155_7531129289865953280_n.jpg?oh=4bfcf3e6ec7fef245c85ebfbb3ad304f&oe=5B457E04";
NSString *passAdEtudeLink = @"https://www.facebook.com/etudehousephilippines/photos/a.156310611058248.31367.156132414409401/1762024710486822/?type=3";

NSString *passNewsNike = @"Strong and empowered. Celebrate Women's Week with Nike Factory Store and avail discounts on women's footwear and apparel starting March 2.\n\nGet the Nike Women's Air Zoom Fearless Flyknit at 30% off, available at NFS SLEX Mamplasan, NFS NLEX Pampanga, NFS Paseo de Sta. Rosa, and NFS Mactan Cebu. #NikeFactoryStorePH";
NSString *passNewsNikeImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28685553_1647397595306103_1432071791508119449_n.jpg?oh=63449ea7c04fb852f0c1c12df79cd7da&oe=5B01A621";
NSString *passNewsNikeLink = @"https://www.facebook.com/nikefactorystoreph/photos/a.434831996562675.96615.255304357848774/1647397595306103/?type=3";
NSString *passAdNike = @"Unmatched aesthetic.\nThe Air Jordan 13 Retro \"Altitude\" is now in store. Cop your pair today and visit Nike Factory Store. #Jordan13 #NikeFactoryStorePH";
NSString *passAdNikeImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28279461_1642474889131707_7204610419812052834_n.jpg?oh=5b6d0f9527cd5b9640b4fc8fa22960b0&oe=5B139E70";
NSString *passAdNikeLink = @"https://www.facebook.com/nikefactorystoreph/photos/a.434831996562675.96615.255304357848774/1642474889131707/?type=3";

NSString *passNewsJordan = @"Recognizing greatness.\nLegendary Jordan designer Tinker Hatfield comes together with shoe artist Joshua Vides to talk about their creative processes. #JUMPMAN";
NSString *passNewsJordanImage = @"https://air.jordan.com/wp-content/uploads/2018/02/desktop_IMG_1427-1920x900.jpg";
NSString *passNewsJordanLink = @"https://www.facebook.com/jumpman23/posts/1831994906853066";
NSString *passAdJordan = @" to royalty.\nThe #AirJordan XIII 'White / Royal' is available now: https://swoo.sh/2HOWbsA.";
NSString *passAdJordanImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28378074_1845528128833077_1101709761159455960_n.jpg?oh=e4692d8dd644ab85a50a4c793d293796&oe=5B42262A";
NSString *passAdJordanLink = @"https://www.facebook.com/jumpman23/photos/a.117452338307340.20970.113589525360288/1845528128833077/?type=3";

NSString *passNewsCebuPacific = @"CEBU PACIFIC TRAVEL ADVISORY #2\nAs of February 13, 2018\nIn light of unfavorable and unsafe weather conditions caused by TS Basyang,@";
NSString *passNewsCebuPacificImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/11846655_993814750664800_1330115123810384916_n.png?oh=2247cce4347ae4487100789d69d26c1d&oe=5B4BE08B";
NSString *passNewsCebuPacificLink = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/11846655_993814750664800_1330115123810384916_n.png?oh=2247cce4347ae4487100789d69d26c1d&oe=5B4BE08B";
NSString *passAdCebuPacific = @"Now you can fly direct to Melbourne, Australia from Manila! Book now from Feb. 27 to Mar. 3 for as low as P 2,199! Travel from Aug. 14 to Oct. 31, 2018. bit.ly/fb02272018";
NSString *passAdCebuPacificImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28168336_1807787169267550_2377213592123721713_n.jpg?oh=8e6b5fe14e934ed8a40446cff4090378&oe=5B4665F3";
NSString *passAdCebuPacificLink = @"https://www.facebook.com/cebupacificairphilippines/posts/1791706940875573";

NSString *passNewsPapemelroti = @"Sign up for my art camp this summer! I will have an art camp in Quezon City, Makati and Alabang - take your pick!\n\nsign up here:\nishine.ph";
NSString *passNewsPapemelrotiImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28279799_10156817965820190_5157093754948900511_n.jpg?oh=4837820488443d74d7602f01429de185&oe=5B4BD88F";
NSString *passNewsPapemelrotiLink = @"https://www.facebook.com/photo.php?fbid=10156817965820190&set=a.74805210189.108812.748755189&type=3&theater";
NSString *passAdPapemelroti = @"Say yes to adventure and take your #papemelroti essentials with you, or decorate your space with items to inspire you to plan that next trip! ✈️\n Get these items in store / on shop.papemelroti.com";
NSString *passAdPapemelrotiImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28377480_1814600295230406_3004564803218672336_n.jpg?oh=b3f82cc73b939451342811f45ee9f401&oe=5B0A7559";
NSString *passAdPapemelrotiLink = @"https://www.facebook.com/papemelroti/photos/a.1513285022028603.1073741872.113492892007830/1814600295230406/?type=3&theater";

NSString *passNewsMercuryDrug = @"The newest Mercury Drug store at Kawit V Central Mall is now open! #ParaSaYoSuki";
NSString *passNewsMercuryDrugImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28468126_1299536503523274_5207979738628597962_n.png?oh=daa7ab499aefe10cf9bfbac23436bfd9&oe=5B0A4A1A";
NSString *passNewsMercuryDrugLink = @"https://www.facebook.com/mercurydrugph/photos/a.207951849348417.64679.153615111448758/1299536503523274/?type=3&theater";
NSString *passAdMercuryDrug = @"Make those special moments with your baby even more special with these Johnson's Baby products. #SukiSavings #ParaSaYoSuki";
NSString *passAdMercuryDrugImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/28379726_1300235833453341_9135376550129900642_n.png?oh=f02ba79132ef99d56300bc0ce1d70a9b&oe=5B049CA3";
NSString *passAdMercuryDrugLink = @"https://www.facebook.com/mercurydrugph/photos/a.207951849348417.64679.153615111448758/1300235833453341/?type=3&theater";

NSString *passNewsHonda = @"We’re live from CES 2018, checking out our latest robot innovations. Join us to see our new companion bot, autonomous off-road workhorse vehicle concept and more.";
NSString *passNewsHondaImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/10696307_10152706850109275_1708986217665329844_n.jpg?oh=4ff4467dcdbe28357007682958af4581&oe=5B0BABE1";
NSString *passNewsHondaLink = @"https://www.facebook.com/Honda/videos/10156066036639275/";
NSString *passAdHonda = @"Sophisticated style and performance are yours with the 2018 Honda Accord. Learn more at http://honda.us/2qoXLgb";
NSString *passAdHondaImage = @"https://scontent.fmnl7-1.fna.fbcdn.net/v/t1.0-9/26219148_10156052248004275_8423799297107271897_n.jpg?oh=b5c5faa5fc0f7475c91d6e75b02979cd&oe=5B098B5F";
NSString *passAdHondaLink = @"https://www.facebook.com/Honda/photos/a.10150704829214275.430187.107926874274/10156052248004275/?type=3&theater";



@end
