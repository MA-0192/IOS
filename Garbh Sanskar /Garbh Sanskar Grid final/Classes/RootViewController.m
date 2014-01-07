//
//  RootViewController.m
//  ichant
//
//  Created by Abhijeet Barge on 12/18/09.
//  Copyright 2009 __eBusinesware india pvt.ltd.__. All rights reserved.
//

#import "RootViewController.h"
#import "GlobalValues.h"
#import "SettingsController.h"
#import "Constants.h"
#import <Twitter/Twitter.h>
#import "FBConnect.h"
#import "wallpaperViewController.h"
NSString *kRestoreIntroVariable = @"RestoreIntro";
NSString *kRestoreLanguage = @"RestoreLanguage";
NSString *kRestoreBeadsKey = @"RestoreBeads";
NSString *kRestoreMalasKey = @"RestoreMalas";
NSString *kRestorePlayModeKey = @"RestorePlayMode";
NSString *kRestoreNoOfLoopsKey = @"RestoreNoOfLoops";
NSString *kRestoreTimeIntervalKey = @"RestoreTimeInterval";
NSString *kaudioCurrentTime = @"RestoreCurrentTime";


NSString *kPlayAllModeText = @"Play All";
NSString *kContinuousModeText = @"Continuous";
NSString *kNumberOfTimesModeText = @"Number Of Times";
NSString *kForTimeDurationModeText = @"For Time Duration";
NSString *kHrMinSecLabelText = @" HH   MM   SS";
NSInteger kClockMinsSecs = 59;

@implementation RootViewController
@synthesize fbObject,playBtnBG=_playBtnBG;
@synthesize selectedRow = _selectedRow;
@synthesize strNavigationTitle = _strNavigationTitle;
@synthesize txtViewInfoText = _txtViewInfoText;
@synthesize btnOtherApps = _btnOtherApps;
@synthesize btnWebsite = _btnWebsite;
@synthesize btnFeedback = _btnFeedback;
@synthesize txtViewAudioText = _txtViewAudioText;
@synthesize selectedAudioSettingArray = _selectedAudioSettingArray;
@synthesize numberOfSecondArray = _numberOfSecondArray;
@synthesize numberOfTimesArray = _numberOfTimesArray;
@synthesize selectedAudioSettingIndex = _selectedAudioSettingIndex;
@synthesize noOfTimes = _noOfTimes;
@synthesize noOfSecs = _noOfSecs;
@synthesize noOfLoops = _noOfLoops;
@synthesize narrations = _narrations;
@synthesize displayLanguages = _displayLanguages;
@synthesize strAudioName = _strAudioName;
@synthesize audioPlayer = _audioPlayer;
@synthesize url = _url;
@synthesize fileName = _fileName;
@synthesize strImageName = _strImageName;
@synthesize lblCopyRight = _lblCopyRight;
@synthesize lblAudioCopyRight = _lblAudioCopyRight;
@synthesize imgViewSettingsBackground = _imgViewSettingsBackground;
@synthesize strBeadArrayKey = _strBeadArrayKey;
@synthesize strMalaArrayKey = _strMalaArrayKey;
//@synthesize beadarray;
@synthesize playButton,resetButton,beadCounter,malaCounter,imageName,updateTimer,ibeadCounter,imalaCounter,tableRow,malaArray,filePath,userDefaultObj,playModeButton;
@synthesize malaText = _malaText;
@synthesize timeArray;
@synthesize timeIndex;
@synthesize timeFactor;
@synthesize mainImage;
@synthesize beadText;
@synthesize settingView;
@synthesize doneButton;
@synthesize settingTable;
@synthesize numberPicker;
@synthesize pickerData;
@synthesize timePicker;
@synthesize lastIndexPath;
@synthesize playModeArray,numberLoopsArray,timeIntervalArray;
@synthesize iPlayMode,iNumberLoops,iPlayedNumberLoops,iTimeInterval,iPlayedTimeInterval;
@synthesize countLoopTimer,counterLabel;
@synthesize minute,hours,second;
@synthesize hoursInInt,minuteInInt,secondsInInt;
@synthesize playModeInt,pickerValue;
@synthesize timeInSeconds;
@synthesize barBackButton = _barBackButton;
@synthesize langSettingButton;
@synthesize langSettingsBarButton;

@synthesize flipButton;
@synthesize langSetButton;
@synthesize instructionsView = _instructionsView;

@synthesize audioCurrentTimeArray;
@synthesize languageArray;
@synthesize introStateArray;
@synthesize introState,languageState;
@synthesize progressBar;
@synthesize playedTimeLabel;
@synthesize remainingTimeLabel;
@synthesize tempTimer;
@synthesize strAudioPlaySetting;
@synthesize strNarrationSetting;
@synthesize btnSettings = _btnSettings;
@synthesize intDatePickerValue = _intDatePickerValue;
@synthesize imgViewAudioMode = _imgViewAudioMode;

@synthesize popOverController = _popOverController;
@synthesize mPopOverController = _mPopOverController;

@synthesize imgViewAppIcon = _imgViewAppIcon;
@synthesize imgViewPoojaPresents = _imgViewPoojaPresents;
@synthesize imgViewFountainIcon = _imgViewFountainIcon;
@synthesize webViewAppText = _webViewAppText;

int y,audioCurrentTime=0;
bool _settingsClicked;

GlobalValues *globalValues;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _playBtnBG = [[UIImage imageNamed:@"play.png"] stretchableImageWithLeftCapWidth:11.0 topCapHeight:0.0];
    _pauseBtnBG = [[UIImage imageNamed:@"pause.png"] stretchableImageWithLeftCapWidth:11.0 topCapHeight:0.0];
       NSLog(@"%@",globalValues.marrForViewController1);
    
    UISwipeGestureRecognizer *recognizerRITE = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRITE)];
    [recognizerRITE setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:recognizerRITE];
    
    UISwipeGestureRecognizer *showExtrasSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(NextSwipe)];
    showExtrasSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:showExtrasSwipe];

    
    ////vivek start
    //   fbObject=[Facebook alloc];
    NSLog(@"%@",_strNavigationTitle);
    globalValues = [GlobalValues sharedManager];
   NSLog(@"%@",globalValues.marrForViewController1);
    
nextAudioVar =self.selectedRow;
  audioarray=[[NSMutableArray alloc]init];
   //   NSMutableArray *webViewarray=[[NSMutableArray alloc]init];
    for (int i=0; i<5; i++) {
        [audioarray addObject:[NSString stringWithFormat:@"main_menu_audio%d_Marathi",i]];
        
    }
    BOOL isAtLeast7 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
    
    if ( isAtLeast7 ) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    
    /////vivek end
    
    
    
    _settingsClicked=false;
    globalValues = [GlobalValues sharedManager];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    if(globalValues.boolSubMenuEnable)
    {
        self.title = [NSString stringWithFormat:@"%@",[[globalValues.marrForViewController2 objectAtIndex:[globalValues.strMainMenuSelectedRow intValue]]objectAtIndex:self.selectedRow]];
    }
    else{
        self.title = [NSString stringWithFormat:@"%@",[globalValues.marrForViewController1 objectAtIndex:self.selectedRow]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
        label.backgroundColor = [UIColor clearColor];
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            label.font = [UIFont fontWithName:@"Helvetica" size:22.0];
        else
            label.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor =[UIColor whiteColor];
        label.text=self.title;
        self.navigationItem.titleView = label;
    }
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            [self changeViewForPortraitMode];
        }
        else
        {
            [self changeViewForLandscapeMode];
        }
    }
    
    //self.txtViewInfoText.text = globalValues.strInfoText;
    self.lblCopyRight.text = globalValues.strCopyRightText;
    self.lblAudioCopyRight.text = globalValues.strAudioCopyRightText;
    
    if(globalValues.boolForInfoViewController1)
    {
        // add our custom flip button as the nav bar's custom right view
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [infoButton addTarget:self action:@selector(flipAction:) forControlEvents:UIControlEventTouchUpInside];
        self.flipButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        self.navigationItem.rightBarButtonItem = self.flipButton;
    }
    
    if(globalValues.boolLanguageSettingsButton)
    {
        langSettingsBarButton = [[UIBarButtonItem alloc] initWithCustomView:langSettingButton];
        self.navigationItem.rightBarButtonItem = langSettingsBarButton;
    }
	
    if(globalValues.boolAudioSlider)
    {
        self.progressBar.hidden = NO;
        self.playedTimeLabel.hidden = NO;
        self.remainingTimeLabel.hidden = NO;
    }
    else{
        self.progressBar.hidden = YES;
        self.playedTimeLabel.hidden = YES;
        self.remainingTimeLabel.hidden = YES;
    }
    
    //MALA
    if(globalValues.boolMalaLabel)
    {
        self.malaText.hidden = NO;
        self.malaCounter.hidden = NO;
    }
    else{
        self.malaText.hidden = YES;
        self.malaCounter.hidden = YES;
    }
    
    //BEADS
    if(globalValues.boolBeadsLabel)
    {
        self.beadText.hidden = NO;
        self.beadCounter.hidden = NO;
    }
    else{
        self.beadText.hidden = YES;
        self.beadCounter.hidden = YES;
    }
    
    //LOOPING SETTINGS
    if(globalValues.boolLoopingSettingsButton)
    {
        self.btnSettings.hidden = NO;
        self.labelmode.hidden = NO;
        self.nameLabel.hidden = NO;
        self.counterLabel.hidden = NO;
    }
    else{
        self.btnSettings.hidden = YES;
        self.labelmode.hidden = YES;
        self.nameLabel.hidden = YES;
        self.counterLabel.hidden = YES;
    }
    
    //PLAY BUTTON
    if(globalValues.boolPlayButton)
    {
        self.playButton.hidden = NO;
    }
    else{
        self.playButton.hidden = YES;
    }
    
    //RESET BUTTON
    if(globalValues.boolResetButton)
    {
        self.resetButton.hidden = NO;
    }
    else{
        self.resetButton.hidden = YES;
    }
    
    //AUDIO TEXT
    if(globalValues.boolScrollingTextForLyrics)
    {
        self.txtViewAudioText.hidden = NO;
    }
    else{
        self.txtViewAudioText.hidden = YES;
    }
    
    //OTHER APPS BUTTON
    if(globalValues.boolForOtherAppsButton)
    {
        self.btnOtherApps.hidden = NO;
    }
    else{
        self.btnOtherApps.hidden = YES;
    }
    
    //WEBSITE BTN
    if(globalValues.boolForWebsiteButton)
    {
        self.btnWebsite.hidden = NO;
    }
    else{
        self.btnWebsite.hidden = YES;
    }
    
    //FEEDBACK BTN
    if(globalValues.boolForFeedbackButton)
    {
        self.btnFeedback.hidden = NO;
    }
    else{
        self.btnFeedback.hidden = YES;
    }
    
	self.tableRow = 0;
	self.timeFactor = 100;
	
	// for  number picker data.
	NSMutableArray *data = [[NSMutableArray alloc]init];
	for (int i=0; i<=1000; i++)
	{
		NSString *str = [[NSNumber numberWithInt:i+1] stringValue];
		[data insertObject:str atIndex:i];
		self.pickerData = data;
	}
	
	
	
	timeIndex = 0;
	[self setupAudioSession];
    

	introStateArray = [[[NSUserDefaults standardUserDefaults]objectForKey:kRestoreIntroVariable]mutableCopy];
    
    //GETTING SETTINGS
    self.narrations=[[[NSUserDefaults standardUserDefaults]objectForKey:kNarration] mutableCopy];
	self.displayLanguages=[[NSUserDefaults standardUserDefaults] objectForKey:kDisplayLanguages];
    self.selectedAudioSettingArray=[[[NSUserDefaults standardUserDefaults] objectForKey:kSelectedAudioSetting] mutableCopy];
	self.numberOfTimesArray=[[[NSUserDefaults standardUserDefaults]objectForKey:kNumberOfTimesArray] mutableCopy];
	self.numberOfSecondArray=[[[NSUserDefaults standardUserDefaults] objectForKey:kNumberOfSecondsArray] mutableCopy];
    
	self.selectedAudioSettingIndex=[[self.selectedAudioSettingArray objectAtIndex:self.tableRow] intValue];
	self.noOfTimes=[[self.numberOfTimesArray objectAtIndex:self.tableRow] intValue];
	self.noOfSecs=[[self.numberOfSecondArray objectAtIndex:self.tableRow] intValue];
	//NSLog(@"No of Sec in view did load:%d",self.noOfSecs);
    //NSLog(@"NO. OF TIMES %d",self.noOfTimes);
	
	self.languageArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"RestoreLanguage"];
	languageState = [[languageArray objectAtIndex:0] intValue];
	
	// timer update from saved value
	timeInSeconds = [[self.numberOfSecondArray objectAtIndex:tableRow] intValue];
	_iLeftTimeInterval = timeInSeconds;
	//NSLog(@"time in seconds %d",timeInSeconds);
	hoursInInt = timeInSeconds/(60*60);
	int remainSec = timeInSeconds%(60*60);
	minuteInInt = remainSec /60;
	secondsInInt = remainSec % 60;
	
	/// Initializing variables from saved states to be used in view

	pickerValue =  [[self.numberOfTimesArray objectAtIndex:tableRow]intValue];
	introState = [[introStateArray objectAtIndex:tableRow]intValue];
	languageState = [[languageArray objectAtIndex:tableRow]intValue];
	_iLeftNumberOfLoops = pickerValue;
	
