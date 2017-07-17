//
//	ReaderContentView.h
//	Reader v2.8.6
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2015 Julius Oklamcak. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "ReaderThumbView.h"

@class ReaderContentView;
@class ReaderContentPage;
@class ReaderContentThumb;

@protocol ReaderContentViewDelegate <NSObject>

@required // Delegate protocols

- (void)contentView:(ReaderContentView *)contentView touchesBegan:(NSSet *)touches;

@end

@interface ReaderContentView : UIScrollView

@property (nonatomic, weak, readwrite) id <ReaderContentViewDelegate> message;

- (instancetype)initWithFrame:(CGRect)frame fileURL:(NSURL *)fileURL page:(NSUInteger)page password:(NSString *)phrase;

- (void)showPageThumb:(NSURL *)fileURL page:(NSInteger)page password:(NSString *)phrase guid:(NSString *)guid;

- (id)processSingleTap:(UITapGestureRecognizer *)recognizer;

- (void)zoomIncrement:(UITapGestureRecognizer *)recognizer;
- (void)zoomDecrement:(UITapGestureRecognizer *)recognizer;
- (void)zoomResetAnimated:(BOOL)animated;

@end

#pragma mark -

//
//	ReaderContentThumb class interface
//

@interface ReaderContentThumb : ReaderThumbView

@end
