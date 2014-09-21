//
//  ServiceConnector.h
//  Viewtext
//
//  Created by Chao Huang on 9/20/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceConnectorDelegate <NSObject>

- (void) requestReturnedData:(NSData *)data;

@end

@interface ServiceConnector : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ServiceConnectorDelegate> delegate;

- (void) getTest;
- (void) postTest;

@end
