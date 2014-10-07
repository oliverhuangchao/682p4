//
//  DBManager.h
//  Viewtext
//
//  Created by Chao Huang on 10/4/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

- (instancetype) initWithDatabaseFilename:(NSString *) dbFilename;


@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;


-(NSArray *)loadDataFromDB:(NSString *)query;

- (void) executeQuery:(NSString *)query;


@end
