//
//	CGPDFDocument.h
//	Reader v2.8.6
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2015 Julius Oklamcak. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

//
//	Custom CGPDFDocument[...] functions
//

CGPDFDocumentRef CGPDFDocumentCreateUsingUrl(CFURLRef theURL, NSString *password);

CGPDFDocumentRef CGPDFDocumentCreateUsingData(CGDataProviderRef dataProvider, NSString *password);

BOOL CGPDFDocumentUrlNeedsPassword(CFURLRef theURL, NSString *password);

BOOL CGPDFDocumentDataNeedsPassword(CGDataProviderRef dataProvider, NSString *password);
