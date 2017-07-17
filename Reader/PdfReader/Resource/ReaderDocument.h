//
//	ReaderDocument.h
//	Reader v2.8.6
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2015 Julius Oklamcak. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ReaderDocument : NSObject <NSObject, NSCoding>

@property (nonatomic, strong, readonly) NSString *guid;
@property (nonatomic, strong, readonly) NSDate *fileDate;
@property (nonatomic, strong, readwrite) NSDate *lastOpen;
@property (nonatomic, strong, readonly) NSNumber *fileSize;
@property (nonatomic, strong, readonly) NSNumber *pageCount;
@property (nonatomic, strong, readwrite) NSNumber *pageNumber;
@property (nonatomic, strong, readonly) NSMutableIndexSet *bookmarks;
@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, strong, readonly) NSString *fileName;
@property (nonatomic, strong, readonly) NSURL *fileURL;

@property (nonatomic, readonly) BOOL canEmail;
@property (nonatomic, readonly) BOOL canExport;
@property (nonatomic, readonly) BOOL canPrint;

+ (ReaderDocument *)withDocumentFilePath:(NSString *)filePath password:(NSString *)phrase;

+ (ReaderDocument *)unarchiveFromFileName:(NSString *)filePath password:(NSString *)phrase;

- (instancetype)initWithFilePath:(NSString *)filePath password:(NSString *)phrase;

- (BOOL)archiveDocumentProperties;

- (void)updateDocumentProperties;

@end