//	[userDefaultObj synchronize];
    
    //CLEAR BACKGROUND COLOR OF WEBVIEW AND MAKE IT OPAQUE
    [self.webViewAppText setBackgroundColor:[UIColor clearColor]];
    [self.webViewAppText setOpaque:NO];
    self.webViewAppText.delegate = self;
    [self.webViewAppText setScalesPageToFit:YES];
    [self.webViewAppText setMultipleTouchEnabled:NO];
    [self.webViewAppText.scrollView setBouncesZoom:NO];
    [self.webViewAppText.scrollView setBounces:NO];
    
    
    
  //  [self refreshView];
//      self.title =@"fdddgdffgdg";
    
//    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
//    [musicPlayer setRepeatMode:MPMusicRepeatModeNone];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleVolumeChangedFromOutSideApp:)
                                                 name:MPMusicPlayerControllerVolumeDidChangeNotification
                                               object:self.audioPlayer];
    
//    [musicPlayer beginGeneratingPlaybackNotifications];

    [volumeBtn setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
    volumeControler = [[UISlider alloc] init];
   
    [volumeControler addTarget:self action:@selector(volumesliderAction:) forControlEvents:UIControlEventValueChanged];
    volumeControler.transform = CGAffineTransformRotate(volumeControler.transform, -90.0/180*M_PI);
    [volumeControler setBackgroundColor:[UIColor clearColor]];
    volumeControler.minimumValue = 0.0;
    volumeControler.maximumValue = 1.0;
    volumeControler.value = 0.5;
    [self.view addSubview:volumeControler];
    volumeEnable=NO;
    volumeControler.hidden=YES;
    
//    UITapGestureRecognizer *touchOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(releaseButAction)];
//    [touchOnView setNumberOfTapsRequired:1];
//    [touchOnView setNumberOfTouchesRequired:1];
//
//    [volumeBtn     addGestureRecognizer:touchOnView];
    
}
//-(void)releaseButAction
//{
//      [volumeBtn setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
//    volumeControler.hidden=YES;
//}
- (void)handleVolumeChangedFromOutSideApp:(id)notification {
    
    [volumeControler setValue:self.audioPlayer.volume animated:YES];
}

-(void)volumesliderAction:(UISlider *)sender
{
    if (self.audioPlayer  != nil)
    {
             self.audioPlayer .volume = volumeControler.value;
       //  [volumeBtn setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        volumeControler.hidden=NO;
        //    volumeEnable=NO;
           }
}
-(void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pausePlayback
{
    [self.audioPlayer pause];
    [playButton setImage:_playBtnBG forState:UIControlStateNormal];
    
	
    [self.updateTimer invalidate];
    [self.countLoopTimer invalidate];
    [self.audioPlayer stop];
    timeIndex = 0;
    
    [playButton setImage:_playBtnBG forState:UIControlStateNormal];
    ibeadCounter = [beadCounter.text intValue];
    imalaCounter = [malaCounter.text intValue];
	
}
-(void)prepareAudioPlayer{
    
    NSString *path = [[NSBundle  mainBundle] pathForResource:self.fileName ofType:nil];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    self.audioPlayer.delegate = self;
    
    self.audioPlayer.currentTime = self.progressBar.value;
    
    
}

-(void) setAudioSettings
{
  
    
    //checking which row is checked
    if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Continuous"]) {
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        //self.audioPlayer.volume=1.0;
        [playButton setImage:_pauseBtnBG forState:UIControlStateNormal];
        
    }
    else if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Play all"])
    {
//        [self.audioPlayer prepareToPlay];
//        [self.audioPlayer play];
//        //self.audioPlayer.volume=1.0;
//        [playButton setImage:_pauseBtnBG forState:normal];
        
        
        
        [self.audioPlayer stop];
        self.progressBar.value=0;
        NSString *path = [[NSBundle  mainBundle] pathForResource:[audioarray objectAtIndex:nextAudioVar] ofType:@"mp3"];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
        self.audioPlayer.delegate = self;
        self.audioPlayer.currentTime = self.progressBar.value;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        tempTimer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:self.audioPlayer repeats:YES];
        [self AppText:nextAudioVar];
        
    }
    else if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Number Of Times"])
    {
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        //self.audioPlayer.volume=1.0;
        [playButton setImage:_pauseBtnBG forState:UIControlStateNormal];
        self.counterLabel.hidden=NO;
        //_iLeftNumberOfLoops--;
        //counterLabel.text = [NSString stringWithFormat:@"%d",_iLeftNumberOfLoops];
        
        if (_iLeftNumberOfLoops == 0)
        {
            [self.audioPlayer stop];
            [self.updateTimer invalidate];
            [playButton setImage:_playBtnBG forState:UIControlStateNormal];
            _iLeftNumberOfLoops = pickerValue;
            counterLabel.text = [NSString stringWithFormat:@"%d",_iLeftNumberOfLoops];
            self.audioPlayer.currentTime =0;
        }
        else{
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
            //self.audioPlayer.volume=1.0;
            [playButton setImage:_pauseBtnBG forState:UIControlStateNormal];
            
        }
    }
    else if(([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Duration"] && hoursInInt !=0)||minuteInInt !=0||secondsInInt!=0){
      
       
        self.countLoopTimer = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(decreamentingCounter) userInfo:nil repeats:YES];
        
        
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        self.audioPlayer.delegate = self;
        self.audioPlayer.volume=1.0;
        [playButton setImage:_pauseBtnBG forState:UIControlStateNormal];
    }
    
}

// decreaneting clock and stoping player at '0' time
-(void)decreamentingCounter
{
    //NSLog(@"decrement time duration called");
	//NSLog(@"No of seconds:%d",noOfSecs);
	if (self.noOfSecs>0)
	{
		self.noOfSecs--;
		int hh=self.noOfSecs/(60*60);
		int mm=(self.noOfSecs/60)-(hh*60);
		int ss=self.noOfSecs-(hh*60*60)-(mm*60);
		self.counterLabel.text = [NSString stringWithFormat:@" %2.2d  :  %2.2d  :  %2.2d",hh,mm,ss];
	}
	else
	{
        [self.audioPlayer stop];
        [self.countLoopTimer invalidate];
        [self.updateTimer invalidate];
        self.audioPlayer.currentTime =0;
        //        [self.tempTimer invalidate];
        self.noOfSecs=[[self.numberOfSecondArray objectAtIndex:self.tableRow] intValue];
        //NSLog(@"No OF Second setted:%d",self.noOfSecs);
        //NSLog(@"player duration:%d",(int)(self.audioPlayer.duration));
        //        float nol=self.noOfSecs/(float)(self.audioPlayer.duration);
        //        if (nol<1)
        //            nol=1;
        //        self.noOfSecs=(int)nol*(float)(self.audioPlayer.duration);
        [playButton setImage:_playBtnBG forState:UIControlStateNormal];
        
        //NSLog(@"Now number of sec:%d",self.noOfSecs);
        //        _iLeftTimeInterval--;
		
	}
}

