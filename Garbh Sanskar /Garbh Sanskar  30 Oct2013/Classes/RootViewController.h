//
//  RootViewController.h
//  ichant
//
//  Created by Abhijeet Barge on 12/18/09.
//  Copyright 2009 __eBusinessware india pvt.ltd.__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "AudioSettingsViewController.h"

@interface RootViewController : UIViewController <AVAudioPlayerDelegate, UIApplicationDelegate,MFMailComposeViewControllerDelegate,AudioSettingsDelegate,UIWebViewDelegate>

@property (nonatomic) int selectedRow;
@property (strong, nonatomic) NSString *strNavigationTitle;
@property (strong, nonatomic) IBOutlet UITextView *txtViewInfoText;
@property (strong, nonatomic) IBOutlet UIButton *btnOtherApps;
@property (strong, nonatomic) IBOutlet UIButton *btnWebsite;
@property (strong, nonatomic) IBOutlet UIButton *btnFeedback;
@property (strong, nonatomic) IBOutlet UITextView *txtViewAudioText;
@property (strong, nonatomic) NSMutableArray *selectedAudioSettingArray;
@property (strong, nonatomic) NSMutableArray *numberOfSecondArray;
@property (strong, nonatomic) NSMutableArray *numberOfTimesArray;
@property (nonatomic) NSInteger selectedAudioSettingIndex;
@property (nonatomic) NSInteger noOfTimes;
@property (nonatomic) NSInteger noOfSecs;
@property (nonatomic) NSInteger noOfLoops;
@property (strong,nonatomic) NSMutableArray *narrations;
@property (strong,nonatomic) NSMutableArray *displayLanguages;
@property (strong, nonatomic) NSString *strAudioName;
@property (strong,nonatomic)AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSString *strImageName;
@property (strong, nonatomic) IBOutlet UILabel *lblCopyRight;
@property (strong, nonatomic) IBOutlet UILabel *lblAudioCopyRight;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewSettingsBackground;
@property (strong, nonatomic) NSString *strBeadArrayKey;
@property (strong, nonatomic) NSString *strMalaArrayKey;
@property (nonatomic) int intDatePickerValue;

@property(nonatomic,strong)	IBOutlet UIButton               *langSettingButton;
@property(nonatomic,strong)	IBOutlet UITableView            *settingTable;
@property(nonatomic,strong) UIButton                        *playModeButton;
@property(nonatomic,strong) IBOutlet UIPickerView           *numberPicker;
@property(nonatomic,strong) IBOutlet UIDatePicker           *timePicker;
@property(nonatomic,strong) NSArray                         *pickerData;
@property(nonatomic,strong) NSIndexPath                     *lastIndexPath;
@property(nonatomic,strong) NSMutableArray                  *playModeArray;
@property(nonatomic,strong) NSMutableArray                  *numberLoopsArray;
@property(nonatomic,strong) NSMutableArray                  *timeIntervalArray;
@property(nonatomic,strong) NSMutableArray                  *audioCurrentTimeArray;
@property(nonatomic,strong) NSMutableArray                  *languageArray;
@property(nonatomic,strong)	NSMutableArray                  *introStateArray;

@property(nonatomic,strong)IBOutlet UIView                  *settingView;


@property (nonatomic,strong) IBOutlet UIBarButtonItem       *doneButton;
@property (nonatomic,strong) IBOutlet UIBarButtonItem       *langSettingsBarButton;
@property (nonatomic,strong) UIBarButtonItem                *barBackButton;
@property (nonatomic,strong) UIBarButtonItem                *flipButton;
@property (nonatomic,strong) UIBarButtonItem                *langSetButton;
@property (nonatomic,strong) IBOutlet UIView                *instructionsView;


@property(nonatomic) NSInteger                               pickerValue;
@property(nonatomic) NSInteger                               playModeInt;
@property(nonatomic)NSInteger                                introState;
@property(nonatomic)NSInteger                                languageState;
@property(nonatomic,strong)NSString                          *hours;
@property(nonatomic,strong)NSString                          *minute;
@property(nonatomic)NSInteger                                hoursInInt ;
@property(nonatomic)NSInteger                                minuteInInt;
@property(nonatomic)NSInteger                                secondsInInt;
@property(nonatomic,strong)NSString                          *second;
@property(nonatomic) NSInteger                               iLeftNumberOfLoops;
@property(nonatomic) NSInteger                               iLeftTimeInterval;


