//
//  ChangeUserPasswordViewController.m
//  Viewtext
//
//  Created by HuangChao on 14/10/23.
//  Copyright (c) 2014年 Clemson. All rights reserved.
//

#import "ChangeUserPasswordViewController.h"
#import "GetMethodsConnect.h"
@interface ChangeUserPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstPasswordTextView;
@property (weak, nonatomic) IBOutlet UITextField *secondPasswordTextView;
@property (weak, nonatomic) IBOutlet UILabel *currentPasswordLabel;

@property (nonatomic) BOOL correctNewPassword;
@property (nonatomic) NSArray *currentUserInfo;

@end

@implementation ChangeUserPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpForDismissKeyboard];

    NSString *basic_URL = [NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/getUserInfoByID.php?userID=%d",self.currentUserID];
    
    NSData *resultData = [GetMethodsConnect getContentFromPhp:basic_URL];
    
    self.currentUserInfo =[NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:nil];
    
    self.currentPasswordLabel.text = [self.currentUserInfo objectAtIndex:2];
    
}
- (IBAction)isPasswordCorrent:(id)sender {
    if ([self.firstPasswordTextView.text isEqualToString:self.secondPasswordTextView.text])
        self.correctNewPassword = YES;
    else{
        self.correctNewPassword = NO;
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Wrong Passworld"
                                           message:@"Input password do not match!!!"
                                          delegate:nil
                                 cancelButtonTitle:@"Retry"
                                 otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)changPasswordBt:(id)sender {
    if (self.correctNewPassword) {
        NSString *basic_URL = [NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/updateUserInfoByID.php?userID=%d&changeItem=userPassword&changeContent=%@",self.currentUserID,self.firstPasswordTextView.text];
        NSData *resultData =  [GetMethodsConnect getContentFromPhp:basic_URL];
        
        NSString *resultString = [[NSString alloc] initWithData:resultData
                                                       encoding:NSUTF8StringEncoding];
        if ([resultString isEqualToString:@"yes"]){
            //[self.delegate editingInfoWasFinished];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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


@end
