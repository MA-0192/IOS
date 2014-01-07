//
//  CustomImageUrl.h
//  Demo
//
//  Created by admin on 18/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "iChantAppDelegate.h"
#import <UIKit/UIKit.h>
@class AppDelegate;

@interface CustomImageUrl : UIView
{
    id parent;
	
	NSURLConnection *connection;
	NSMutableData* data;
	UIActivityIndicatorView *startupActivityIndicator;
	int indexInt;
	iChantAppDelegate *appDel;
    BOOL current;
}
@property (nonatomic,retain)id parent;
@property(nonatomic,assign)BOOL current;
//@property(nonatomic,retain)UIViewController *currentviewcontroller; 

- (void)loadImageFromURL:(NSURL*)url ForIndex:(int)index;
@end
