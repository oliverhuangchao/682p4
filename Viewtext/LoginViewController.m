//
//  LoginViewController.m
//  Viewtext
//
//  Created by Chao Huang on 9/20/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "LoginViewController.h"
#import "GetMethodsConnect.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *confirmLoginButtonLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;


@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *userPassword;
//@property (nonatomic) UIAlertView *alert;

@end

@implementation LoginViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.confirmLoginButtonLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tigerPaw"]];
    
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
    
    NSLog(@"%@",searchURL);
    
    if ([resultString isEqual: @"yes"]){
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

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
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