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

@property (weak, nonatomic) IBOutlet UILabel *TestLabel;


@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *userPassword;

@end

@implementation LoginViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.confirmLoginButtonLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tigerPaw"]];
    
    // Do any additional setup after loading the view.
}

- (IBAction)userNameChanged:(UITextField *)sender {
    self.userName = self.userNameTextField.text;
}

- (IBAction)userPasswordChanged:(UITextField *)sender {
    self.userPassword = self.userPasswordTextField.text;
}

- (IBAction)confirmLoginButton:(UIButton *)sender {
    
    NSString *searchURL =[NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/searchName.php?userName=%@&userPassword=%@",self.userName,self.userPassword];
  
    NSData *resultData = [GetMethodsConnect getContentFromPhp:searchURL];
    
    NSString *resultString = [[NSString alloc] initWithData:resultData
                                                  encoding:NSUTF8StringEncoding];
    //self.TestLabel.text = resultString;
    
    NSLog(resultString);
    /*
    if ([resultString isEqual: @"yes"]){
        [self performSegueWithIdentifier:@"successfulSegue" sender:nil];
    }
    else{
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"testmassage"
                                                        message:"helloworld"
                                                      delegatee:nil
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
     */
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
