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
    
    self.currentUserNameTitleLabel.title = @"User Detail Infomation";
    
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
    
    if([segue.identifier isEqualToString: @"goToChangePasswordPage"]){
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
    
    if(indexPath.row == 2)
        [self performSegueWithIdentifier:@"goToChangePasswordPage" sender:self];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currentUserInfo.count;
}

-(void) loaddata:(NSInteger) userID{
    NSString *basic_URL = [NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/getUserInfoByID.php?userID=%d",userID];
    NSData *resultData = [GetMethodsConnect getContentFromPhp:basic_URL];
    
    self.currentUserInfo  = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:nil];
    
    [self.currentUserDetailProfileTableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoTableCell" forIndexPath:indexPath];
    
    
    if (indexPath.row == 3){
        NSString *commonString = @"http://people.cs.clemson.edu/~chaoh/ios/pic/";
        
        NSString *picUrlString = [commonString stringByAppendingString:[self.currentUserInfo objectAtIndex:3]];
            
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: picUrlString]];
        
        cell.imageView.image = [UIImage imageWithData:imageData];
    }
    else if(indexPath.row == 1 || indexPath.row == 2){
        cell.textLabel.text = [self.currentUserInfo objectAtIndex:indexPath.row];
    }

    return cell;
}
-(void) viewDidAppear:(BOOL)animated{
    [self loaddata:self.currentUserID];
}

- (void) editingInfoWasFinished{
    NSLog(@"finish edition and back");
    [self loaddata:self.currentUserID];
}

@end
