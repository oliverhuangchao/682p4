//
//  BorrowDetailViewController.m
//  Viewtext
//
//  Created by Chao Huang on 10/8/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "BorrowDetailViewController.h"
#import "GetMethodsConnect.h"

@interface BorrowDetailViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *currentUserTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *borrowDaysTextView;
@property (weak, nonatomic) IBOutlet UILabel *totalCostLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookProfilePicture;

@property (nonatomic) NSInteger singlePrice;


@end

@implementation BorrowDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpForDismissKeyboard];

    self.currentUserTitleLabel.title = self.currentUserName;
    
    NSString *bookProfilePictureName = [self.searchedBookInfo objectAtIndex:4];
    NSLog(@"%@",bookProfilePictureName);
    self.bookProfilePicture.image = [self getUIImageFromUrlString:bookProfilePictureName];
   
    self.singlePrice = [[self.searchedBookInfo objectAtIndex:5] integerValue];
    self.bookID = [[self.searchedBookInfo objectAtIndex:0] integerValue];
}


- (IBAction)submitRequest:(id)sender {
    
    NSString *searchURL =[NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/borrowBook.php?userid=%d&bookid=%d&keepDays=%d"
                          ,self.currentUserID
                          ,self.bookID
                          ,self.keepDays
                          ];
    
    NSData *resultData = [GetMethodsConnect getContentFromPhp:searchURL];

    NSString *showResult = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",showResult);

    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"submitted"
                                       message:@"you have submitted the request"
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles: nil];
    [alert show];
}

- (IBAction)getReturnDays:(id)sender {
    self.keepDays = [self.borrowDaysTextView.text integerValue];
    self.totalCostLabel.text = [NSString stringWithFormat:@"Cost: 💰 %d",self.keepDays*self.singlePrice];
}

-(UIImage *) getUIImageFromUrlString: (NSString *) tmpURLString;
{
    NSString *commonPicString = @"http://people.cs.clemson.edu/~chaoh/ios/pic/";
    NSString *picUrlString = [commonPicString stringByAppendingString: tmpURLString];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: picUrlString]];
    UIImage * returnImage = [UIImage imageWithData:imageData];
    return returnImage;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
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