// play button tapped

- (IBAction)playButtonPressed:(UIButton *)sender{
	if (![self.audioPlayer isPlaying])
	{
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
      //  [self prepareAudioPlayer];
        [self setAudioSettings];
		tempTimer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:self.audioPlayer repeats:YES];
	}
	else
	{
		[self pausePlayback];
	}
}

// alertview sub method
-(void)alertViewSubMethod
{
    
  //  NSLog(@"%@",self.beadArray);
    
    ibeadCounter=0;
    imalaCounter=0;
    beadCounter.text = [NSString stringWithFormat:@"%d",ibeadCounter];
    malaCounter.text = [NSString stringWithFormat:@"%d",imalaCounter];
//    [self.beadArray replaceObjectAtIndex:self.tableRow withObject:@"0"];
//    [self.malaArray replaceObjectAtIndex:self.tableRow withObject:@"0"];
    
    
    if( (self.counterLabel.hidden==NO)&&([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Duration"]))//when audio mode is for time duration
    {
        if(self.audioPlayer.playing==YES)
            [self.countLoopTimer invalidate];
        self.noOfSecs=[[self.numberOfSecondArray objectAtIndex:self.tableRow] intValue];
        
        int hh = self.noOfSecs/(60*60);
        int mm = (self.noOfSecs/60)-(hh*60);
        int ss = self.noOfSecs-(hh*60*60)-(mm*60);
        
        //NSLog(@"Number of loops are:%d",self.noOfLoops);
        //_labelmode.text = [globalValues.marrAudioSettings objectAtIndex:2];
        _labelmode.text = @"Audio Settings : Duration";
        counterLabel.hidden = NO;
        counterLabel.text = [NSString stringWithFormat:@" %2.2d  :  %2.2d  :  %2.2d",hh,mm,ss];
        _nameLabel.hidden = NO;
        _nameLabel.text = [globalValues.marrAudioSettings objectAtIndex:2];
        
        
    }
    else if( (self.counterLabel.hidden==NO)&&([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Number Of Times"]))
    {
        self.noOfTimes=[[self.numberOfTimesArray objectAtIndex:self.tableRow] intValue];
        self.noOfLoops = self.noOfTimes;
        self.counterLabel.text=[NSString stringWithFormat:@"%d",self.noOfTimes];
        
    }
    
    [self.audioPlayer stop];
    self.audioPlayer.currentTime=0;
    self.timeIndex = 0;
    [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
}
//Alert View delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self alertViewSubMethod];
        }
            break;
            
        default:
            break;
    }
    
}

///////// Reset button tapped
-(IBAction)resetButtonPressed:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Reset" message:@"Are you sure, you want to reset Mala and Beads?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO",nil];
    [alert  show];
    //[self alertView];
}

//save the beads and mala at  View Will Disappear
-(void)viewWillDisappear:(BOOL)animated {
	
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        [self.audioPlayer stop];
    }
	

    
    [[NSUserDefaults standardUserDefaults]setObject:beadCounter.text forKey:[NSString stringWithFormat:@"Bead_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
//    
[[NSUserDefaults standardUserDefaults]setObject:malaCounter.text forKey:[NSString stringWithFormat:@"Mala_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Bead_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]]);
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Mala_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]]);

    
    //  label.text=[NSString stringWithFormat:@"Bead_%@",[globalValues.marrForViewController1 objectAtIndex:nextAudioVar]];
    
//    [self.beadArray replaceObjectAtIndex:self.tableRow withObject:self.beadCounter.text];
//    [self.userDefaultObj setObject:self.beadArray forKey:[NSString stringWithFormat:@"Bead_%@",[globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
//  
//    [self.malaArray replaceObjectAtIndex:self.tableRow withObject:self.malaCounter.text];
//    [self.userDefaultObj setObject:self.malaArray forKey:[NSString stringWithFormat:@"Mala_%@",[globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
//    [[NSUserDefaults standardUserDefaults]synchronize];

    
	introState = 0;
	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark AudioSession methods

void RouteChangeListener(void * inClientData, AudioSessionPropertyID	inID, UInt32  inDataSize, const void *  inData)
{
	RootViewController* This = (__bridge RootViewController *)inClientData;
	
	if (inID == kAudioSessionProperty_AudioRouteChange) {
		
		CFDictionaryRef routeDict = (CFDictionaryRef)inData;
		NSNumber* reasonValue = (NSNumber*)CFDictionaryGetValue(routeDict, CFSTR(kAudioSession_AudioRouteChangeKey_Reason));
		
		int reason = [reasonValue intValue];
		
		if (reason == kAudioSessionRouteChangeReason_OldDeviceUnavailable) {
			
			[This pausePlayback];
		}
	}
}

- (void)setupAudioSession
{
	AVAudioSession *session = [AVAudioSession sharedInstance];
	NSError *error = nil;
	
	[session setCategory: AVAudioSessionCategoryPlayback error: &error];
	if (error != nil)
		NSLog(@"Failed to set category on AVAudioSession");
	
	// AudioSession and AVAudioSession calls can be used interchangeably
	OSStatus result = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, RouteChangeListener, (__bridge void *)(self));
	if (result) NSLog(@"Could not add property listener! %ld\n", result);
	
	BOOL active = [session setActive: YES error: nil];
	if (!active)
		NSLog(@"Failed to set category on AVAudioSession");
	else
		NSLog(@"set category on AVAudioSession");
	
}

#pragma mark AVAudioPlayer delegate methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)audioPlayer successfully:(BOOL)flag
{
   
//      if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Play all"])
//      {
//           if (nextAudioVar==audioarray.count-1) {
//               
////               [self.audioPlayer pause];
////               
////               
////               NSLog(@"nextAudioVar---->%d",nextAudioVar);
////               NSLog(@"audioarray.count-1---->%d",audioarray.count-1);
//               
//}else
//        {
//            NSLog(@"nextAudioVar---->%d",nextAudioVar);
//            NSLog(@"audioarray.count-1---->%d",audioarray.count-1);
//                             
//                        nextAudioVar++;
//
//
//            [self.countLoopTimer invalidate];
//            [self.updateTimer invalidate];
//          //  [self playAudioAccordingToSettings];
//        
//        
//        }
//          
//          
//      }else
//      {
          [self.countLoopTimer invalidate];
          [self.updateTimer invalidate];
           [self playAudioAccordingToSettings];
//      }
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}
-(void)playAudioAccordingToSettings
{
    if(ibeadCounter < 107)
    {
        ibeadCounter++;
    }
    else
    {
        ibeadCounter = 0;
        imalaCounter++;
    }
    beadCounter.text = [NSString stringWithFormat:@"%d",ibeadCounter];
    if(imalaCounter>0)
    {
        malaCounter.hidden = NO;
        _malaText.hidden = NO;
        beadText.hidden = NO;
        malaCounter.text = [NSString stringWithFormat:@"%d",imalaCounter];
    }
    
 //   self.userDefaultObj = [NSUserDefaults standardUserDefaults];
    
    
    //checking which row is checked
    if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Continuous"]) {
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        //self.audioPlayer.volume=1.0;
        [playButton setImage:_pauseBtnBG forState:UIControlStateNormal];
        
    }
        if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Play all"]) {
//            [self.audioPlayer prepareToPlay];
//            [self.audioPlayer play];
//            //self.audioPlayer.volume=1.0;
//            [playButton setImage:_pauseBtnBG forState:normal];
            
            
            [self.audioPlayer stop];
            self.progressBar.value=0;
            NSString *path = [[NSBundle  mainBundle] pathForResource:[audioarray objectAtIndex:nextAudioVar] ofType:@"mp3"];
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
            self.audioPlayer.delegate = self;
            self.audioPlayer.currentTime = self.progressBar.value;
            [self.audioPlayer prepareToPlay];
               [self.audioPlayer play];
            tempTimer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:self.audioPlayer repeats:YES];
            [self AppText:nextAudioVar];
        }
    else if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Number Of Times"]) {
        _iLeftNumberOfLoops--;
     //   counterLabel.text = [NSString stringWithFormat:@"%d",_iLeftNumberOfLoops];
      
        if (_iLeftNumberOfLoops == 0)
        {
            _iLeftNumberOfLoops = pickerValue;
         //   counterLabel.text = [NSString stringWithFormat:@"%d",_iLeftNumberOfLoops];
            self.audioPlayer.currentTime =0;
            [self.updateTimer invalidate];
            [playButton setImage:_playBtnBG forState:UIControlStateNormal];
            [self.audioPlayer stop];
            
        }
        else{
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
            //self.audioPlayer.volume=1.0;
            [playButton setImage:_pauseBtnBG forState:normal];
            
        }
    }
    else if(([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Duration"] && hoursInInt !=0)||minuteInInt !=0||secondsInInt!=0){
        self.countLoopTimer = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(decreamentingCounter) userInfo:nil repeats:YES];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        self.audioPlayer.delegate = self;
        self.audioPlayer.volume=1.0;
        [playButton setImage:_pauseBtnBG forState:normal];
    }
    
    
    
}


//playerdecodeerror did occure

- (void)playerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
	NSLog(@"ERROR IN DECODE: %@\n", error);
}




//************* interruption handling methods **********

