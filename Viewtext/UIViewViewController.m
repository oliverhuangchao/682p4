//
//  UIViewViewController.m
//  Viewtext
//
//  Created by Chao Huang on 9/8/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "UIViewViewController.h"

@interface UIViewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *LoveCountLabel;





@property (nonatomic) NSInteger LoveCount;
@end

@implementation UIViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.LoveCount = 0;
}



- (IBAction)addMoreLikePeopleNumber:(UIButton *)sender {
    self.LoveCount++;
    self.LoveCountLabel.text = [NSString stringWithFormat:@"😍: %d", self.LoveCount];
}

/*
- (IBAction)TouchToChangeTextContents:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

@end
