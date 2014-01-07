//
//  SettingsController.h
//  iChant
//
//  Created by User on 2/21/13.
//
//

#import <UIKit/UIKit.h>
#import "GlobalValues.h"
#import "RootViewController.h"

@protocol SettingsViewDelegate <NSObject>
-(void)reflectSettingsChanges;
@end

@interface SettingsController : UIViewController


@property (strong, nonatomic) id<SettingsViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableViewSettings;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

-(IBAction)doneButtonPressed:(id)sender;

@end
