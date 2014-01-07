//
//  ichantAppDelegate.h
//  ichant
//
//  Created by Abhijeet Barge on 12/18/09.
//  Copyright __eBusinessware india pvt.ltd.__ 2010. All rights reserved.
//

#import "ViewController1.h"
#import "RootViewController.h"

@class GlobalValues;

@interface iChantAppDelegate : NSObject <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) ViewController1 *objViewController1;
@property (strong, nonatomic) RootViewController *objRootViewController;
@property (strong, nonatomic) UINavigationController *mNavigationController;

@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSMutableArray *narrations;
@property (strong, nonatomic) NSMutableArray *displayLanguages;
@property (strong, nonatomic) NSMutableArray *beadsArray;
@property (strong, nonatomic) NSMutableArray *malasArray;
@property (strong, nonatomic) NSMutableArray *selectedAudioSettingArray;
@property (strong, nonatomic) NSMutableArray *numberOfTimesArray;
@property (strong, nonatomic) NSMutableArray *numberOfSecondArray;


@end

