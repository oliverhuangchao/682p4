//
//  UserProfileViewController.m
//  ;
//
//  Created by Chao Huang on 10/9/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserDetailViewController.h"
#import "GetMethodsConnect.h"
#import "ConvenientTools.h"
#import "ChangeUserProfileViewController.h"


@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *currentUserNameTitle;

@property (weak, nonatomic) IBOutlet UILabel *currentUserName;

@property (weak, nonatomic) IBOutlet UILabel *currentUserValue;

@property (weak, nonatomic) IBOutlet UIImageView *currentUserProfile;

@property (weak, nonatomic) IBOutlet UIButton *viewHistoryButtonProfile;

@property (weak, nonatomic) IBOutlet UIButton *changeProfileButtonProfile;

@property (weak, nonatomic) IBOutlet UIButton *viewMyBookButtonProfile;






@end

@implementation UserProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.currentUserNameTitle.title = self.userName;
    
    self.viewHistoryButtonProfile.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"history"]];
    
    self.changeProfileButtonProfile.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"change"]];
    
    self.currentUserProfile.image = [ConvenientTools getUserProFileByUserIDFromGlobalDatabase:self.userID];
    
    self.currentUserValue.text = [NSString stringWithFormat:@"Current value is 💰 %d",
                                 [[ConvenientTools getUserInfoByUserIDFromGlobalDatabase:self.userID :4] integerValue]];
    
    self.currentUserName.text = [NSString stringWithFormat:@"%@",[ConvenientTools getUserInfoByUserIDFromGlobalDatabase:self.userID :1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goToSearchHistoryPageButton:(id)sender {
    [self performSegueWithIdentifier:@"goToUserSearchDetail" sender:nil];

}
- (IBAction)goToChangeProfilePageButton:(id)sender {
    [self performSegueWithIdentifier:@"goToChangeProfilePage" sender:nil];

}

-(void) showbasicInformation{
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString: @"goToUserSearchDetail"]){
        UserDetailViewController *controller = (UserDetailViewController *)segue.destinationViewController;
        controller.currentUserName = self.userName;
        controller.currentUserID = self.userID;
    }
    if([segue.identifier isEqualToString: @"goToChangeProfilePage"]){
        ChangeUserProfileViewController *controller = (ChangeUserProfileViewController *)segue.destinationViewController;
        controller.currentUserName = self.userName;
        controller.currentUserID = self.userID;
    }
}


@end
