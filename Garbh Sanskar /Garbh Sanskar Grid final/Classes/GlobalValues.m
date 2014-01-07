//
//  GlobalValues_iLP.m
//  iCityPediaUniversal
//
//  Created by Vikas Singh on 04/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalValues.h"

static GlobalValues *sharedGlobalValues = nil;

@implementation GlobalValues

@synthesize strForDisplayingTextInDifferentLanguage = _strForDisplayingTextInDifferentLanguage;

@synthesize strMainMenuSelectedRow = _strMainMenuSelectedRow;

@synthesize kRestoreLanguage1 = _kRestoreLanguage1;
@synthesize kRestoreIntroVariable1 = _kRestoreIntroVariable1;
@synthesize strCopyRightText = _strCopyRightText;
@synthesize strAudioCopyRightText = _strAudioCopyRightText;

@synthesize marrForViewController1 = _marrForViewController1;
@synthesize marrForViewController2 = _marrForViewController2;
@synthesize strNumberOfScreens = _strNumberOfScreens;
@synthesize strInfoText = _strInfoText;
@synthesize strOtherAppsLink = _strOtherAppsLink;
@synthesize strWebsiteLink = _strWebsiteLink;
@synthesize strFeedbackText = _strFeedbackText;
@synthesize strTellFriendText = _strTellFriendText;
@synthesize strTellFriendSubject = _strTellFriendSubject;
@synthesize strFooterLink1 = _strFooterLink1;
@synthesize strFooterLink2 = _strFooterLink2;
@synthesize strFooterLink3 = _strFooterLink3;
@synthesize strFooterLink4 = _strFooterLink4;

@synthesize boolAudioSettingEnable = _boolAudioSettingEnable;
@synthesize boolLanguageSettingEnable = _boolLanguageSettingEnable;
@synthesize boolNarrationSettingEnable = _boolNarrationSettingEnable;
@synthesize boolContinuousEnable = _boolContinuousEnable;
@synthesize boolNumberOfTimesEnable = _boolNumberOfTimesEnable;
@synthesize boolDurationEnable = _boolDurationEnable;
@synthesize boolTextEnable = _boolTextEnable;

//SUB MENU
@synthesize boolSubMenuEnable = _boolSubMenuEnable;
@synthesize boolSubMenuIconsEnable = _boolSubMenuIconsEnable;

//BOOL VARIABLES
@synthesize  boolForDisplayingBackButtonInVC3 = _boolForDisplayingBackButtonInVC3;
@synthesize  boolForTellFriendViewController1 = _boolForTellFriendViewController1;
@synthesize  boolForTellFriendViewController2 = _boolForTellFriendViewController2;
@synthesize  boolForTellFriendViewController3 = _boolForTellFriendViewController3;
@synthesize  boolForInfoViewController1 = _boolForInfoViewController1;
@synthesize  boolForInfoViewController2 = _boolForInfoViewController2;
@synthesize  boolForInfoViewController3 = _boolForInfoViewController3;

@synthesize strAppName = _strAppName;
@synthesize strAppInfo = _strAppInfo;
@synthesize strMainImage1 = _strMainImage1;
@synthesize strSubMainImage1 = _strSubMainImage1;
@synthesize strAudioScreenImage = _strAudioScreenImage;

//BOOL VARIABLES FOR AUDIO SCREEN
@synthesize  boolLanguageSettingsButton = _boolLanguageSettingsButton;
@synthesize  boolLoopingSettingsButton = _boolLoopingSettingsButton;
@synthesize  boolPlayButton = _boolPlayButton;
@synthesize  boolResetButton = _boolResetButton;
@synthesize  boolMalaLabel = _boolMalaLabel;
@synthesize  boolBeadsLabel = _boolBeadsLabel;
@synthesize  boolAudioSlider = _boolAudioSlider;
@synthesize  boolScrollingTextForLyrics = _boolScrollingTextForLyrics;
@synthesize  boolForOtherAppsButton = _boolForOtherAppsButton;
@synthesize  boolForWebsiteButton = _boolForWebsiteButton;
@synthesize  boolForFeedbackButton = _boolForFeedbackButton;
@synthesize  boolForCellImageIcons = _boolForCellImageIcons;