// we will only get these notifications if playback was interrupted
- (void) audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
	// the object has already been paused,	we just need to update UI
	[self.updateTimer invalidate ];
	[self.countLoopTimer invalidate];
    
	[playButton setImage:_playBtnBG forState:normal];
	ibeadCounter = [beadCounter.text intValue];
	imalaCounter = [malaCounter.text intValue];
    
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
	NSLog(@"In Interruption");
    //	[self startPlayback];
}



//displaying introduction languages setting view.
-(IBAction)flipIntroLangSetting:(id)sender
{
    _settingsClicked=true;
    AudioSettingsViewController  *objAudioSettingsController = [[AudioSettingsViewController alloc]initWithNibName:@"AudioSettingsViewController" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:objAudioSettingsController];
    
    if([[UIDevice currentDevice] userInterfaceIdiom ] == UIUserInterfaceIdiomPhone)
    {
        [self presentModalViewController:navigationController animated:YES];
    }
    else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        objAudioSettingsController.delegate = self;
        self.mPopOverController=[[UIPopoverController alloc] initWithContentViewController:navigationController] ;
        self.popOverController = self.mPopOverController;
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            [self changeViewForPortraitMode];
            
        }
        else
        {
            [self changeViewForLandscapeMode];
            
        }
        
        
    }

    
}


- (void)flipAction:(id)sender
{
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:animationIDfinished:finished:context:)];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	
	[UIView setAnimationTransition:([self.view superview] ?
									UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
						   forView:self.view cache:YES];
	
	if ([self.instructionsView superview])
		[self.instructionsView removeFromSuperview];
	else
		[self.view addSubview:self.instructionsView];
	
	[UIView commitAnimations];
	
	// adjust our done/info buttons accordingly
	if ([self.instructionsView superview] == self.view)
    {
        self.flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(flipAction:)];
        self.navigationItem.rightBarButtonItem = self.flipButton;
        
        self.title = @"Info";
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica" size:22.0];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor =[UIColor whiteColor];
        label.text=self.title;
        self.navigationItem.titleView = label;
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
            if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
                [self changeViewForPortraitMode];
            } else {
                [self changeViewForLandscapeMode];
            }
        }
        else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                
            }
            if(result.height == 568)
            {
//                if ([UIScreen mainScreen].bounds.size.height == 568.0)
//                {
//                    volumeControler.frame=CGRectMake(160, 132, 150, 10);
//                    
//                    
//                }else
//                {
                    volumeControler.frame=CGRectMake(160, 350, 150, 10);
                    volumeBtn.frame=CGRectMake(self.instructionsView.frame.origin.x, 490, self.instructionsView.frame.size.width,  self.instructionsView.frame.size.height);
                    
//                }
                
                self.instructionsView.frame = CGRectMake(self.instructionsView.frame.origin.x, self.instructionsView.frame.origin.y, self.instructionsView.frame.size.width, 540);
                self.lblAudioCopyRight.frame = CGRectMake(self.lblAudioCopyRight.frame.origin.x, 470, self.lblAudioCopyRight.frame.size.width, self.lblAudioCopyRight.frame.size.height);
                self.lblCopyRight.frame = CGRectMake(39, 450, self.lblCopyRight.frame.size.width, self.lblCopyRight.frame.size.height);
                self.btnFacebook.frame = CGRectMake(self.btnFacebook.frame.origin.x, 410, self.btnFacebook.frame.size.width, self.btnFacebook.frame.size.height);
                self.btnTwitter.frame = CGRectMake(self.btnTwitter.frame.origin.x, 410, self.btnTwitter.frame.size.width, self.btnTwitter.frame.size.height);
                self.btnFeedback.frame = CGRectMake(self.btnFeedback.frame.origin.x, 410, self.btnFeedback.frame.size.width, self.btnFeedback.frame.size.height);
                self.btnOtherApps.frame = CGRectMake(self.btnOtherApps.frame.origin.x, 410, self.btnOtherApps.frame.size.width, self.btnOtherApps.frame.size.height);
                self.txtViewInfoText.frame = CGRectMake(self.txtViewInfoText.frame.origin.x, self.txtViewInfoText.frame.origin.y, self.txtViewInfoText.frame.size.width, 300);
            }
        }
    }
	else
    {
        self.title = [NSString stringWithFormat:@"%@",[globalValues.marrForViewController1 objectAtIndex:self.selectedRow]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
        label.backgroundColor = [UIColor clearColor];
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            label.font = [UIFont fontWithName:@"Helvetica" size:22.0];
        else
            label.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor =[UIColor whiteColor];
        label.text=self.title;
        self.navigationItem.titleView = label;
        
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [infoButton addTarget:self action:@selector(flipAction:) forControlEvents:UIControlEventTouchUpInside];
        self.flipButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        self.navigationItem.rightBarButtonItem = self.flipButton;
    }
}
-(void)adjustPlayTime
{
	//NSLog(@"time %d",timeInSeconds);
	
	int remainder = timeInSeconds % 1536;
	timeInSeconds -= remainder;
	//NSLog(@"duration %d",(int)self.audioPlayer.duration);
	//NSLog(@"remainder %d",remainder);
	//NSLog(@"time after %d",timeInSeconds);
	
	hoursInInt = timeInSeconds/(60*60);
	int remainSec = timeInSeconds%(60*60);
	minuteInInt = remainSec /60;
	secondsInInt = remainSec % 60;
	
	
}

