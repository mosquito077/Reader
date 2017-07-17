//
//	ReaderDocumentOutline.m
//	Reader v2.8.6
//
//	Created by Julius Oklamcak on 2012-09-01.
//	Copyright © 2011-2015 Julius Oklamcak. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ReaderDocumentOutline : NSObject <NSObject>

+ (NSArray *)outlineFromFileURL:(NSURL *)fileURL password:(NSString *)phrase;

+ (void)logDocumentOutlineArray:(NSArray *)array;

@end

@interface DocumentOutlineEntry : NSObject <NSObject>

+ (instancetype)newWithTitle:(NSString *)title target:(id)target level:(NSInteger)level;

@property (nonatomic, assign, readonly) NSInteger level;
@property (nonatomic, strong, readwrite) NSMutableArray *children;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) id target;

@end
