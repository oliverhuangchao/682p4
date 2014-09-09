//
//  UIViewViewController.m
//  Viewtext
//
//  Created by Chao Huang on 9/8/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "UIViewViewController.h"

@interface UIViewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *LoveCount;

@end

@implementation UIViewViewController
- (IBAction)LikeThisBook:(UIButton *)sender {
    
}
/*
- (IBAction)TouchToChangeTextContents:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

@end