@synthesize marrForDisplayLanguage = _marrForDisplayLanguage;
@synthesize marrForCellImageIcons = _marrForCellImageIcons;
@synthesize marrAllSettings = _marrAllSettings;
@synthesize marrAudioSettings = _marrAudioSettings;
@synthesize marrNarrationSettings = _marrNarrationSettings;
@synthesize marrMenuText = _marrMenuText;
@synthesize marrSubMenuText = _marrSubMenuText;

#pragma mark Singleton Methods

+ (id)sharedManager {
    @synchronized(self) {
        if(sharedGlobalValues == nil)
            sharedGlobalValues = [[super allocWithZone:NULL] init];
    }
    //_dbConn=[[DBConn alloc] init];
    return sharedGlobalValues;
}

+ (id)allocWithZone:(NSZone *)zone {
    //return [[self sharedManager] retain];
	return [self sharedManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)init {
    if (self = [super init])
    {
        self.strForDisplayingTextInDifferentLanguage = [[NSString alloc]init];
        
        self.strMainMenuSelectedRow = [[NSString alloc]init];
        
        self.kRestoreLanguage1 = [[NSString alloc]init];
        self.kRestoreLanguage1 = @"RestoreLanguage";
        
        
        self.kRestoreIntroVariable1 = [[NSString alloc]init];
        self.kRestoreIntroVariable1 = @"RestoreIntro";
        
        self.marrForViewController1 = [[NSMutableArray alloc]init];
        self.marrForViewController2 = [[NSMutableArray alloc]init];
        self.strNumberOfScreens = [[NSString alloc]init];
        self.strInfoText = [[NSString alloc]init];
        self.strOtherAppsLink = [[NSString alloc]init];
        self.strWebsiteLink = [[NSString alloc]init];
        self.strFeedbackText = [[NSString alloc]init];
        self.strTellFriendText = [[NSString alloc]init];
        self.strTellFriendSubject = [[NSString alloc]init];
        self.strCopyRightText = [[NSString alloc]init];
        self.strAudioCopyRightText = [[NSString alloc]init];
        self.strFooterLink1 = [[NSString alloc]init];
        self.strFooterLink2 = [[NSString alloc]init];
        self.strFooterLink3 = [[NSString alloc]init];
        self.strFooterLink4 = [[NSString alloc]init];
        
        self.boolAudioSettingEnable = NO;
        self.boolLanguageSettingEnable = NO;
        self.boolNarrationSettingEnable = NO;
        self.boolContinuousEnable = NO;
        self.boolNumberOfTimesEnable = NO;
        self.boolDurationEnable = NO;
        self.boolTextEnable = NO;
        
        //SUB MENU
        self.boolSubMenuEnable = NO;
        self.boolSubMenuIconsEnable = NO;
        
        //BOOL VARIABLES
        self.boolForDisplayingBackButtonInVC3 = NO;
        self.boolForTellFriendViewController1 = NO;
        self.boolForTellFriendViewController2 = NO;
        self.boolForTellFriendViewController3 = NO;
        self.boolForInfoViewController1 = NO;
        self.boolForInfoViewController2 = NO;
        self.boolForInfoViewController3 = NO;
        
        self.strAppName = [[NSString alloc]init];
        self.strAppInfo = [[NSString alloc]init];
        self.strMainImage1 = [[NSString alloc]init];
        self.strSubMainImage1 = [[NSString alloc]init];
        self.strAudioScreenImage = [[NSString alloc]init];
        
        //BOOL VARIABLES FOR AUDIO SCREEN
        self.boolLanguageSettingsButton = NO;
        self.boolLoopingSettingsButton = NO;
        self.boolPlayButton = NO;
        self.boolMalaLabel = NO;
        self.boolBeadsLabel = NO;
        self.boolResetButton = NO;
        self.boolAudioSlider = NO;
        self.boolScrollingTextForLyrics = NO;
        self.boolForCellImageIcons = NO;
        
        self.marrForDisplayLanguage = [[NSMutableArray alloc]init];
        self.marrForCellImageIcons = [[NSMutableArray alloc]init];
        self.marrAllSettings = [[NSMutableArray alloc]init];
        self.marrAudioSettings = [[NSMutableArray alloc]init];
        self.marrNarrationSettings = [[NSMutableArray alloc]init];
        self.marrMenuText = [[NSMutableArray alloc]init];
        self.marrSubMenuText = [[NSMutableArray alloc]init];
    }
        return self;
}



@end


