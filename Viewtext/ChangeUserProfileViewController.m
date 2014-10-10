//
//  ChangeUserProfileViewController.m
//  Viewtext
//
//  Created by Chao Huang on 10/9/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "ChangeUserProfileViewController.h"

@interface ChangeUserProfileViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *changeProfileTitleLabel;

@end

@implementation ChangeUserProfileViewController

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
    self.changeProfileTitleLabel.title = self.currentUserName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
