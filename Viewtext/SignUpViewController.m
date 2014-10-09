//
//  SignUpViewController.m
//  Viewtext
//
//  Created by Chao Huang on 9/21/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "SignUpViewController.h"
#import "GetMethodsConnect.h"
#import "SearchBookViewController.h"
@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputRePasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *clemsonBindButtonLabel;



@property (nonatomic) NSString *mynewUserName;
@property (nonatomic) NSString *mynewUserPassword;
@property (nonatomic) BOOL isTwoPasswordMatch;



@end

@implementation SignUpViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.clemsonBindButtonLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clemsonLogo-round"]];
    [self setUpForDismissKeyboard];

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

- (IBAction)userNameTextFieldTouchDownFunction:(id)sender {
    self.inputUserNameTextField.text = @"";
}
- (IBAction)passwordTextFieldTouchDownFunction:(UITextField *)sender {
    self.inputPasswordTextField.text = @"";
}
- (IBAction)repasswordTextFieldTouchDownFunction:(UITextField *)sender {
    self.inputRePasswordTextField.text = @"";
}



- (IBAction)setNewUserName:(UITextField *)sender {
    self.mynewUserName = self.inputUserNameTextField.text;
}

- (IBAction)setNewUserPassword:(UITextField *)sender {
    self.mynewUserPassword = self.inputPasswordTextField.text;
}

- (IBAction)setNewRePassword:(UITextField *)sender {
    if ([self.inputRePasswordTextField.text isEqualToString:self.mynewUserPassword]) {
        self.isTwoPasswordMatch = YES;
    }
    else{
        self.isTwoPasswordMatch = NO;
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Wrong Passworld"
                                           message:@"Input password do not match!!!"
                                          delegate:nil
                                 cancelButtonTitle:@"Retry"
                                 otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)bindWithClemsonAccount:(UIButton *)sender {
}
- (IBAction)createNewAccount:(UIButton *)sender {
    if (self.isTwoPasswordMatch) {
        NSString *searchURL =[NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/createNewUser.php?userName=%@&userPassword=%@",self.mynewUserName,self.mynewUserPassword];
        NSData *resultData = [GetMethodsConnect getContentFromPhp:searchURL];
        NSString *resultString = [[NSString alloc] initWithData:resultData
                                                       encoding:NSUTF8StringEncoding];
        NSLog(@"%@",resultString);
        if([resultString isEqualToString:@"yes"])
        {
            //[self performSegueWithIdentifier:@"signUpLogin" sender:nil];
            SearchBookViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
            [self.navigationController pushViewController:next animated:NO];
            [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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

//#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
 

*/

@end
