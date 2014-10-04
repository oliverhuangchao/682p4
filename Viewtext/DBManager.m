//
//  DBManager.m
//  Viewtext
//
//  Created by Chao Huang on 10/4/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>
@interface DBManager()

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;

@property (nonatomic, strong) NSMutableArray *arrResults;

- (void) copyDatabaseIntoDocumentsDirectory;
- (void) runQuery:(const char*) query isQueryExecutable:(BOOL)queryExecutable;

@end

@implementation DBManager

-(instancetype) initWithDatabaseFilename:(NSString *)dbFilename
{
    self = [super init];
    if (self)
    {
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [path objectAtIndex:0];
        self.databaseFilename = dbFilename;
        [self copyDatabaseIntoDocumentsDirectory];
        
    }
    return self;
}

-(void) copyDatabaseIntoDocumentsDirectory{
    NSString* destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        if (error != nil) {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
}

-(void) runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable{
    /*
    sqlite3 *sqlite3Database;
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if(self.arrResults != nil)
    {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults =[[NSMutableArray alloc] init];
    
    if (self.ArrColumnNames != nil) {
        [self.ArrColumnNames removeAllObjects];
        self.ArrColumnNames = nil;
    }
    self.ArrColumnNames = [[NSMutableArray alloc] init];
    
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if (openDatabaseResult == SQLITE_OK) {
        sqlite3_stmt *compiledStatement;

        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        
        if (prepareStatementResult == SQLITE_OK) {
            NSMutableArray *arrDataRow;
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                arrDataRow = [[NSMutableArray alloc] init];
                int totalColumns = sqlite3_column_count(compiledStatement);
                for (int i = 0; i< totalColumns ; i++)
                {
                    char  *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                    if (dbDataAsChars != NULL) {
                        [arrDataRow addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                    }
                    if (self.ArrColumnNames.count != totalColumns) {
                        dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                        [self.ArrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                    }
                }
                if (arrDataRow.count > 0) {
                    [self.arrResults addObject:arrDataRow];
                }
            }
        }
        else{
            
            BOOL executeQueryResults = sqlite3_step(compiledStatement);
            if (executeQueryResults == SQLITE_DONE) {
                self.affectedRows = sqlite3_changes(sqlite3Database);
                self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
            }
            else{
                NSLog(@"DB Error: %s",sqlite3_errmsg(sqlite3Database));
            }
        }
        sqlite3_finalize(compiledStatement);
    
    }
    else{
        NSLog(@"%s",sqlite3_errmsg(sqlite3Database));
    }
    sqlite3_close(sqlite3Database);
    */
    
    // Create a sqlite object.
    sqlite3 *sqlite3Database;
    
    // Set the database file path.
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    // Initialize the results array.
    if (self.arrResults != nil) {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults = [[NSMutableArray alloc] init];
    
    // Initialize the column names array.
    if (self.arrColumnNames != nil) {
        [self.arrColumnNames removeAllObjects];
        self.arrColumnNames = nil;
    }
    self.arrColumnNames = [[NSMutableArray alloc] init];
    
    
    // Open the database.
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if(openDatabaseResult == SQLITE_OK) {
        // Declare a sqlite3_stmt object in which will be stored the query after having been compiled into a SQLite statement.
        sqlite3_stmt *compiledStatement;
        
        // Load all data from database to memory.
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        if(prepareStatementResult == SQLITE_OK) {
            // Check if the query is non-executable.
            if (!queryExecutable){
                // In this case data must be loaded from the database.
                
                // Declare an array to keep the data for each fetched row.
                NSMutableArray *arrDataRow;
                
                // Loop through the results and add them to the results array row by row.
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    // Initialize the mutable array that will contain the data of a fetched row.
                    arrDataRow = [[NSMutableArray alloc] init];
                    
                    // Get the total number of columns.
                    int totalColumns = sqlite3_column_count(compiledStatement);
                    
                    // Go through all columns and fetch each column data.
                    for (int i=0; i<totalColumns; i++){
                        // Convert the column data to text (characters).
                        char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                        
                        // If there are contents in the currenct column (field) then add them to the current row array.
                        if (dbDataAsChars != NULL) {
                            // Convert the characters to string.
                            [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                        }
                        
                        // Keep the current column name.
                        if (self.arrColumnNames.count != totalColumns) {
                            dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                            [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                        }
                    }
                    
                    // Store each fetched data row in the results array, but first check if there is actually data.
                    if (arrDataRow.count > 0) {
                        [self.arrResults addObject:arrDataRow];
                    }
                }
            }
            else {
                // This is the case of an executable query (insert, update, ...).
                
                // Execute the query.
                BOOL executeQueryResults = sqlite3_step(compiledStatement);
                if (executeQueryResults == SQLITE_DONE) {
                    // Keep the affected rows.
                    self.affectedRows = sqlite3_changes(sqlite3Database);
                    
                    // Keep the last inserted row ID.
                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                }
                else {
                    // If could not execute the query show the error message on the debugger.
                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
                }
            }
        }
        else {
            // In the database cannot be opened then show the error message on the debugger.
            NSLog(@"%s", sqlite3_errmsg(sqlite3Database));
        }
        
        // Release the compiled statement from memory.
        sqlite3_finalize(compiledStatement);
        
    }
    
    // Close the database.
    sqlite3_close(sqlite3Database);

}

- (NSArray *)loadDataFromDB:(NSString *)query{
    
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    
    return (NSArray *) self.arrResults;
}


- (void) executeQuery:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}




































@end