@property(nonatomic) NSInteger                               iPlayMode;
@property(nonatomic) NSInteger                               iNumberLoops;
@property(nonatomic) NSInteger                               iPlayedNumberLoops;
@property(nonatomic) NSInteger                               iTimeInterval;
@property(nonatomic) NSInteger                               iPlayedTimeInterval;
@property(nonatomic) NSInteger                               timeInSeconds;
@property(nonatomic,strong) NSTimer                          *countLoopTimer;
@property(nonatomic,strong) IBOutlet UILabel                 *counterLabel;
@property(nonatomic,strong) IBOutlet UILabel                 *labelmode;
@property(nonatomic,strong)	IBOutlet UILabel                 *nameLabel;
@property(nonatomic,strong) UIImage                          *playBtnBG;
@property(nonatomic,strong) UIImage                          *pauseBtnBG;
@property(nonatomic,strong) UIImage                          *resetBtnBG;

@property(nonatomic,strong)NSString                          *filePath;
@property(nonatomic,strong) NSMutableArray                   *beadArray;
@property(nonatomic,strong) NSMutableArray                   *malaArray;
@property(nonatomic,strong) IBOutlet UIButton                *playButton;
@property(nonatomic,strong) IBOutlet UIButton                *resetButton;
@property(nonatomic,strong) IBOutlet UIImageView             *mainImage;
@property(nonatomic,strong) IBOutlet UILabel                 *beadCounter;
@property(strong,nonatomic) IBOutlet UILabel                 *malaText;
@property(nonatomic,strong) IBOutlet UILabel                 *malaCounter;
@property(nonatomic,strong) NSString                         *imageName;
@property(nonatomic) NSInteger                               ibeadCounter;
@property(nonatomic) NSInteger                               imalaCounter;
@property(nonatomic) NSInteger                               tableRow;
@property(nonatomic,strong) NSTimer                          *updateTimer;
@property(nonatomic,strong)NSUserDefaults                    *userDefaultObj;
@property(nonatomic,strong)	NSArray                          *timeArray;
@property(nonatomic)	NSInteger                            timeIndex;
@property(nonatomic)	NSInteger                            timeFactor;

@property(nonatomic,strong) IBOutlet UILabel                 *beadText;

@property (nonatomic,strong)IBOutlet UISlider                *progressBar;
@property (nonatomic,strong)IBOutlet UILabel                 *playedTimeLabel;
@property (nonatomic,strong)IBOutlet UILabel                 *remainingTimeLabel;
@property (nonatomic,strong)NSTimer                          *tempTimer;

@property(nonatomic) BOOL isPlaying;

@property (strong, nonatomic) IBOutlet UIButton              *btnSettings;
@property (strong, nonatomic) NSString *strAudioPlaySetting;
@property (strong, nonatomic) NSString *strNarrationSetting;

@property (strong, nonatomic) IBOutlet UIImageView *imgViewAudioMode;
@property (strong, nonatomic) IBOutlet UIButton *btnFacebook;
@property (strong, nonatomic) IBOutlet UIButton *btnTwitter;

@property (strong, nonatomic) IBOutlet UIImageView *imgViewPoojaPresents;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewAppIcon;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewFountainIcon;
@property (strong, nonatomic) IBOutlet UIWebView *webViewAppText;

//POPOVER
@property (strong, nonatomic) UIPopoverController *popOverController;
@property (strong, nonatomic) UIPopoverController *mPopOverController;


- (void)flipAction:(id)sender;
-(IBAction)otherAppsButtonPressed:(UIButton *)sender;
-(IBAction)websiteButtonPressed:(UIButton *)sender;

-(IBAction)playButtonPressed:(UIButton *)sender ;
-(IBAction)resetButtonPressed:(UIButton *)sender;
-(void)setupAudioSession;
-(void)adjustPlayTime;
-(IBAction)flipIntroLangSetting:(id)sender;
-(void)updateSlider;
-(IBAction) sliderMoved;
-(void)popViewController;
-(void) refreshView;

-(void)playAudioAccordingToSettings;

-(void)changeViewForPortraitMode;
-(void)changeViewForLandscapeMode;

-(IBAction)btnFacebookClicked;
-(IBAction)btnTwitterClicked;
-(IBAction)btnFeedbackClicked;

-(void)AppText : (NSInteger)selectedRow;

@end









