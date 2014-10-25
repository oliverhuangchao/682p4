//
//  ChangeUserProfileViewController.m
//  Viewtext
//
//  Created by HuangChao on 14/10/23.
//  Copyright (c) 2014年 Clemson. All rights reserved.
//

#import "ChangeUserProfileViewController.h"
#import "GetMethodsConnect.h"
//#import "ChangeUserSelectedItemViewController.h"
#import "ChangeUserNameViewController.h"
#import "ChangeUserPictureViewController.h"
@interface ChangeUserProfileViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *currentUserNameTitleLabel;

@property (nonatomic, strong) NSMutableArray* currentUserInfo;
@end

@implementation ChangeUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentUserDetailProfileTableView.delegate = self;
    self.currentUserDetailProfileTableView.dataSource = self;
    
    self.currentUserNameTitleLabel.title = self.currentUserName;
    
    [self loaddata:self.currentUserID];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString: @"goToChangeNamePage"]){
       // change *controller = (ChangeUserSelectedItemViewController *)segue.destinationViewController;
        //controller.currentUserName = self.currentUserName;
        //controller.currentUserID = self.currentUserID;
        
        ChangeUserNameViewController *childController = (ChangeUserNameViewController *)segue.destinationViewController;
        childController.currentUserName = self.currentUserName;
        childController.currentUserID = self.currentUserID;
    }
    if([segue.identifier isEqualToString: @"goToChangePicturePage"]){
        ChangeUserPictureViewController *childController = (ChangeUserPictureViewController *)segue.destinationViewController;
        childController.currentUserID = self.currentUserID;
    }

}

//click one of the cell and goes to another page
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1)
        [self performSegueWithIdentifier:@"goToChangeNamePage" sender:self];
    
    if(indexPath.row == 3)
        [self performSegueWithIdentifier:@"goToChangePicturePage" sender:self];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currentUserInfo.count;
}

-(void) loaddata:(NSInteger) userID{
    NSString *basic_URL = [NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/getUserInfoByID.php?userID=%d",userID];
    NSData *resultData = [GetMethodsConnect getContentFromPhp:basic_URL];
    self.currentUserInfo  = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:nil];
    NSLog(@"%@", [self.currentUserInfo objectAtIndex:1]);
    [self.currentUserDetailProfileTableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoTableCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.currentUserInfo objectAtIndex:indexPath.row];

    return cell;
}

- (void) editingInfoWasFinished{
    [self loaddata:self.currentUserID];
}

@end
