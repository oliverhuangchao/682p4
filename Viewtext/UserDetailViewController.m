//
//  UserDetailViewController.m
//  Viewtext
//
//  Created by Chao Huang on 10/5/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "UserDetailViewController.h"
#import "SearchBookViewController.h"
#import "UIViewViewController.h"
#import "DBManager.h"
#import "GetMethodsConnect.h"


@interface UserDetailViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *userNameLabel;

@property (nonatomic,strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrPeopleInfo;

- (void) loadLocalUserInfor;


@end


@implementation UserDetailViewController

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
    
    self.userNameLabel.title = [NSString stringWithFormat:@"%@ History", self.currentUserName];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"mynewdb.sql"];
    
    self.searchedBookHistoryTableView.delegate = self;
    self.searchedBookHistoryTableView.dataSource = self;
    
   
    //[self tempAddData];
    [self loadLocalUserInfor];
  
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    // Get the book ID and find the book detail in remote database;

    NSInteger indexofBookID = [self.dbManager.arrColumnNames indexOfObject:@"bookID"];
    NSInteger bookID = [[[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexofBookID] integerValue];
    
    NSString *basic_URL = [NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/searchBookByID.php?bookID=%d",bookID];
    
    NSData *resultData = [GetMethodsConnect getContentFromPhp:basic_URL];
    
    NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:nil];
    
    self.selectedBookInfo =[[NSMutableArray alloc] initWithArray:[resultArray objectAtIndex:0]];

    // Perform the segue.
    [self performSegueWithIdentifier:@"goToLocalBookDetailPage" sender:self];
}

/*
-(void) tempAddData{
    NSString *query;
    
    query = [NSString stringWithFormat:@"insert into localUser values(1,'chaoh');"];
    [self.dbManager executeQuery:query];
    
    query = [NSString stringWithFormat:@"insert into localBook values(1,'hello world',10);"];
    [self.dbManager executeQuery:query];
    
    query = [NSString stringWithFormat:@"insert into localHistory values(1,1,1,'2014');"];
    [self.dbManager executeQuery:query];
}
*/
- (IBAction)goToSearchPage:(id)sender {
    [self performSegueWithIdentifier:@"searchBookSegue" sender:nil];
}

- (IBAction)clearHistoryButton:(id)sender {
    NSString *query;
    query = [NSString stringWithFormat:@"delete from localHistory where userID = '%d';",self.currentUserID];
    [self.dbManager executeQuery:query];
    [self.searchedBookHistoryTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrPeopleInfo.count;
}


- (void) loadLocalUserInfor
{
    NSString *query;

    query = [NSString stringWithFormat:@"select * from localUser where userName = '%@';",self.currentUserName];
    
    NSArray *isCurrentUserExist = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    if (isCurrentUserExist.count!= 0) {
        NSLog(@"find user  %@", self.currentUserName);
        query = [NSString stringWithFormat:@"select b.bookName, h.searchDate,b.bookID from localHistory h, localUser u,localBook b where u.userID = h.userID and h.bookID = b.bookID and u.userName = '%@'",self.currentUserName];

        self.arrPeopleInfo = [self.dbManager loadDataFromDB:query];
        
        if (self.arrPeopleInfo.count != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.arrPeopleInfo.count);
            
        }
        else{
            NSLog(@"Could not execute the query.");
        }
        
        //self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        
        [self.searchedBookHistoryTableView reloadData];
    }
    else{
        NSLog(@"create a new user!!!");
        query = [NSString stringWithFormat:@"insert into localUser values(%d,'%@');",self.currentUserID,self.currentUserName];
        [self.dbManager executeQuery:query];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    NSInteger indexOfBookName = [self.dbManager.arrColumnNames indexOfObject:@"bookName"];
    NSInteger indexOfBookDate = [self.dbManager.arrColumnNames indexOfObject:@"searchDate"];
    
    //NSLog([self.dbManager.arrColumnNames objectAtIndex:0]);
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfBookName]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Search Date is: %@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfBookDate]];
    return cell;
}

- (void) updateTableView{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString: @"searchBookSegue"]){
        SearchBookViewController *controller = (SearchBookViewController *)segue.destinationViewController;
        controller.userName = self.currentUserName;
        controller.localUserID = self.currentUserID;
    }
    if([segue.identifier isEqualToString: @"goToLocalBookDetailPage"]){
        UIViewViewController *controller = (UIViewViewController *)segue.destinationViewController;
        controller.localUserName = self.currentUserName;
        controller.searchedBookInfo = self.selectedBookInfo;
    }
}

@end