- (void)viewWillAppear:(BOOL)animated {
    [self.countLoopTimer invalidate];
    [self headerChange];
    [self  setAudioSettings];
    [self refreshView];
    
    [super viewWillAppear:animated];
      volumeBtn.backgroundColor=[UIColor clearColor];
    self.progressBar.hidden = NO;
    self.playedTimeLabel.hidden = NO;
    self.remainingTimeLabel.hidden = NO;
    self.malaText.hidden = NO;
    self.malaCounter.hidden = NO;
    self.beadText.hidden = NO;
    self.beadCounter.hidden = NO;
    self.btnSettings.hidden = NO;
    self.labelmode.hidden = NO;
    self.nameLabel.hidden = NO;
    self.counterLabel.hidden = NO;
    self.playButton.hidden = NO;
    self.resetButton.hidden = NO;
    
    self.imgViewSettingsBackground.hidden=NO;
    self.playButton.backgroundColor=[UIColor clearColor];
    self.imgViewSettingsBackground.backgroundColor=[UIColor blackColor];
  //  playButton.backgroundColor=[UIColor redColor];

    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            self.strImageName = [NSString stringWithFormat:@"Bg_iPhone.png"];
            
            UIImage *image = [UIImage imageNamed:self.strImageName];
            self.mainImage.image = image;
            
            volumeControler.frame=CGRectMake(160, 270, 150, 100);

        }
        if(result.height == 568)
        {
        //    self.view.frame=CGRectMake(0, 0, 320, 568);
            volumeControler.frame=CGRectMake(160, 350, 150, 100);
            volumeBtn.frame=CGRectMake(220, 452, 50, 50);
            
          
               self.nextBtn.frame =  CGRectMake(self.nextBtn.frame.origin.x,463 ,self.nextBtn.frame.size.width, self.nextBtn.frame.size.height);
            
               self.PreviousBtn.frame =  CGRectMake(self.PreviousBtn.frame.origin.x,463 ,self.PreviousBtn.frame.size.width, self.PreviousBtn.frame.size.height);
            
            self.mainImage.frame =  CGRectMake(self.mainImage.frame.origin.x,self.mainImage.frame.origin.y ,self.mainImage.frame.size.width, 568);
            
            self.strImageName = [NSString stringWithFormat:@"Bg_iPod.png"];
            
            UIImage *image = [UIImage imageNamed:self.strImageName];
            self.mainImage.image = image;
            
            self.imgViewAudioMode.frame = CGRectMake(self.imgViewAudioMode.frame.origin.x, 400, self.imgViewAudioMode.frame.size.width, 65);
            self.labelmode.frame = CGRectMake(self.labelmode.frame.origin.x, 410, self.labelmode.frame.size.width, self.labelmode.frame.size.height);;
            self.counterLabel.frame = CGRectMake(self.counterLabel.frame.origin.x, 415, self.counterLabel.frame.size.width, self.counterLabel.frame.size.height);
            self.nameLabel.frame = CGRectMake(213, 400, self.nameLabel.frame.size.width, self.nameLabel.frame.size.height);
            
            self.imgViewSettingsBackground.frame = CGRectMake(self.imgViewSettingsBackground.frame.origin.x, 455, self.imgViewSettingsBackground.frame.size.width, 50);
            
            self.playButton.frame = CGRectMake(self.playButton.frame.origin.x, 458, self.playButton.frame.size.width, self.playButton.frame.size.height);
            self.btnSettings.frame = CGRectMake(self.btnSettings.frame.origin.x, 460, self.btnSettings.frame.size.width, self.btnSettings.frame.size.height);
            self.resetButton.frame = CGRectMake(self.resetButton.frame.origin.x, 458, self.resetButton.frame.size.width, self.resetButton.frame.size.height);
            
            self.progressBar.frame = CGRectMake(self.progressBar.frame.origin.x, 72, self.progressBar.frame.size.width, self.progressBar.frame.size.height);
            self.playedTimeLabel.frame = CGRectMake(self.playedTimeLabel.frame.origin.x, 72, self.playedTimeLabel.frame.size.width, self.playedTimeLabel.frame.size.height);
            self.remainingTimeLabel.frame = CGRectMake(self.remainingTimeLabel.frame.origin.x, 72, self.remainingTimeLabel.frame.size.width, self.remainingTimeLabel.frame.size.height);
            
            self.txtViewAudioText.frame = CGRectMake(self.txtViewAudioText.frame.origin.x, 118, self.txtViewAudioText.frame.size.width, 270);
            
            self.webViewAppText.frame = CGRectMake(self.webViewAppText.frame.origin.x, 118, self.webViewAppText.frame.size.width, 270);
        }
    }
    else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            [self changeViewForPortraitMode];
        }
        else
        {
            [self changeViewForLandscapeMode];
        }
    }
    
    if ([NSString stringWithFormat:@"Bead_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]) {
         beadCounter.text=[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Bead_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
    }if ([[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Mala_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]]) {
        malaCounter.text= [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Mala_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
    }
    
   
    

    if ([beadCounter.text length]==0) {
        beadCounter.text=@"0";
    }
    if ([malaCounter.text length]==0) {
        malaCounter.text=@"0";
    }

    
 

}

-(void)refreshView
{
    self.narrations=[[[NSUserDefaults standardUserDefaults] objectForKey:kNarration] mutableCopy];
    self.displayLanguages=[[[NSUserDefaults standardUserDefaults] objectForKey:kDisplayLanguages] mutableCopy];
    self.selectedAudioSettingArray=[[[NSUserDefaults standardUserDefaults] objectForKey:kSelectedAudioSetting] mutableCopy];
	self.numberOfTimesArray=[[[NSUserDefaults standardUserDefaults]objectForKey:kNumberOfTimesArray] mutableCopy];
	self.numberOfSecondArray=[[[NSUserDefaults standardUserDefaults] objectForKey:kNumberOfSecondsArray] mutableCopy];
    self.noOfTimes=[[self.numberOfTimesArray objectAtIndex:self.tableRow] intValue];
    
    
    
	self.noOfSecs=[[self.numberOfSecondArray objectAtIndex:self.tableRow] intValue];
    
    NSLog(@"%d",	self.noOfSecs);

    
	self.selectedAudioSettingIndex=[[self.selectedAudioSettingArray objectAtIndex:self.tableRow] intValue];
    
    /*[globalValues.marrForDisplayLanguage objectAtIndex:[[self.displayLanguages objectAtIndex:0] intValue]];
     if ([[self.displayLanguages objectAtIndex:0]intValue]==0) {
     self.txtViewAudioText.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
     }
     else if ([[self.displayLanguages objectAtIndex:0]intValue]==1) {
     self.txtViewAudioText.font = [UIFont fontWithName:@"Kruti Dev 011" size:16.0];
     }
     else if ([[self.displayLanguages objectAtIndex:0]intValue]==2) {
     self.txtViewAudioText.font = [UIFont fontWithName:@"Shivaji01" size:20.0];
     }*/
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
     self.txtViewAudioText.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    else
        self.txtViewAudioText.font = [UIFont fontWithName:@"Helvetica" size:25.0];

    
    if(globalValues.boolNarrationSettingEnable)
    {
        if(globalValues.boolSubMenuEnable)
        {
//            self.fileName = [NSString stringWithFormat:@"menu%d_submenu%d_audio_%@.mp3",[globalValues.strMainMenuSelectedRow intValue],self.selectedRow,[globalValues.marrNarrationSettings objectAtIndex:[[self.narrations objectAtIndex:0] intValue]]];
//            
//            if(globalValues.boolTextEnable)
//            {
//                self.txtViewAudioText.text = [NSString stringWithFormat:@"%@",[[[globalValues.marrSubMenuText objectAtIndex:[globalValues.strMainMenuSelectedRow intValue]] objectAtIndex:self.selectedRow] objectForKey:[globalValues.marrForDisplayLanguage objectAtIndex:[[self.displayLanguages objectAtIndex:0] intValue]]]];
//                
//                //self.txtViewAudioText.textAlignment = NSTextAlignmentJustified;
//                
//            }
//            else{
//                self.txtViewAudioText.text = @"";
//            }
            
        }
        else{
            self.fileName = [NSString stringWithFormat:@"main_menu_audio%d_%@.mp3",self.selectedRow,[globalValues.marrNarrationSettings objectAtIndex:[[self.narrations objectAtIndex:0] intValue]]];
            
            if(globalValues.boolTextEnable)
            {
                self.txtViewAudioText.text = [NSString stringWithFormat:@"%@",[[globalValues.marrMenuText objectAtIndex:[globalValues.strMainMenuSelectedRow intValue]] objectForKey:[globalValues.marrForDisplayLanguage objectAtIndex:[[self.displayLanguages objectAtIndex:0] intValue]]]];
                
                //self.txtViewAudioText.textAlignment = NSTextAlignmentJustified;
            }
            else{
                self.txtViewAudioText.text = @"";
            }
        }
    }
    else{
        if(globalValues.boolSubMenuEnable)
        {
            self.fileName = [NSString stringWithFormat:@"menu%d_submenu%d_audio_Hindi.mp3",[globalValues.strMainMenuSelectedRow intValue],self.selectedRow];
            
            if(globalValues.boolTextEnable)
            {
                self.txtViewAudioText.text = [NSString stringWithFormat:@"%@",[[[globalValues.marrSubMenuText objectAtIndex:[globalValues.strMainMenuSelectedRow intValue]] objectAtIndex:self.selectedRow] objectForKey:@"Hindi"]];
                
                //self.txtViewAudioText.textAlignment = NSTextAlignmentJustified;
            }
            else{
                self.txtViewAudioText.text = @"";
            }
        }
        else{
            self.fileName = [NSString stringWithFormat:@"main_menu_audio%d_Hindi.mp3",self.selectedRow];
            
            if(globalValues.boolTextEnable)
            {
                //Showing Text in WEBVIEW
                [self AppText:self.selectedRow];
                
                /*self.txtViewAudioText.text = [NSString stringWithFormat:@"%@",[[globalValues.marrMenuText objectAtIndex:[globalValues.strMainMenuSelectedRow intValue]] objectForKey:@"English"]];
                
                self.txtViewAudioText.textAlignment = NSTextAlignmentJustified;*/
            }
            else{
                self.txtViewAudioText.text = @"";
            }
            
        }
    }
    
    if(globalValues.boolNarrationSettingEnable)
    {
        if ([self.strNarrationSetting isEqualToString:[NSString stringWithFormat:@"%@",[globalValues.marrNarrationSettings objectAtIndex:[[self.narrations objectAtIndex:0] intValue]]]]) {
            
        }
        else{
            self.strNarrationSetting = [NSString stringWithFormat:@"%@",[globalValues.marrNarrationSettings objectAtIndex:[[self.narrations objectAtIndex:0] intValue]]];
            //audio player
            NSString *path = [[NSBundle  mainBundle] pathForResource:self.fileName ofType:nil];
            // NSLog(@"PATH %@",path);
            
            if(path == nil)
            {
                //NSLog(@"PATH NIL");
                
                self.txtViewAudioText.hidden = NO;
                self.txtViewAudioText.frame = CGRectMake(15, 40, 330, 370);
                
                self.malaText.hidden = YES;
                self.malaCounter.hidden = YES;
                self.beadText.hidden = YES;
                self.beadCounter.hidden = YES;
                self.progressBar.hidden = YES;
                self.playedTimeLabel.hidden = YES;
                self.remainingTimeLabel.hidden = YES;
                self.labelmode.hidden = YES;
                self.nameLabel.hidden = YES;
                self.counterLabel.hidden = YES;
                self.playButton.hidden = YES;
                self.resetButton.hidden = YES;
                self.imgViewSettingsBackground.hidden = YES;
                
            }
            else{
                
                if(globalValues.boolTextEnable)
                {
                    self.txtViewAudioText.hidden = NO;
                }
                else{
                    self.txtViewAudioText.hidden = YES;
                }
                
                _playBtnBG = [[UIImage imageNamed:@"play.png"] stretchableImageWithLeftCapWidth:11.0 topCapHeight:0.0];
                _pauseBtnBG = [[UIImage imageNamed:@"pause.png"] stretchableImageWithLeftCapWidth:11.0 topCapHeight:0.0];
                [self.resetButton setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
            
                beadCounter.text = [NSString stringWithFormat:@"%d",ibeadCounter];
                malaCounter.text = [NSString stringWithFormat:@"%d",imalaCounter];
                
                if(imalaCounter>0)
                {
                    malaCounter.hidden = NO;
                    _malaText.hidden = NO;
                    beadText.hidden = NO;
                }
                
            }
        }
    }
    else{
        if (self.audioPlayer==NULL) {
            //audio player
            NSString *path = [[NSBundle  mainBundle] pathForResource:self.fileName ofType:nil];
            // NSLog(@"PATH %@",path);
            
            if(path == nil)
            {
                //NSLog(@"PATH NIL");
                
                self.txtViewAudioText.hidden = NO;
                self.txtViewAudioText.frame = CGRectMake(5, 20, 310, 330);
                
                self.malaText.hidden = YES;
                self.malaCounter.hidden = YES;
                self.beadText.hidden = YES;
                self.beadCounter.hidden = YES;
                self.progressBar.hidden = YES;
                self.playedTimeLabel.hidden = YES;
                self.remainingTimeLabel.hidden = YES;
                self.labelmode.hidden = YES;
                self.nameLabel.hidden = YES;
                self.counterLabel.hidden = YES;
                self.playButton.hidden = YES;
                self.resetButton.hidden = YES;
                self.imgViewSettingsBackground.hidden = YES;
                
            }
            else{
                
                if(globalValues.boolTextEnable)
                {
                    self.txtViewAudioText.hidden = NO;
                }
                else{
                    self.txtViewAudioText.hidden = YES;
                }
                
                _playBtnBG = [[UIImage imageNamed:@"play.png"] stretchableImageWithLeftCapWidth:11.0 topCapHeight:0.0];
                _pauseBtnBG = [[UIImage imageNamed:@"pause.png"] stretchableImageWithLeftCapWidth:11.0 topCapHeight:0.0];
                [self.resetButton setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
                //NSLog(@"tableRow %d",tableRow);
                
                //NSLog(@"Bead counter %d",ibeadCounter);
                //NSLog(@"Mala counter %d",imalaCounter);
                beadCounter.text = [NSString stringWithFormat:@"%d",ibeadCounter];
                malaCounter.text = [NSString stringWithFormat:@"%d",imalaCounter];
                
                if(imalaCounter>0)
                {
                    malaCounter.hidden = NO;
                    _malaText.hidden = NO;
                    beadText.hidden = NO;
                }
                
            }
        }
    }
    
    
    
    
    
    //NSLog(@"NARRATIONS %@",self.narrations);
    //NSLog(@"LANGUAGE %@",self.displayLanguages);
    NSString *path = [[NSBundle  mainBundle] pathForResource:self.fileName ofType:nil];
    //checking which row is checked
	if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Continuous"])
	{
        if ([self.strAudioPlaySetting isEqualToString:@"Continuous"]) {
            
        }
        else{
            [self.audioPlayer stop];
            
            
            if(path != nil)
            {
                self.progressBar.value = 0;
                [self prepareAudioPlayer];
                [playButton setImage:_playBtnBG forState:UIControlStateNormal];
                
                self.playedTimeLabel.text = [NSString stringWithFormat:@"%d:%02d", (int)self.audioPlayer.currentTime / 60, (int)self.audioPlayer.currentTime % 60, nil];
                self.remainingTimeLabel.text = [NSString stringWithFormat:@"-%d:%02d", (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) / 60, (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) % 60, nil];
            }
            [self.countLoopTimer invalidate];
            self.strAudioPlaySetting = [NSString stringWithFormat:@"%@",[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex]];
            _nameLabel.hidden = YES;
            _labelmode.text = @"Audio Settings : Continuous";
            counterLabel.hidden = YES;
            self.audioPlayer.numberOfLoops = -1;
            [self.audioPlayer stop];
            [self.updateTimer invalidate];
            [self.countLoopTimer invalidate];
            timeIndex = 0;
            self.audioPlayer.currentTime =0;
            [playButton setImage:_playBtnBG forState:UIControlStateNormal];
            //[self animateSettingView];
        }
	}
    if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Play all"])
	{
        if (![self.strAudioPlaySetting isEqualToString:@"Play all"]) {
            if (nextAudioVar<audioarray.count-1) {
//                 self.labelmode.text = @"Audio Settings : Play all";
//                self.nameLabel.text=@"";
//                counterLabel.hidden=YES;
                
                [self.audioPlayer stop];
                self.progressBar.value=0;
                NSString *path = [[NSBundle  mainBundle] pathForResource:[audioarray objectAtIndex:nextAudioVar] ofType:@"mp3"];
                self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
                self.audioPlayer.delegate = self;
                self.audioPlayer.currentTime = self.progressBar.value;
                [self.audioPlayer prepareToPlay];
                [self.audioPlayer play];
                tempTimer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:self.audioPlayer repeats:YES];
                [self AppText:nextAudioVar];
 
            }
        }
    }
	else if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Number Of Times"])
	{
        if ([self.strAudioPlaySetting isEqualToString:@"Number Of Times"]) {
            if(pickerValue!=self.noOfTimes)
            {
                [self.audioPlayer stop];
                
                if(path != nil)
                {
                    self.progressBar.value = 0;
                    [self prepareAudioPlayer];
                    [playButton setImage:_playBtnBG forState:UIControlStateNormal];
                    
                    self.playedTimeLabel.text = [NSString stringWithFormat:@"%d:%02d", (int)self.audioPlayer.currentTime / 60, (int)self.audioPlayer.currentTime % 60, nil];
                    self.remainingTimeLabel.text = [NSString stringWithFormat:@"-%d:%02d", (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) / 60, (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) % 60, nil];
                    
                }
                self.strAudioPlaySetting = [NSString stringWithFormat:@"%@",[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex]];
                
                [self.countLoopTimer invalidate];
                //NSLog(@"selected audio setting is number of times");
                pickerValue = self.noOfTimes;
                _iLeftNumberOfLoops = self.noOfTimes;
                self.noOfLoops = self.noOfTimes;
                self.labelmode.text = @"Audio Settings : Number Of Times";
                if(self.audioPlayer!=nil)
                    self.counterLabel.hidden=NO;
                else
                    self.counterLabel.hidden = YES;
                self.counterLabel.text=[NSString stringWithFormat:@"%d",self.noOfTimes];
                self.nameLabel.hidden=YES;
                
            }
        }
        else{
            [self.audioPlayer stop];
            
            if(path != nil)
            {
                self.progressBar.value = 0;
                [self prepareAudioPlayer];
                [playButton setImage:_playBtnBG forState:UIControlStateNormal];
                
                self.playedTimeLabel.text = [NSString stringWithFormat:@"%d:%02d", (int)self.audioPlayer.currentTime / 60, (int)self.audioPlayer.currentTime % 60, nil];
                self.remainingTimeLabel.text = [NSString stringWithFormat:@"-%d:%02d", (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) / 60, (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) % 60, nil];
                
            }
            self.strAudioPlaySetting = [NSString stringWithFormat:@"%@",[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex]];
            
            [self.countLoopTimer invalidate];
            //NSLog(@"selected audio setting is number of times");
            pickerValue = self.noOfTimes;
            _iLeftNumberOfLoops = self.noOfTimes;
            self.noOfLoops = self.noOfTimes;
            self.labelmode.text = @"Audio Settings : Number Of Times";
            if(self.audioPlayer!=nil)
                self.counterLabel.hidden=NO;
            else
                self.counterLabel.hidden = YES;
            self.counterLabel.text=[NSString stringWithFormat:@"%d",self.noOfTimes];
            self.nameLabel.hidden=YES;
            
        }
	}
	else if ([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex] isEqualToString:@"Duration"])
	{
        if ([self.strAudioPlaySetting isEqualToString:@"Duration"]) {
            if(self.intDatePickerValue != self.noOfSecs)
            {
                [self.audioPlayer stop];
                if(path != nil)
                {
                    self.progressBar.value = 0;
                    [self prepareAudioPlayer];
                    [playButton setImage:_playBtnBG forState:UIControlStateNormal];
                    
                    self.playedTimeLabel.text = [NSString stringWithFormat:@"%d:%02d", (int)self.audioPlayer.currentTime / 60, (int)self.audioPlayer.currentTime % 60, nil];
                    self.remainingTimeLabel.text = [NSString stringWithFormat:@"-%d:%02d", (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) / 60, (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) % 60, nil];
                    
                }
                self.strAudioPlaySetting = [NSString stringWithFormat:@"%@",[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex]];
                
                
                self.noOfSecs=[[self.numberOfSecondArray objectAtIndex:self.tableRow] intValue];
                self.intDatePickerValue = self.noOfSecs;
                int hh = self.noOfSecs/(60*60);
                int mm = (self.noOfSecs/60)-(hh*60);
                int ss = self.noOfSecs-(hh*60*60)-(mm*60);
                //NSLog(@"Number of loops are:%d",self.noOfLoops);
                _labelmode.text = @"Audio Settings : Duration";
                if(self.audioPlayer!=nil)
                {
                    self.counterLabel.hidden=NO;
                    
                    counterLabel.text = [NSString stringWithFormat:@" %2.2d  :  %2.2d  :  %2.2d",hh,mm,ss];
                    _nameLabel.hidden = NO;
                    _nameLabel.text = kHrMinSecLabelText;
                }
                
                else
                    self.counterLabel.hidden = YES;
                
                
                
                [self.audioPlayer stop];
                [self.updateTimer invalidate];
                [self.countLoopTimer invalidate];
                timeIndex = 0;
                self.audioPlayer.currentTime = 0 ;
                [playButton setImage:_playBtnBG forState:UIControlStateNormal];
            }
        }
        else{
            [self.audioPlayer stop];
            if(path != nil)
            {
                self.progressBar.value = 0;
                [self prepareAudioPlayer];
                [playButton setImage:_playBtnBG forState:UIControlStateNormal];
                
                self.playedTimeLabel.text = [NSString stringWithFormat:@"%d:%02d", (int)self.audioPlayer.currentTime / 60, (int)self.audioPlayer.currentTime % 60, nil];
                self.remainingTimeLabel.text = [NSString stringWithFormat:@"-%d:%02d", (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) / 60, (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) % 60, nil];
                
            }
            self.strAudioPlaySetting = [NSString stringWithFormat:@"%@",[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSettingIndex]];
            
            
            self.noOfSecs=[[self.numberOfSecondArray objectAtIndex:self.tableRow] intValue];
            self.intDatePickerValue = self.noOfSecs;
            int hh = self.noOfSecs/(60*60);
            int mm = (self.noOfSecs/60)-(hh*60);
            int ss = self.noOfSecs-(hh*60*60)-(mm*60);
            //NSLog(@"Number of loops are:%d",self.noOfLoops);
            _labelmode.text = @"Audio Settings : Duration";
            if(self.audioPlayer!=nil)
            {
                self.counterLabel.hidden=NO;
                counterLabel.text = [NSString stringWithFormat:@" %2.2d  :  %2.2d  :  %2.2d",hh,mm,ss];
                _nameLabel.hidden = NO;
                _nameLabel.text = kHrMinSecLabelText;
            }
            
            else
                self.counterLabel.hidden = YES;
            
            
            
            [self.audioPlayer stop];
            [self.updateTimer invalidate];
            [self.countLoopTimer invalidate];
            timeIndex = 0;
            self.audioPlayer.currentTime = 0 ;
            [playButton setImage:_playBtnBG forState:UIControlStateNormal];
            
		}
        //[self animateSettingView];
	}
}

-(void)AppText :(NSInteger)selectedRow
{
    NSLog(@"SELECTED ROW %d",selectedRow);
    
    
    
    if(selectedRow == 0)
    {
        NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"comming_soon" ofType:@"html" inDirectory:nil];
        [self.webViewAppText loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
    }
    else if(selectedRow == 1)
    {
        NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"Shree sukta" ofType:@"html" inDirectory:nil];
        [self.webViewAppText loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
    }
    else if(selectedRow == 3)
    {
        NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"Maha laxmi aarti" ofType:@"html" inDirectory:nil];
        [self.webViewAppText loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
    }
    else if(selectedRow == 4)
    {
        NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"Ganpati aarti" ofType:@"html" inDirectory:nil];
        [self.webViewAppText loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
    }
    else if(selectedRow == 6)
    {
        NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"comming_soon" ofType:@"html" inDirectory:nil];
        [self.webViewAppText loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
    }
    else if(selectedRow == 8)
    {
        NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"comming_soon" ofType:@"html" inDirectory:nil];
        [self.webViewAppText loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
    }else
    {
        NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"comming_soon" ofType:@"html" inDirectory:nil];
        [self.webViewAppText loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
    }
}

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:@"RootViewController" bundle:nibBundleOrNil]) {
        
	}
	return self;
}*/


