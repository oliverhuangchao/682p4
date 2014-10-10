//
//  LoginViewController.m
//  Viewtext
//
//  Created by Chao Huang on 9/20/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "LoginViewController.h"
#import "GetMethodsConnect.h"
#import "SignUpViewController.h"
#import "SearchBookViewController.h"
#import "UserProfileViewController.h"



@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *confirmLoginButtonLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButtonLabel;

@property (weak, nonatomic) IBOutlet UIButton *informationButtonLabel;

@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *userPassword;
//@property (nonatomic) UIAlertView *alert;

@end

@implementation LoginViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.informationButtonLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Information"]];
    
    self.confirmLoginButtonLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tigerPaw"]];
    
    self.signUpButtonLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"signup"]];
    
    [self setUpForDismissKeyboard];
    
    // Do any additional setup after loading the view.
}

- (void) setUpForDismissKeyboard{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQueue
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQueue
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

-(void) tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}

- (IBAction)userNameChanged:(UITextField *)sender {
    self.userName = self.userNameTextField.text;
    //[sender resignFirstResponder];
}

- (IBAction)userPasswordChanged:(UITextField *)sender {
    self.userPassword = self.userPasswordTextField.text;
    //[sender resignFirstResponder];
}

- (IBAction)confirmLoginButton:(UIButton *)sender {
    
    NSString *searchURL =[NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/searchName.php?userName=%@&userPassword=%@",self.userName,self.userPassword];
  
    NSData *resultData = [GetMethodsConnect getContentFromPhp:searchURL];
    
    NSString *resultString = [[NSString alloc] initWithData:resultData
                                                  encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",searchURL);
    
    if ([resultString isEqual: @"yes"]){
        //SearchBookViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetailPage"];
        //[self.navigationController pushViewController:next animated:NO];
        //[UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
        
        
        //get userID here
        searchURL =[NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/getUserIDbyUserName.php?name=%@&password=%@",self.userName,self.userPassword];
        NSData *resultData = [GetMethodsConnect getContentFromPhp:searchURL];
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:nil];
        self.userID =[[resultArray objectAtIndex:0] integerValue] ;

        [self performSegueWithIdentifier:@"isLoginCorrect" sender:nil];

        
    }
    else{
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Wrong Passworld!"
                                           message:@"You have input the wrong password!"
                                          delegate:nil
                                 cancelButtonTitle:@"Retry"
                                 otherButtonTitles: nil];
        
        [alert show];
    }
}

- (IBAction)goToSignUp:(UIButton *)sender {
    
    SignUpViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"signUpPage"];
    [self.navigationController pushViewController:next animated:NO];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
    
   // [self performSegueWithIdentifier:@"goToSignUp" sender:nil];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString: @"isLoginCorrect"]){
        UserProfileViewController *controller = (UserProfileViewController *)segue.destinationViewController;
        controller.userName = self.userName;
        controller.userID = self.userID;
    }
    
}



@end
