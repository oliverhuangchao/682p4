//
//  UserProfileViewController.m
//  ;
//
//  Created by Chao Huang on 10/9/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserDetailViewController.h"
@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *currentUserNameTitle;
@property (weak, nonatomic) IBOutlet UIImageView *currentUserProfile;
@property (weak, nonatomic) IBOutlet UILabel *curerntUserName;
@property (weak, nonatomic) IBOutlet UILabel *currentUserValue;

@property (weak, nonatomic) IBOutlet UIButton *viewHistoryButtonProfile;
@property (weak, nonatomic) IBOutlet UIButton *changeProfileButtonProfile;
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
    // Do any additional setup after loading the view.
    self.currentUserNameTitle.title = self.userName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goToSearchHistoryPageButton:(id)sender {
    [self performSegueWithIdentifier:@"goToUserSearchDetail" sender:nil];

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
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
