//
//  ChangeUserNameViewController.m
//  Viewtext
//
//  Created by HuangChao on 14/10/23.
//  Copyright (c) 2014年 Clemson. All rights reserved.
//

#import "ChangeUserNameViewController.h"
#import "ChangeUserSelectedItemViewController.h"
@interface ChangeUserNameViewController ()

//@property (weak, nonatomic) IBOutlet UINavigationItem *titleNavBar;
@property (weak, nonatomic) IBOutlet UILabel *currentUserNameLabel;


@end


@implementation ChangeUserNameViewController

@synthesize currentUserNameLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.titleNavBar.title = @"name";
    self.currentUserNameLabel.text = self.currentUserName;
   // ChangeUserSelectedItemViewController *parentBarController = (ChangeUserSelectedItemViewController *)self.tabBarController;
   // self.currentUserNameLabel.text = self.currentUserName;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
