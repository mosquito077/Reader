//
//	ReaderThumbRender.h
//	Reader v2.8.6
//
//	Created by Julius Oklamcak on 2011-09-01.
//	Copyright © 2011-2015 Julius Oklamcak. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "ReaderThumbQueue.h"

@class ReaderThumbRequest;

@interface ReaderThumbRender : ReaderThumbOperation

- (instancetype)initWithRequest:(ReaderThumbRequest *)options;

@end
