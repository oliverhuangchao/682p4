//
//  SearchBookViewController.m
//  Viewtext
//
//  Created by Chao Huang on 9/21/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "SearchBookViewController.h"
#import "GetMethodsConnect.h"

@interface SearchBookViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchBookNameTextField;


@property (nonatomic) NSString *searchBookPartName;
@property (nonatomic) NSMutableArray *bookListArray;

@property (nonatomic) NSMutableArray *resultBookName;
@property (nonatomic) NSMutableArray *resultBookProfile;
@property (nonatomic) NSMutableArray *resultBookOwner;
@property (nonatomic) NSMutableArray *resultBookStatus;
@property (nonatomic) NSMutableArray *resultBookValue;


@property (nonatomic) NSMutableArray *bookProfilePic;

@property (weak, nonatomic) IBOutlet UITableView *searchBookTableView;

@property (weak, nonatomic) IBOutlet UILabel *showBookCountLabel;


@end

@implementation SearchBookViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.bookListArray  = [NSMutableArray arrayWithObjects:@"hello",@"world",@"chaoh", nil];
    //self.bookProfilePic  = [NSMutableArray arrayWithObjects:@"hello",@"world",@"chaoh", nil];

    
    self.bookListArray = [[NSMutableArray alloc] init];
    self.bookProfilePic = [[NSMutableArray alloc] init];

    
    self.resultBookName = [[NSMutableArray alloc] init];
    self.resultBookProfile = [[NSMutableArray alloc] init];
    self.resultBookStatus = [[NSMutableArray alloc] init];
    self.resultBookValue = [[NSMutableArray alloc] init];


    //self.resultBookName  = [NSMutableArray arrayWithObjects:@"hello",@"world",@"chaoh", nil];
    [self setUpForDismissKeyboard];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bookListArray count];
}


- (UITableView *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"simpleTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    cell.textLabel.text = [self.bookListArray objectAtIndex:indexPath.row];
    
    NSString *commonString = @"http://people.cs.clemson.edu/~chaoh/ios/pic/";
    
    for (int i = 0; i < self.resultBookName.count;i++)
    {
        NSString *picUrlString = [commonString stringByAppendingString:[self.resultBookProfile objectAtIndex:i]];

        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: picUrlString]];
        
        [self.bookProfilePic addObject:[UIImage imageWithData:imageData]];
    }
    
    cell.imageView.image = [self.bookProfilePic objectAtIndex:indexPath.row];
    
    return cell;
}


- (IBAction)searchBookNameClearName:(UITextField *)sender {
    self.searchBookNameTextField.text = @"";
}


-(void) removeAllFromArray
{
    [self.bookListArray removeAllObjects];
    [self.resultBookName removeAllObjects];
    [self.resultBookOwner removeAllObjects];
    [self.resultBookProfile removeAllObjects];
    [self.resultBookStatus removeAllObjects];
    [self.resultBookValue removeAllObjects];
    [self.bookProfilePic removeAllObjects];

}

- (IBAction)searchBookNameGetResult:(UITextField *)sender {
    [self removeAllFromArray];
    
    self.searchBookPartName = self.searchBookNameTextField.text;
    
    NSString *basic_URL = [NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/searchBook.php?bookName=%@",self.searchBookPartName];
    
    NSData *resultData = [GetMethodsConnect getContentFromPhp:basic_URL];
 
    NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:nil];
    
    for (int i = 0;i<resultArray.count;i++)
    {
        //[self.bookListArray addObject:[[resultArray objectAtIndex:i] objectAtIndex:1]];
        
        [self.resultBookName addObject:[[resultArray objectAtIndex:i] objectAtIndex:1]];

        [self.resultBookProfile addObject:[[resultArray objectAtIndex:i] objectAtIndex:4]];
        
        [self.resultBookOwner addObject:[[resultArray objectAtIndex:i] objectAtIndex:3]];
        
        [self.resultBookStatus addObject:[[resultArray objectAtIndex:i] objectAtIndex:7]];
        
        [self.resultBookValue addObject:[[resultArray objectAtIndex:i] objectAtIndex:6]];
    }
    
    
    NSString *finalShowString;
    for (int i = 0; i<self.resultBookName.count;i++){
        if ([[self.resultBookStatus objectAtIndex:i] isEqualToString:@"1"]) {
            finalShowString = [NSString stringWithFormat:@"%@, 📗 ,💰:%@",
                               [self.resultBookName objectAtIndex:i],
                               [self.resultBookValue objectAtIndex:i]];
        }
        else{
            finalShowString = [NSString stringWithFormat:@"%@, 📕 ,💰:%@",
                               [self.resultBookName objectAtIndex:i],
                               [self.resultBookValue objectAtIndex:i]];
        }
        NSLog(@"%@",finalShowString);
        [self.bookListArray addObject:finalShowString];
        
    }

    
    [self.searchBookTableView reloadData];
    self.showBookCountLabel.text = [NSString stringWithFormat:@"There are %d books in our store",self.resultBookName.count];
    
}


-(void) deaWithArray
{
    
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


/*
//pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
 
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

 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