-(void)updateSlider

{
    if ([playButton imageForState:normal] ==  _pauseBtnBG) {
        progressBar.enabled = YES;
        
        progressBar.minimumValue = 0;
        progressBar.maximumValue = self.audioPlayer.duration;
        _isPlaying = YES;
        
        self.playedTimeLabel.text = [NSString stringWithFormat:@"%d:%02d", (int)self.audioPlayer.currentTime / 60, (int)self.audioPlayer.currentTime % 60, nil];
        self.remainingTimeLabel.text = [NSString stringWithFormat:@"-%d:%02d", (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) / 60, (int)(self.audioPlayer.duration - self.audioPlayer.currentTime) % 60, nil];
        
        progressBar.value = self.audioPlayer.currentTime ;
    }
    else{
        progressBar.enabled = NO;
    }
	
	
	
}
- (IBAction) sliderMoved
{
    if ([playButton imageForState:normal] ==  _pauseBtnBG) {
        
        [self.audioPlayer stop];
        self.audioPlayer.currentTime = progressBar.value;
        [self.audioPlayer play];
    }
}

#pragma mark - BUTTON EVENT HANDLERS
-(IBAction)otherAppsButtonPressed:(UIButton *)sender
{
  //  self.selectedRow=2;
  //  [self refreshView];
    
	NSString *urlString = globalValues.strOtherAppsLink;
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
	
}

