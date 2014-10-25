//
//  ChangeUserNameViewController.m
//  Viewtext
//
//  Created by HuangChao on 14/10/23.
//  Copyright (c) 2014年 Clemson. All rights reserved.
//

#import "ChangeUserNameViewController.h"
//#import "ChangeUserSelectedItemViewController.h"
#import "GetMethodsConnect.h"


@interface ChangeUserNameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentUserNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;

@end


@implementation ChangeUserNameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameText.delegate = self;
    self.currentUserNameLabel.text = self.currentUserName;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)ChangeUserNameBt:(id)sender {
    NSString *basic_URL = [NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/updateUserInfoByID.php?userID=%d&changeItem=userName&changeContent=%@",self.currentUserID,self.userNameText.text];
    
    NSData *resultData = [GetMethodsConnect getContentFromPhp:basic_URL];

    NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",basic_URL);
    if([resultString isEqualToString:@"yes"]){
        [self.delegate editingInfoWasFinished];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"fail");
    }
}



@end
