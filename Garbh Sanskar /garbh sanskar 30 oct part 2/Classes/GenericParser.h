//
//  GenericParser.h
//  iChant
//
//  Created by User on 2/15/13.
//
//

#import <Foundation/Foundation.h>

@interface GenericParser : NSObject <NSXMLParserDelegate>{
    
}

@property (strong, nonatomic) NSString *strDisplayEnglishText;
@property (strong, nonatomic) NSString *strDisplayHindiText;

@property (strong, nonatomic) NSMutableString *currentElementValue;
@property (strong, nonatomic) NSMutableArray *marrLocalSubMenuArray;
@property (strong, nonatomic) NSMutableArray *mainMenuArray;
@property (strong, nonatomic) NSMutableArray *subMenuArray;
@property (strong, nonatomic) NSMutableDictionary *stringAttributeDict;
@property (strong, nonatomic) NSMutableDictionary *mainMenuSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *subMainMenuSettingsDict;
@property (strong, nonatomic) NSMutableArray *subMainMenuItem0;
@property (strong, nonatomic) NSMutableArray *subMainMenuItem1;
@property (strong, nonatomic) NSMutableArray *subMainMenuItem2;
@property (strong, nonatomic) NSMutableArray *subMainMenuItem3;
@property (nonatomic) BOOL boolMenuArrayTag;
@property (nonatomic) BOOL boolItemOnMainMenuTag;
@property (nonatomic) BOOL boolItemOnMainMenuTag0;
@property (nonatomic) BOOL boolItemOnMainMenuTag1;
@property (nonatomic) BOOL boolItemOnMainMenuTag3;
@property (nonatomic) BOOL boolItemOnMainMenuTag2;
@property (nonatomic) BOOL boolItemOnSubMenuTag;
@property (nonatomic) BOOL boolStringTag;
@property (strong,nonatomic) NSString *strCurrentMainMenuSettingString;
@property (strong,nonatomic) NSString *strMainMenuArrayString;
@property (strong, nonatomic) NSString *strAppName;

@property (strong, nonatomic) NSMutableArray *marrSettings;
@property (strong, nonatomic) NSMutableArray *marrLanguageSettings;
@property (strong, nonatomic) NSMutableArray *marrNarrationSettings;
@property (strong, nonatomic) NSMutableArray *marrAudioSettings;
@property (strong, nonatomic) NSMutableArray *marrMainMenuTextEnable;
@property (strong, nonatomic) NSMutableArray *marrSubMenuTextEnable;
@property (strong, nonatomic) NSMutableArray *marrSubMenuTextEnableLocal;

@property (strong, nonatomic) NSMutableDictionary *mutableTextDictionary;
@property (strong, nonatomic) NSMutableArray *marrTextArray;
@property (strong, nonatomic) NSMutableArray *marrTextSubmenuArray;
- (GenericParser *) initGenericParser;

@end
