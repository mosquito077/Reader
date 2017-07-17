//
//	ReaderThumbQueue.h
//	Reader v2.8.6
//
//	Created by Julius Oklamcak on 2011-09-01.
//	Copyright © 2011-2015 Julius Oklamcak. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ReaderThumbQueue : NSObject <NSObject>

+ (ReaderThumbQueue *)sharedInstance;

- (void)addLoadOperation:(NSOperation *)operation;

- (void)addWorkOperation:(NSOperation *)operation;

- (void)cancelOperationsWithGUID:(NSString *)guid;

- (void)cancelAllOperations;

@end

#pragma mark -

//
//	ReaderThumbOperation class interface
//

@interface ReaderThumbOperation : NSOperation

@property (nonatomic, strong, readonly) NSString *guid;

- (instancetype)initWithGUID:(NSString *)guid;

@end
