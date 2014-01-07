//
//  GlobalValues_iLP.h
//  iCityPediaUniversal
//
//  Created by Vikas Singh on 04/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBConn;
@interface GlobalValues : NSObject

@property (strong, nonatomic) NSString *strForDisplayingTextInDifferentLanguage;

@property (strong, nonatomic) NSString *strMainMenuSelectedRow;

@property (strong, nonatomic) NSString *kRestoreIntroVariable1;
@property (strong, nonatomic) NSString *kRestoreLanguage1;


@property (strong, nonatomic) NSMutableArray *marrForViewController1;
@property (strong, nonatomic) NSMutableArray *marrForViewController2;
@property (strong, nonatomic) NSString *strNumberOfScreens;
@property (strong, nonatomic) NSString *strInfoText;
@property (strong, nonatomic) NSString *strOtherAppsLink;
@property (strong, nonatomic) NSString *strWebsiteLink;
@property (strong, nonatomic) NSString *strFeedbackText;
@property (strong, nonatomic) NSString *strTellFriendText;
@property (strong, nonatomic) NSString *strTellFriendSubject;
@property (strong, nonatomic) NSString *strCopyRightText;
@property (strong, nonatomic) NSString *strAudioCopyRightText;
@property (strong, nonatomic) NSString *strFooterLink1;
@property (strong, nonatomic) NSString *strFooterLink2;
@property (strong, nonatomic) NSString *strFooterLink3;
@property (strong, nonatomic) NSString *strFooterLink4;

@property (nonatomic) BOOL boolAudioSettingEnable;
@property (nonatomic) BOOL boolLanguageSettingEnable;
@property (nonatomic) BOOL boolNarrationSettingEnable;
@property (nonatomic) BOOL boolContinuousEnable;
@property (nonatomic) BOOL boolNumberOfTimesEnable;
@property (nonatomic) BOOL boolDurationEnable;

//SUB MENU
@property (nonatomic) BOOL boolSubMenuEnable;
@property (nonatomic) BOOL boolSubMenuIconsEnable;

//BOOL VARIABLES
@property (nonatomic) BOOL boolForDisplayingBackButtonInVC3;
@property (nonatomic) BOOL boolForTellFriendViewController1;
@property (nonatomic) BOOL boolForTellFriendViewController2;
@property (nonatomic) BOOL boolForTellFriendViewController3;
@property (nonatomic) BOOL boolForInfoViewController1;
@property (nonatomic) BOOL boolForInfoViewController2;
@property (nonatomic) BOOL boolForInfoViewController3;

@property (strong, nonatomic) NSString *strAppName;
@property (strong, nonatomic) NSString *strAppInfo;
@property (strong, nonatomic) NSString *strMainImage1;
@property (strong, nonatomic) NSString *strSubMainImage1;
@property (strong, nonatomic) NSString *strAudioScreenImage;

//BOOL VARIABLES FOR AUDIO SCREEN
@property (nonatomic) BOOL boolLanguageSettingsButton;
@property (nonatomic) BOOL boolLoopingSettingsButton;
@property (nonatomic) BOOL boolPlayButton;
@property (nonatomic) BOOL boolResetButton;
@property (nonatomic) BOOL boolMalaLabel;
@property (nonatomic) BOOL boolBeadsLabel;
@property (nonatomic) BOOL boolAudioSlider;
@property (nonatomic) BOOL boolScrollingTextForLyrics;
@property (nonatomic) BOOL boolTextEnable;

//BOOL VARIABLE FOR MAIN SCREEN
@property (nonatomic) BOOL boolForOtherAppsButton;
@property (nonatomic) BOOL boolForWebsiteButton;
@property (nonatomic) BOOL boolForFeedbackButton;
@property (nonatomic) BOOL boolForCellImageIcons;

@property (strong, nonatomic) NSMutableArray *marrForDisplayLanguage;
@property (strong, nonatomic) NSMutableArray *marrForCellImageIcons;
@property (strong, nonatomic) NSMutableArray *marrAllSettings;
@property (strong, nonatomic) NSMutableArray *marrAudioSettings;
@property (strong, nonatomic) NSMutableArray *marrNarrationSettings;
@property (strong, nonatomic) NSMutableArray *marrMenuText;
@property (strong, nonatomic) NSMutableArray *marrSubMenuText;

+ (id)sharedManager;

@end