-(IBAction)websiteButtonPressed:(UIButton *)sender
{
	NSString *urlString = globalValues.strWebsiteLink;
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
	
}

-(IBAction)btnWebsiteClicked
{
	NSString *urlString = [NSString stringWithFormat:@"%@",globalValues.strWebsiteLink];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

-(IBAction)btnFeedbackClicked
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail])
        {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            
            [picker setSubject:@"Feedback! - Shree Laxmi Aarti And Mantras"];
            
            // Set up recipients
            NSArray *toRecipients = [NSArray arrayWithObject:@"ipooja@mediaagility.com"];
            [picker setToRecipients:toRecipients];
            
            // Fill out the email body text
            NSString *emailBody = globalValues.strFeedbackText;
            [picker setMessageBody:emailBody isHTML:YES];
            
            [self presentModalViewController:picker animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Email" message:@"Please Login to Your Mail !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    
}

-(IBAction)btnFacebookClicked
{
//    NSString *urlString = @"https://www.facebook.com/iPoojaMobileApps";
//	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    [fbObject initWithAppId:@"1419577124932719" andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        fbObject.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        fbObject.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if (![fbObject isSessionValid]) {
        
        
        //        NSMutableDictionary * params =
        //        [NSMutableDictionary dictionaryWithObjectsAndKeys:
        //         @"select birthday, name, uid, pic_square from user where uid in (select uid2 from friend where uid1=me()) order by name",
        //         @"query",
        //         nil];
        //
        //        [self.facebook requestWithMethodName: @"fql.query" andParams: params andHttpMethod: @"POST" andDelegate: self];
        
        
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_likes",
                                @"read_stream",@"publish_actions",
                                nil];
        [fbObject authorize:permissions];
        //
    }
    else if([fbObject isSessionValid])
    {
        [self fbDidLogin];
    }
    
}
#pragma mark- facebook method
- (void)fbDidLogin
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"iPooja Apps", @"name",
                                   @"http://www.ipooja.com", @"link",
                                   @"iPooja Apps", @"caption",
                                   @"you can downloads more apps from ipooja.com", @"description",
                                   @"", @"message",
                                   nil];
    
    // Publish.
    // This is the most important method that you call. It does the actual job, the message posting.
    //  [fbObject requestWithGraphPath:@"me/feed" andParams:params andHttpMethod:@"POST" andDelegate:self];
    //    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
    //                                   //kAppId, @"app_id",
    //                                   @"", @"link",
    //                                   @"http://i-softinc.com/devloper/project_images/icon@2x.png", @"picture",
    //                                   @"", @"name",
    //                                   @"", @"caption",
    //                                   @"", @"description",
    //                                   nil];
    //
    //
    [fbObject dialog:@"feed" andParams:params andDelegate:self];
    
}
- (void)fbDidNotLogin:(BOOL)cancelled
{
}
- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt
{
}
- (void)fbDidLogout{
}
- (void)fbSessionInvalidated{
}
#pragma mark FBRequest Delegate
- (void)requestLoading:(FBRequest *)request
{
}
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *resp=(NSHTTPURLResponse *)response;
    if (resp.statusCode>=400)
    {
        [self request:request didFailWithError:[NSError errorWithDomain:@"400" code:400 userInfo:nil]];
    }
}
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    
}
- (void)request:(FBRequest *)request didLoad:(id)result
{
    
}


-(IBAction)btnTwitterClicked
{
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    NSString *sStatusMessage =@"You can more downloads from- http://www.ipooja.com/  or https://twitter.com/iPooja";
    [twitter setInitialText:sStatusMessage];
      [twitter addImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
    [self presentModalViewController:twitter animated:YES];
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result){
    };


//    NSString *urlString = @"https://twitter.com/iPooja";
//	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"mail sending cancaled");
			break;
		case MFMailComposeResultSaved:
            NSLog(@"mail results saved");
			break;
		case MFMailComposeResultSent:
            NSLog(@"mail sent sucessfully");
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Mail sent successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
			break;
		case MFMailComposeResultFailed:
            NSLog(@"mail results failed");
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
    
}

#pragma mark - AUTOROTATE

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self adjustViewsForOrientation:toInterfaceOrientation];
}

- (void) adjustViewsForOrientation:(UIInterfaceOrientation)orientation
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
            NSLog(@"LANDSCAPE");
            
            [self changeViewForLandscapeMode];
            
        }
        else if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
            NSLog(@"PORTRAIT");
            
            [self changeViewForPortraitMode];
        }
    }
    else{
        
    }
}

-(void)changeViewForLandscapeMode
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 1024, 768);
    self.mainImage.frame = CGRectMake(self.mainImage.frame.origin.x, self.mainImage.frame.origin.y, 1024, 768);
    

     volumeControler.frame=CGRectMake(519, 496, 150, 150);
    self.strImageName = [NSString stringWithFormat:@"Bg_Landscape.png"];
    
    UIImage *image = [UIImage imageNamed:self.strImageName];
    self.mainImage.image = image;
    
    self.imgViewSettingsBackground.frame = CGRectMake(0, 655, 1025, 50);
