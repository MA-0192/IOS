//
//  ichantAppDelegate.m
//  ichant
//
//  Created by Abhijeet barge on 12/18/09.
//  Copyright __eBusinessware india pvt. ltd.__ 2010. All rights reserved.
//

#import "iChantAppDelegate.h"
#import "GlobalValues.h"
#import "GenericParser.h"
#import "Constants.h"
#import "Flurry.h"
#import "Appirater.h"

@implementation iChantAppDelegate
@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize objViewController1 = _objViewController1;
@synthesize objRootViewController = _objRootViewController;
@synthesize mNavigationController = _mNavigationController;
@synthesize thumbImageArr;
@synthesize narrations = _narrations;
@synthesize displayLanguages = _displayLanguages;
@synthesize beadsArray = _beadsArray;
@synthesize malasArray = _malasArray;
@synthesize selectedAudioSettingArray = _selectedAudioSettingArray;
@synthesize numberOfTimesArray = _numberOfTimesArray;
@synthesize numberOfSecondArray = _numberOfSecondArray;

#pragma mark -
#pragma mark Application lifecycle

GlobalValues *globalValues;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Override point for customization after app launch
	
    globalValues = [GlobalValues sharedManager];
    
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"strings" ofType:@"xml"]];
    
    NSData *data=[NSData dataWithContentsOfURL:baseURL];
    NSString *data1=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"%@",data1);
    
    NSString *strNewLine = [data1 stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
    strNewLine = [strNewLine stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    strNewLine = [strNewLine stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
     strNewLine = [strNewLine stringByReplacingOccurrencesOfString:@"  " withString:@" "];
     strNewLine = [strNewLine stringByReplacingOccurrencesOfString:@"  " withString:@" "];
     strNewLine = [strNewLine stringByReplacingOccurrencesOfString:@"  " withString:@" "];
     strNewLine = [strNewLine stringByReplacingOccurrencesOfString:@"  " withString:@" "];
     strNewLine = [strNewLine stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    NSLog(@"NEW LINE %@", strNewLine);
   // NSString *convertedStr=[data1 stringByReplacingOccurrencesOfString:@"&" withString:@"ampersand"];
    //NSLog(@"XML %@", convertedStr);

	//convertedStr=[convertedStr stringByReplacingOccurrencesOfString:@"\\'s" withString:@""];
    //convertedStr=[convertedStr stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
	NSData *data2 = [[NSData alloc] initWithData:[strNewLine dataUsingEncoding:NSUTF8StringEncoding]];
	//NSLog(@"%@", data2);
	//NSLog(@"%@",convertedStr);
    
    NSXMLParser *xmlParser=[[NSXMLParser alloc]initWithData:data2];
    //Initialize the delegate.
	GenericParser *parser = [[GenericParser alloc] initGenericParser];
	
	//Set delegate
	[xmlParser setDelegate:parser];
	
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
	if(success)
		NSLog(@"No Errors");
	else
		NSLog(@"Error Error Error!!!");
    
    NSLog(@"main menu array = %@",parser.mainMenuArray);
    NSLog(@"sub menu array = %@",parser.subMenuArray);
    NSLog(@"Settings array  = %@", parser.marrSettings);
    NSLog(@"Audio Settings array  = %@", parser.marrAudioSettings);
    NSLog(@"Language Settings array  = %@", parser.marrLanguageSettings);
    NSLog(@"Narration Settings array  = %@", parser.marrNarrationSettings);
    NSLog(@"MAIN MENU TEXT ENABLE  = %@", parser.marrMainMenuTextEnable);
    NSLog(@"marrMenuSetting dictionary = %@",parser.mainMenuSettingsDict);
    NSLog(@"marrSubMenuTextEnable = %@",parser.marrSubMenuTextEnable);
    NSLog(@"marrTextArray = %@",parser.marrTextArray);
    NSLog(@"marrSubmenuTextArray = %@",parser.marrTextSubmenuArray);
    
    //SHOWING VALUES FROM PARSER
    globalValues.strAppName = [parser.mainMenuSettingsDict objectForKey:@"app_name"];
    globalValues.marrForViewController1 = parser.mainMenuArray;
    globalValues.marrForViewController2 = parser.subMenuArray;
    globalValues.marrAllSettings = parser.marrSettings;
    globalValues.marrForDisplayLanguage = parser.marrLanguageSettings;
    globalValues.marrAudioSettings = parser.marrAudioSettings;
    globalValues.marrNarrationSettings = parser.marrNarrationSettings;
    globalValues.marrMenuText = parser.marrTextArray;
    globalValues.marrSubMenuText = parser.marrTextSubmenuArray;
    
    //INFO ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"info_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolForInfoViewController1 = YES;
    }
    else{
        globalValues.boolForInfoViewController1 = NO;
    }
    
    //TELL A FRIEND ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"tell_a_freind_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolForTellFriendViewController1 = YES;
    }
    else{
        globalValues.boolForTellFriendViewController1 = NO;
    }
    
    //OTHER APP ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"other_app_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolForOtherAppsButton = YES;
    }
    else{
        globalValues.boolForOtherAppsButton = NO;
    }
    
    //WEBSITE ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"web_site_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolForWebsiteButton = YES;
    }
    else{
        globalValues.boolForWebsiteButton = NO;
    }
    
    //FEEDBACK ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"feedback_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolForFeedbackButton = YES;
    }
    else{
        globalValues.boolForFeedbackButton = NO;
    }

    //MAIN MENU ICONS ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"main_menu_icons_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolForCellImageIcons = YES;
    }
    else{
        globalValues.boolForCellImageIcons = NO;
    }
    
    //SUB MENU ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"sub_menu_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolSubMenuEnable = YES;
    }
    else{
        globalValues.boolSubMenuEnable = NO;
    }
    
    //SUB MENU ICONS ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"sub_menu_icon_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolSubMenuIconsEnable = YES;
    }
    else{
        globalValues.boolSubMenuIconsEnable = NO;
    }
    
    //MALA ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"mala_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolMalaLabel = YES;
    }
    else{
        globalValues.boolMalaLabel = NO;
    }
    
    //BEADS ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"beads_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolBeadsLabel = YES;
    }
    else{
        globalValues.boolBeadsLabel = NO;
    }
    
    //SEEK BAR ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"SeekBar_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolAudioSlider = YES;
    }
    else{
        globalValues.boolAudioSlider = NO;
    }
    
    //TEXT ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"Text_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolTextEnable = YES;
    }
    else{
        globalValues.boolTextEnable = NO;
    }
    
    //PLAY PAUSE ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"PlayPause_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolPlayButton = YES;
    }
    else{
        globalValues.boolPlayButton = NO;
    }
    
    //SETTINGS ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"Setting_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolLoopingSettingsButton = YES;
    }
    else{
        globalValues.boolLoopingSettingsButton = NO;
    }
    
    //SETTINGS ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"Refresh_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolResetButton = YES;
    }
    else{
        globalValues.boolResetButton = NO;
    }
    
    //LANGUAGE SETTINGS ENABLE
    if([[parser.mainMenuSettingsDict objectForKey:@"Language_Setting_Items"]isEqualToString:@"Yes"])
    {
        globalValues.boolLanguageSettingsButton = YES;
    }
    else{
        globalValues.boolLanguageSettingsButton = NO;
    }
    
    //AUDIO SETTINGS
    if([[parser.mainMenuSettingsDict objectForKey:@"audio_setting_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolAudioSettingEnable = YES;
    }
    else{
        globalValues.boolAudioSettingEnable = NO;
    }
    
    //CONTINUOUS
    if([[parser.mainMenuSettingsDict objectForKey:@"continuous_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolContinuousEnable = YES;
    }
    else{
        globalValues.boolContinuousEnable = NO;
    }
    
    //NUMBER OF TIMES
    if([[parser.mainMenuSettingsDict objectForKey:@"nooftimes_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolNumberOfTimesEnable = YES;
    }
    else{
        globalValues.boolNumberOfTimesEnable = NO;
    }
    
    //DURATION
    if([[parser.mainMenuSettingsDict objectForKey:@"duration_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolDurationEnable = YES;
    }
    else{
        globalValues.boolDurationEnable = NO;
    }
    
    //LANGUAGE SETTINGS
    if([[parser.mainMenuSettingsDict objectForKey:@"display_language_setting_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolLanguageSettingEnable = YES;
    }
    else{
        globalValues.boolLanguageSettingEnable = NO;
    }
    
    //NARRATION SETTINGS
    if([[parser.mainMenuSettingsDict objectForKey:@"narration_language_setting_enable"]isEqualToString:@"Yes"])
    {
        globalValues.boolNarrationSettingEnable = YES;
    }
    else{
        globalValues.boolNarrationSettingEnable = NO;
    }
    
    globalValues.strTellFriendSubject = [parser.mainMenuSettingsDict objectForKey:@"friend_subject"];
    globalValues.strTellFriendText = [parser.mainMenuSettingsDict objectForKey:@"friend_default_text"];
    globalValues.strOtherAppsLink = [parser.mainMenuSettingsDict objectForKey:@"other_app_link"];
    globalValues.strWebsiteLink = [parser.mainMenuSettingsDict objectForKey:@"web_site_link"];
    globalValues.strFeedbackText = [parser.mainMenuSettingsDict objectForKey:@"feedback_default_text"];
    globalValues.strInfoText = [parser.mainMenuSettingsDict objectForKey:@"info_text"];
    globalValues.strCopyRightText = [parser.mainMenuSettingsDict objectForKey:@"copyright_text1"];
    globalValues.strAudioCopyRightText = [parser.mainMenuSettingsDict objectForKey:@"copyright_text2"];
    globalValues.strFooterLink1 = [parser.mainMenuSettingsDict objectForKey:@"main_menu_footer_icon1_link"];
    globalValues.strFooterLink2 = [parser.mainMenuSettingsDict objectForKey:@"main_menu_footer_icon2_link"];
    globalValues.strFooterLink3 = [parser.mainMenuSettingsDict objectForKey:@"main_menu_footer_icon3_link"];
    globalValues.strFooterLink4 = [parser.mainMenuSettingsDict objectForKey:@"main_menu_footer_icon4_link"];
    
    [self createUserDefualtForSampleItem];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self.objViewController1 = [[ViewController1 alloc] initWithNibName:@"ViewController1" bundle:nil];
        
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self.objViewController1 = [[ViewController1 alloc] initWithNibName:@"ViewController1-iPad" bundle:nil];
    }
    self.mNavigationController = [[UINavigationController alloc] initWithRootViewController:self.objViewController1];
    
    self.window.rootViewController = self.mNavigationController;
    [self.window makeKeyAndVisible];
    
    
    [Appirater setAppId:@"725395162"];
    [Appirater setDaysUntilPrompt:5];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:0];
    [Appirater setTimeBeforeReminding:2];
    //[Appirater setDebug:YES];
  //  3002730345
    //Flurry Initialise
    [Flurry startSession:@"7GMSVG2GXK545DHZTT2Y"];
}

-(void) createUserDefualtForSampleItem
{
    
	self.userDefaults=[NSUserDefaults standardUserDefaults];
	self.narrations=[[[NSUserDefaults standardUserDefaults]objectForKey:kNarration] mutableCopy];
	self.displayLanguages=[[[NSUserDefaults standardUserDefaults] objectForKey:kDisplayLanguages] mutableCopy];
	self.beadsArray=[[[NSUserDefaults standardUserDefaults] objectForKey:kBeadsArray] mutableCopy];
	self.malasArray=[[[NSUserDefaults standardUserDefaults] objectForKey:kMalaArray] mutableCopy];
	self.selectedAudioSettingArray=[[[NSUserDefaults standardUserDefaults] objectForKey:kSelectedAudioSetting] mutableCopy];
	self.numberOfTimesArray=[[[NSUserDefaults standardUserDefaults]objectForKey:kNumberOfTimesArray] mutableCopy];
	self.numberOfSecondArray=[[[NSUserDefaults standardUserDefaults] objectForKey:kNumberOfSecondsArray] mutableCopy];
    
    NSLog(@"self.narrations = %@",self.narrations);
	
    if(self.narrations == NULL)
    {
        self.narrations = [[NSMutableArray alloc]init];
        [self.narrations addObject:@"0"];
        NSLog(@"self.narrations = %@",self.narrations);
        [self.userDefaults setObject:self.narrations forKey:kNarration];
    }
	
    if([self.displayLanguages count] == 0)
    {
        self.displayLanguages=[[NSMutableArray alloc] init];
        [self.displayLanguages addObject:@"0"];
        [self.userDefaults setObject:self.displayLanguages forKey:kDisplayLanguages];
    }
    
//    if([self.beadsArray count] == 0)
//    {
//        self.beadsArray=[[NSMutableArray alloc] init];
//        [self.beadsArray addObject:@"0"];
//        [self.userDefaults setObject:self.beadsArray forKey:kBeadsArray];
//    }
//    
//    if([self.malasArray count] == 0)
//    {
//        self.malasArray=[[NSMutableArray alloc] init];
//        [self.malasArray addObject:@"0"];
//        [self.userDefaults setObject:self.malasArray forKey:kMalaArray];
//    }
    
    if([self.selectedAudioSettingArray count] == 0)
    {
        self.selectedAudioSettingArray=[[NSMutableArray alloc] init];
        [self.selectedAudioSettingArray addObject:@"0"];
        [self.userDefaults setObject:self.selectedAudioSettingArray forKey:kSelectedAudioSetting];
    }
	
    if([self.numberOfTimesArray count] == 0)
    {
        self.numberOfTimesArray=[[NSMutableArray alloc] init];
        [self.numberOfTimesArray addObject:@"1"];
        [self.userDefaults setObject:self.numberOfTimesArray forKey:kNumberOfTimesArray];
    }
    
    if([self.numberOfSecondArray count] == 0)
    {
        self.numberOfSecondArray=[[NSMutableArray alloc]init];
        [self.numberOfSecondArray addObject:@"60"];
        [self.userDefaults setObject:self.numberOfSecondArray forKey:kNumberOfSecondsArray];
    }
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSLog(@"narrations = %@",[[NSUserDefaults standardUserDefaults]objectForKey:kNarration]);
        	
}
// Pre 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return [[self.objViewController1 fbObject] handleOpenURL:url];
}

// For 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    return [[self.objViewController1 fbObject] handleOpenURL:url];
}
- (void)applicationWillTerminate:(UIApplication *)application
{
	// Save data if appropriate
	NSLog(@"application terminated");
}
#pragma mark -
#pragma mark Memory management
@end

