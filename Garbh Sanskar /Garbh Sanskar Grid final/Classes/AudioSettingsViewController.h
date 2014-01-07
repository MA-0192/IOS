//
//  AudioSettingsViewController.h
//  iChant
//
//  Created by User on 2/21/13.
//
//

#import <UIKit/UIKit.h>
//#import "RootViewController.h"

@protocol AudioSettingsDelegate <NSObject>
-(void)reflectSettingsChanges;

@end

@interface AudioSettingsViewController : UIViewController

@property (strong, nonatomic) id<AudioSettingsDelegate>delegate;

@property (strong, nonatomic) IBOutlet UITableView *tableViewAudioSettings;
@property (strong, nonatomic)	NSIndexPath *lastIndexPath;
@property (nonatomic)	    NSInteger selectedRow;
@property (strong, nonatomic) NSMutableArray *languageArray;
@property (strong, nonatomic) IBOutlet UIPickerView  *numberPicker;
@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) NSMutableArray *selectedAudioSettingArray;
@property (strong, nonatomic) NSMutableArray *audioSettingsType;
@property (strong, nonatomic) NSMutableArray *numberOfTimesArray;
@property (nonatomic) NSInteger noOfTimes;
@property (nonatomic) NSInteger selectedAudioSetting;
@property (strong, nonatomic) IBOutlet UIDatePicker *timeDurationPicker;
@property (strong, nonatomic) NSMutableArray *numberOfSecondArray;
@property (nonatomic) NSInteger noOfSecs;
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewBG;

-(IBAction) timeDurationPickerValueChanged;
-(IBAction)doneButtonPressed:(id)sender;

@end