//    self.playButton.frame = CGRectMake(470, 657, 73, 44);
//    self.btnSettings.frame = CGRectMake(15, 657, 73, 44);
//    self.resetButton.frame = CGRectMake(930, 657, 73, 44);
    
    self.PreviousBtn.frame=CGRectMake(20, 657, 60, 60);
    self.resetButton.frame=CGRectMake(800, 657, 40, 40);

     volumeBtn.frame=CGRectMake(580, 658, 36, 36);
    
  //  self.playButton.frame = CGRectMake(470, 658, 40, 40);
    
    
     self.playButton.frame = CGRectMake(370, 658, 40, 40);
    
    self.btnSettings.frame = CGRectMake(180, 657, 40, 40);
    self.nextBtn.frame = CGRectMake(930, 657, 73, 44);
    
    
    self.imgViewAudioMode.frame = CGRectMake(0, 590, 1025, 67);
    self.labelmode.frame = CGRectMake(30, 615, 370, 21);
    self.counterLabel.frame = CGRectMake(760, 615, 197, 21);
    self.nameLabel.frame = CGRectMake(760, 590, 197, 21);
    
    self.beadText.frame = CGRectMake(900, 30, 96, 21);
    self.beadCounter.frame = CGRectMake(900, 54, 25, 21);
    
    self.malaText.frame = CGRectMake(42, 30, 96, 21);
    self.malaCounter.frame = CGRectMake(45, 54, 25, 21);
    
    self.progressBar.frame = CGRectMake(200, 100, 611, self.progressBar.frame.size.height);
    self.playedTimeLabel.frame = CGRectMake(150, 100, self.playedTimeLabel.frame.size.width, self.playedTimeLabel.frame.size.height);
    self.remainingTimeLabel.frame = CGRectMake(835, 100, self.remainingTimeLabel.frame.size.width, self.remainingTimeLabel.frame.size.height);
    
    //POPOVER
    if (_settingsClicked) {
        self.popOverController.popoverContentSize = CGSizeMake(320, 450);
        [self.mPopOverController presentPopoverFromRect:CGRectMake(320, 140, 320, 450) inView:self.view permittedArrowDirections:0 animated:YES];
    }
    self.txtViewAudioText.frame = CGRectMake(50, 140, 900, 430);
    
    self.instructionsView.frame = CGRectMake(self.instructionsView.frame.origin.x, self.instructionsView.frame.origin.y, 1024, 800);
    self.imgViewPoojaPresents.frame = CGRectMake(self.imgViewPoojaPresents.frame.origin.x, self.imgViewPoojaPresents.frame.origin.y, 60, self.imgViewPoojaPresents.frame.size.height);
    self.imgViewAppIcon.frame = CGRectMake(500, self.imgViewAppIcon.frame.origin.y, self.imgViewAppIcon.frame.size.width, self.imgViewAppIcon.frame.size.height);
    self.txtViewInfoText.frame = CGRectMake(self.txtViewInfoText.frame.origin.x, self.txtViewInfoText.frame.origin.y, 950, 440);
    self.btnFacebook.frame = CGRectMake(self.btnFacebook.frame.origin.x, 607, self.btnFacebook.frame.size.width, self.btnFacebook.frame.size.height);
    self.btnTwitter.frame = CGRectMake(500, 607, self.btnTwitter.frame.size.width, self.btnTwitter.frame.size.height);
    self.btnFeedback.frame = CGRectMake(860, 607, self.btnFeedback.frame.size.width, self.btnFeedback.frame.size.height);
    self.lblCopyRight.frame = CGRectMake(460,660 , self.lblCopyRight.frame.size.width, self.lblCopyRight.frame.size.height);
    self.lblAudioCopyRight.frame = CGRectMake(420, 680, self.lblAudioCopyRight.frame.size.width, self.lblAudioCopyRight.frame.size.height);
    self.imgViewFountainIcon.frame = CGRectMake(860, self.imgViewFountainIcon.frame.origin.y, self.imgViewFountainIcon.frame.size.width, self.imgViewFountainIcon.frame.size.height);
    
    self.webViewAppText.frame = CGRectMake(30, 140, 900, 430);
}
-(void)changeViewForPortraitMode
{
self.PreviousBtn.frame=CGRectMake(20, 902, 60, 60);
   self.nextBtn.frame=CGRectMake(698, 902, 60, 60);
     volumeBtn.frame=CGRectMake(569, 912, 36, 36);
    
       volumeControler.frame=CGRectMake(515, 770, 150, 150);
    //  self.nextBtn.frame =  CGRectMake(self.nextBtn.frame.origin.x,463 ,self.nextBtn.frame.size.width, self.nextBtn.frame.size.height);
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 768, 1004);
    self.mainImage.frame = CGRectMake(self.mainImage.frame.origin.x, self.mainImage.frame.origin.y, 768, 1004);
    
    self.strImageName = [NSString stringWithFormat:@"Bg_Portrait.png"];
    
    UIImage *image = [UIImage imageNamed:self.strImageName];
    self.mainImage.image = image;
    
    self.imgViewSettingsBackground.frame = CGRectMake(0, 910, 768, 50);
    self.playButton.frame = CGRectMake(284, 912, 40, 40);
    self.btnSettings.frame = CGRectMake(148, 912, 40, 40);
    self.resetButton.frame = CGRectMake(439, 912, 40, 40);
    
    self.imgViewAudioMode.frame = CGRectMake(self.imgViewAudioMode.frame.origin.x, 850, 768, 67);
    self.labelmode.frame = CGRectMake(30, 870, 370, 21);
    self.counterLabel.frame = CGRectMake(561, 870, 197, 21);
    self.nameLabel.frame = CGRectMake(561, 850, 197, 21);
    
    self.beadText.frame = CGRectMake(646, 41, 96, 21);
    self.beadCounter.frame = CGRectMake(656, 64, 25, 21);
    self.malaText.frame = CGRectMake(42, 41, 96, 21);
    self.malaCounter.frame = CGRectMake(45, 64, 25, 21);
    
    self.progressBar.frame = CGRectMake(106, 130, 560, self.progressBar.frame.size.height);
    self.playedTimeLabel.frame = CGRectMake(50, 130, 80, 21);
    self.remainingTimeLabel.frame = CGRectMake(685, 130, 80, 21);
    
    self.txtViewAudioText.frame = CGRectMake(50, 170, 697, 637);
    
    //POPOVER
    if (_settingsClicked) {
       self.popOverController.popoverContentSize = CGSizeMake(320, 450);
       [self.mPopOverController presentPopoverFromRect:CGRectMake(200, 240, 320, 450) inView:self.view permittedArrowDirections:0 animated:YES];
    }
    
    //INFO VIEW
    self.instructionsView.frame = CGRectMake(self.instructionsView.frame.origin.x, self.instructionsView.frame.origin.y, 768, 1004);
    self.imgViewPoojaPresents.frame = CGRectMake(self.imgViewPoojaPresents.frame.origin.x, self.imgViewPoojaPresents.frame.origin.y, 60, 60);
    self.imgViewAppIcon.frame = CGRectMake(380 ,self.imgViewAppIcon.frame.origin.y, self.imgViewAppIcon.frame.size.width, self.imgViewAppIcon.frame.size.height);
    self.imgViewFountainIcon.frame = CGRectMake(653, self.imgViewFountainIcon.frame.origin.y, self.imgViewFountainIcon.frame.size.width, self.imgViewFountainIcon.frame.size.height);
    
    self.txtViewInfoText.frame = CGRectMake(self.txtViewInfoText.frame.origin.x, self.txtViewInfoText.frame.origin.y, 718 , 650);
    self.btnFacebook.frame = CGRectMake(self.btnFacebook.frame.origin.x, 822, self.btnFacebook.frame.size.width, self.btnFacebook.frame.size.height);
    self.btnTwitter.frame = CGRectMake(390, 822, self.btnTwitter.frame.size.width, self.btnTwitter.frame.size.height);
    self.btnFeedback.frame = CGRectMake(640, 822, self.btnFeedback.frame.size.width, self.btnFeedback.frame.size.height);
    self.lblCopyRight.frame = CGRectMake(326,890 , self.lblCopyRight.frame.size.width, self.lblCopyRight.frame.size.height);
    self.lblAudioCopyRight.frame = CGRectMake(288, 914, self.lblAudioCopyRight.frame.size.width, self.lblAudioCopyRight.frame.size.height);

    self.webViewAppText.frame = CGRectMake(30, 170, 697, 637);
    
    
}

#pragma mark -  AUDIO SETTINGS DELEGATE
-(void)reflectSettingsChanges
{
    _settingsClicked=false;
    [self.popOverController dismissPopoverAnimated:YES];
    [self refreshView];
}

#pragma mark - WEBVIEW DELEGATE
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    NSString *myText = [self.webViewAppText stringByEvaluatingJavaScriptFromString:@"document.documentElement.textContent"];
//    NSLog(@"webview ...---->%@",myText);

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return YES;
    
    return 0;
}
#pragma mark - New Methods
- (IBAction)nextBtnAction:(id)sender {
      if (nextAudioVar<audioarray.count-1) {
       [self beadMalaInitialValue];
          [[NSUserDefaults standardUserDefaults]setObject:beadCounter.text forKey:[NSString stringWithFormat:@"Bead_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
          [[NSUserDefaults standardUserDefaults]setObject:malaCounter.text forKey:[NSString stringWithFormat:@"Mala_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
          nextAudioVar++;
          beadCounter.text=[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Bead_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
          
            malaCounter.text=[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Mala_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
          [self beadMalaInitialValue];
          [self.countLoopTimer invalidate];
      [self headerChange];
      [self  setAudioSettings];
    }
}
- (IBAction)previousBtnAction:(id)sender {
    NSLog(@"%d",nextAudioVar);
    if (nextAudioVar>0) {
        
        [self beadMalaInitialValue];
        [[NSUserDefaults standardUserDefaults]setObject:beadCounter.text forKey:[NSString stringWithFormat:@"Bead_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
        //
        [[NSUserDefaults standardUserDefaults]setObject:malaCounter.text forKey:[NSString stringWithFormat:@"Mala_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];

         [self.countLoopTimer invalidate];
        nextAudioVar--;
        
    beadCounter.text=[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Bead_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
        
    malaCounter.text=[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Mala_%@", [globalValues.marrForViewController1 objectAtIndex:nextAudioVar]]];
        [self beadMalaInitialValue];
        [self headerChange];
        [self  setAudioSettings];
    }
}
-(void)headerChange
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Helvetica" size:15];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor =[UIColor whiteColor];
    label.text=[NSString stringWithFormat:@"%@",[globalValues.marrForViewController1 objectAtIndex:nextAudioVar]];
    self.navigationItem.titleView = label;
    
    [self.audioPlayer stop];
    self.progressBar.value=0;
    NSString *path = [[NSBundle  mainBundle] pathForResource:[audioarray objectAtIndex:nextAudioVar] ofType:@"mp3"];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    self.audioPlayer.delegate = self;
    self.audioPlayer.currentTime = self.progressBar.value;
    
    // increase tempo of song
//    self.audioPlayer.enableRate=YES;
// 
//      self.audioPlayer.rate=2.0f;
    
    
    tempTimer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:self.audioPlayer repeats:YES];
    [self AppText:nextAudioVar];
   
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(void)beadMalaInitialValue
{
    if ([beadCounter.text length]==0) {
        beadCounter.text=@"0";
    }
    if ([malaCounter.text length]==0) {
        malaCounter.text=@"0";
    }
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
     NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"shake"]);
     
    if(motion == UIEventSubtypeMotionShake){
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"shake"] isEqualToString:@"ok"]){
                if (nextAudioVar<audioarray.count-1) {
                    nextAudioVar++;
                    [self headerChange];
                    [self alertViewSubMethod];
                    [self  setAudioSettings];
              }
     }
}
}
#pragma mark- swiep
-(void)NextSwipe
{
//    wallpaperViewController *wall=[[wallpaperViewController alloc]init];
//    [self.navigationController pushViewController:wall animated:YES];
}
-(void)handleSwipeRITE
{
       

   // [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)volumecontroller:(id)sender {
    if(volumeEnable==YES)
    {
        volumeControler.hidden=YES;
        volumeEnable=NO;
    }else
    {
        volumeEnable=YES;
        [volumeBtn setImage:[UIImage imageNamed:@"volume.png"] forState:UIControlStateNormal];
        volumeControler.hidden=NO;
    }

}
@end