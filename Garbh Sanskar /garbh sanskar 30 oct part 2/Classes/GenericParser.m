//
//  GenericParser.m
//  iChant
//
//  Created by User on 2/15/13.
//
//

#import "GenericParser.h"

@implementation GenericParser


@synthesize currentElementValue = _currentElementValue;
@synthesize marrLocalSubMenuArray = _marrLocalSubMenuArray;
@synthesize mainMenuArray = _mainMenuArray;
@synthesize subMenuArray = _subMenuArray;
@synthesize stringAttributeDict = _stringAttributeDict;
@synthesize mainMenuSettingsDict = _mainMenuSettingsDict;
@synthesize subMainMenuSettingsDict = _subMainMenuSettingsDict;
@synthesize subMainMenuItem0 = _subMainMenuItem0;
@synthesize subMainMenuItem1 = _subMainMenuItem1;
@synthesize subMainMenuItem2 = _subMainMenuItem2;
@synthesize subMainMenuItem3 = _subMainMenuItem3;
@synthesize boolMenuArrayTag = _boolMenuArrayTag;
@synthesize boolItemOnMainMenuTag = _boolItemOnMainMenuTag;
@synthesize boolItemOnMainMenuTag0 = _boolItemOnMainMenuTag0;
@synthesize boolItemOnMainMenuTag1 = _boolItemOnMainMenuTag1;
@synthesize boolItemOnMainMenuTag2 = _boolItemOnMainMenuTag2;
@synthesize boolItemOnMainMenuTag3 = _boolItemOnMainMenuTag3;
@synthesize boolItemOnSubMenuTag = _boolItemOnSubMenuTag;
@synthesize boolStringTag = _boolStringTag;
@synthesize strCurrentMainMenuSettingString = _strCurrentMainMenuSettingString;
@synthesize strMainMenuArrayString = _strMainMenuArrayString;
@synthesize strAppName = _strAppName;

@synthesize marrSettings = _marrSettings;
@synthesize marrLanguageSettings = _marrLanguageSettings;
@synthesize marrNarrationSettings = _marrNarrationSettings;
@synthesize marrAudioSettings = _marrAudioSettings;
@synthesize marrMainMenuTextEnable = _marrMainMenuTextEnable;
@synthesize marrSubMenuTextEnable = _marrSubMenuTextEnable;
@synthesize marrSubMenuTextEnableLocal = _marrSubMenuTextEnableLocal;

@synthesize mutableTextDictionary = _mutableTextDictionary;
@synthesize marrTextArray = _marrTextArray;
@synthesize marrTextSubmenuArray = _marrTextSubmenuArray;


- (GenericParser *) initGenericParser {
	
	self = [super init];
    
    _mainMenuArray=[[NSMutableArray alloc] init];
    _mainMenuSettingsDict=[[NSMutableDictionary alloc]init];
    _subMainMenuSettingsDict=[[NSMutableDictionary alloc]init];
    _subMainMenuItem0=[[NSMutableArray alloc]init];
    _subMainMenuItem1=[[NSMutableArray alloc]init];
    _subMainMenuItem2=[[NSMutableArray alloc]init];
    _subMainMenuItem3=[[NSMutableArray alloc]init];
    _marrLocalSubMenuArray = [[NSMutableArray alloc]init];
    _subMenuArray = [[NSMutableArray alloc]init];
    _marrSettings = [[NSMutableArray alloc]init];
    _marrAudioSettings = [[NSMutableArray alloc]init];
    _marrLanguageSettings = [[NSMutableArray alloc]init];
    _marrNarrationSettings = [[NSMutableArray alloc]init];
    _marrMainMenuTextEnable = [[NSMutableArray alloc]init];
    _marrSubMenuTextEnable = [[NSMutableArray alloc]init];
    _marrSubMenuTextEnableLocal = [[NSMutableArray alloc]init];
	_marrTextArray = [[NSMutableArray alloc]init];
    _mutableTextDictionary = [[NSMutableDictionary alloc]init];
    _marrTextSubmenuArray = [[NSMutableArray alloc]init];
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"resources"])
    {
        //return;
    }
    
    if ([elementName isEqualToString:@"string"])
    {
        self.boolStringTag = YES;
        
        //NSLog(@" string attribute dictionary %@",attributeDict);
        
        if ([[attributeDict valueForKey:@"name"] isEqualToString:@"app_name"])
        {
            self.strCurrentMainMenuSettingString = @"app_name";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"display_language_setting_enable"])
        {
            self.strCurrentMainMenuSettingString = @"display_language_setting_enable";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"narration_language_setting_enable"])
        {
            self.strCurrentMainMenuSettingString = @"narration_language_setting_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"info_enable"])
        {
            self.strCurrentMainMenuSettingString = @"info_enable";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"tell_a_freind_enable"])
        {
            self.strCurrentMainMenuSettingString = @"tell_a_freind_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"friend_subject"])
        {
            self.strCurrentMainMenuSettingString = @"friend_subject";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"friend_default_text"])
        {
            self.strCurrentMainMenuSettingString = @"friend_default_text";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"other_app_enable"])
        {
            self.strCurrentMainMenuSettingString = @"other_app_enable";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"other_app_link"])
        {
            self.strCurrentMainMenuSettingString = @"other_app_link";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"web_site_enable"])
        {
            self.strCurrentMainMenuSettingString = @"web_site_enable";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"web_site_link"])
        {
            self.strCurrentMainMenuSettingString = @"web_site_link";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"feedback_enable"])
        {
            self.strCurrentMainMenuSettingString = @"feedback_enable";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"feedback_default_text"])
        {
            self.strCurrentMainMenuSettingString = @"feedback_default_text";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"main_menu_icons_enable"])
        {
            self.strCurrentMainMenuSettingString = @"main_menu_icons_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"sub_menu_enable"])
        {
            self.strCurrentMainMenuSettingString = @"sub_menu_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"sub_menu_icon_enable"])
        {
            self.strCurrentMainMenuSettingString = @"sub_menu_icon_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"mala_enable"])
        {
            self.strCurrentMainMenuSettingString = @"mala_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"beads_enable"])
        {
            self.strCurrentMainMenuSettingString = @"beads_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"beads_enable"])
        {
            self.strCurrentMainMenuSettingString = @"beads_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"Numberoftimes_enable"])
        {
            self.strCurrentMainMenuSettingString = @"Numberoftimes_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"SeekBar_enable"])
        {
            self.strCurrentMainMenuSettingString = @"SeekBar_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"PlayPause_enable"])
        {
            self.strCurrentMainMenuSettingString = @"PlayPause_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"Setting_enable"])
        {
            self.strCurrentMainMenuSettingString = @"Setting_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"Refresh_enable"])
        {
            self.strCurrentMainMenuSettingString = @"Refresh_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"Text_enable"])
        {
            self.strCurrentMainMenuSettingString = @"Text_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"audio_setting_enable"])
        {
            self.strCurrentMainMenuSettingString = @"audio_setting_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"continuous_enable"])
        {
            self.strCurrentMainMenuSettingString = @"continuous_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"nooftimes_enable"])
        {
            self.strCurrentMainMenuSettingString = @"nooftimes_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"duration_enable"])
        {
            self.strCurrentMainMenuSettingString = @"duration_enable";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"info_text"])
        {
            self.strCurrentMainMenuSettingString = @"info_text";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"copyright_text1"])
        {
            self.strCurrentMainMenuSettingString = @"copyright_text1";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"copyright_text2"])
        {
            self.strCurrentMainMenuSettingString = @"copyright_text2";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"main_menu_footer_icon1_link"])
        {
            self.strCurrentMainMenuSettingString = @"main_menu_footer_icon1_link";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"main_menu_footer_icon2_link"])
        {
            self.strCurrentMainMenuSettingString = @"main_menu_footer_icon2_link";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"main_menu_footer_icon3_link"])
        {
            self.strCurrentMainMenuSettingString = @"main_menu_footer_icon3_link";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"main_menu_footer_icon4_link"])
        {
            self.strCurrentMainMenuSettingString = @"main_menu_footer_icon4_link";
        }
        else{
            self.strCurrentMainMenuSettingString = @"nothingToParse";
        }
        
        if([[self.mainMenuSettingsDict objectForKey:@"sub_menu_enable"]isEqualToString:@"No"])
        {
            for (int i=0; i<[self.mainMenuArray count]; i++) {
                for (int j=0; j<[self.marrLanguageSettings count]; j++) {
                    NSString *strMainMenuText = [NSString stringWithFormat:@"main_menu%d_%@",i,[self.marrLanguageSettings objectAtIndex:j]];
                    if ([[attributeDict valueForKey:@"name"] isEqualToString:strMainMenuText]) {
                        self.strCurrentMainMenuSettingString = strMainMenuText;
                    }
                }
            }
        }
        else if([[self.mainMenuSettingsDict objectForKey:@"sub_menu_enable"]isEqualToString:@"Yes"]){
            for (int i=0; i<[self.mainMenuArray count]; i++) {
                if ([self.subMenuArray count]>0) {
                    //NSLog(@"Sub menu = %@",self.subMenuArray);
                    for(int k=0; k<[[self.subMenuArray objectAtIndex:i] count];k++){
                        for (int j=0; j<[self.marrLanguageSettings count]; j++) {
                            NSString *strSubMenuText = [NSString stringWithFormat:@"menu%d_submenu%d_%@",i,k,[self.marrLanguageSettings objectAtIndex:j]];
                            if ([[attributeDict valueForKey:@"name"] isEqualToString:strSubMenuText]) {
                                self.strCurrentMainMenuSettingString = strSubMenuText;
                            }
                        }
                    }
                    
                }
            }
            
        }
    }
    
    if(([self.strMainMenuArrayString isEqualToString:@"mainmenu_array"]) || ([self.strMainMenuArrayString isEqualToString:@"submenu_array"]) || ([self.strMainMenuArrayString isEqualToString:@"Setting_items"]) || ([self.strMainMenuArrayString isEqualToString:@"Audio_Setting_Items"]) || ([self.strMainMenuArrayString isEqualToString:@"Language_Setting_Items"]) || ([self.strMainMenuArrayString isEqualToString:@"Narration_Setting_Items"]))
    {
        if([elementName isEqualToString:@"item"])
            self.boolMenuArrayTag = YES;
    }
    
    //STRING ARRAY
    if ([elementName isEqualToString:@"string-array"])
    {
        // NSLog(@"%@",attributeDict);
        
        if ([[attributeDict valueForKey:@"name"] isEqualToString:@"mainmenu_array"])
        {
            self.strMainMenuArrayString = @"mainmenu_array";
        }
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"Setting_items"])
        {
            self.strMainMenuArrayString = @"Setting_items";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"Audio_Setting_Items"])
        {
            self.strMainMenuArrayString = @"Audio_Setting_Items";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"Language_Setting_Items"])
        {
            self.strMainMenuArrayString = @"Language_Setting_Items";
        }
        
        else if ([[attributeDict valueForKey:@"name"] isEqualToString:@"Narration_Setting_Items"])
        {
            self.strMainMenuArrayString = @"Narration_Setting_Items";
        }
        else{
            self.strMainMenuArrayString = @"NothingToParse";
        }
        
        for (int i=0; i<[self.mainMenuArray count]; i++) {
            NSString *strMainItemValue = [[NSString alloc]initWithFormat:@"main_menu_item%d",i];
            if ([[attributeDict valueForKey:@"name"]isEqualToString:strMainItemValue]) {
                self.strMainMenuArrayString = @"submenu_array";
            }
        }
        
        /*if([[self.mainMenuSettingsDict objectForKey:@"sub_menu_enable"]isEqualToString:@"No"])
         {
         if ([[attributeDict valueForKey:@"name"] isEqualToString:@"text_enable"])
         {
         self.strMainMenuArrayString = @"text_enable";
         }
         }
         else
         {
         for (int i=0; i<[self.mainMenuArray count]; i++) {
         NSString *strMainItemValue = [[NSString alloc]initWithFormat:@"main_menu_item%d_text_enable",i];
         if ([[attributeDict valueForKey:@"name"]isEqualToString:strMainItemValue]) {
         self.strMainMenuArrayString = @"submenu_text_enable_array";
         }
         }
         }*/
        
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // NSLog(@"string = %@",string);
    
    if(!self.currentElementValue)
        self.currentElementValue = [[NSMutableString alloc] initWithString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    else
        [self.currentElementValue appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    NSRange range = {0, [self.currentElementValue length]};
    
    [self.currentElementValue replaceOccurrencesOfString:@"| " withString:@"|\n\n" options:0 range:range];

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (self.boolStringTag == YES)
    {
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"app_name"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"display_language_setting_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"narration_language_setting_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"info_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"tell_a_freind_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"friend_default_text"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"friend_subject"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"other_app_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"other_app_link"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"web_site_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"web_site_link"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"feedback_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"feedback_default_text"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"main_menu_icons_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"sub_menu_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"sub_menu_icon_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"mala_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"beads_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"Numberoftimes_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"SeekBar_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"PlayPause_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"Setting_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"Refresh_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"Text_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"audio_setting_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"continuous_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"nooftimes_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"duration_enable"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"info_text"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"copyright_text1"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"copyright_text2"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"main_menu_footer_icon1_link"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"main_menu_footer_icon2_link"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"main_menu_footer_icon3_link"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if ([self.strCurrentMainMenuSettingString isEqualToString:@"main_menu_footer_icon4_link"])
        {
            [_mainMenuSettingsDict setValue:self.currentElementValue forKey:self.strCurrentMainMenuSettingString];
        }
        
        if([[self.mainMenuSettingsDict objectForKey:@"sub_menu_enable"]isEqualToString:@"No"])
        {
            for (int i=0; i<[self.mainMenuArray count]; i++) {
                if ([[self.mainMenuSettingsDict objectForKey:@"display_language_setting_enable"]isEqualToString:@"Yes"])
                {
                    for (int j=0; j<[self.marrLanguageSettings count]; j++) {
                        NSString *strMainMenuText = [NSString stringWithFormat:@"main_menu%d_%@",i,[self.marrLanguageSettings objectAtIndex:j]];
                        if ([self.strCurrentMainMenuSettingString isEqualToString:strMainMenuText])
                        {
                            [self.mutableTextDictionary setObject:self.currentElementValue forKey:[self.marrLanguageSettings objectAtIndex:j]];
                            //NSLog(@"self.currentmenustring = %@",self.strCurrentMainMenuSettingString);
                            //NSLog(@"self.marrTextArray = %@",self.marrTextArray);
                            if(j==0)
                                [self.marrTextArray insertObject:[self.mutableTextDictionary mutableCopy] atIndex:i];
                            else{
                                [self.marrTextArray replaceObjectAtIndex:i withObject:[self.mutableTextDictionary mutableCopy]];
                            }
                            
                        }
                        
                    }
                }
                else{
                    NSString *strMainMenuText = [NSString stringWithFormat:@"main_menu%d_English",i];
                    if ([self.strCurrentMainMenuSettingString isEqualToString:strMainMenuText]) {
                        [self.mutableTextDictionary setObject:self.currentElementValue forKey:@"English"];
                        //NSLog(@"self.currentmenustring = %@",self.strCurrentMainMenuSettingString);
                        //NSLog(@"self.marrTextArray = %@",self.marrTextArray);
                        //                        if(j==0)
                        [self.marrTextArray insertObject:[self.mutableTextDictionary mutableCopy] atIndex:i];
                        //                        else{
                        //                            [self.marrTextArray replaceObjectAtIndex:i withObject:[self.mutableTextDictionary mutableCopy]];
                        //                        }
                        
                    }
                }
            }
        }
        else if([[self.mainMenuSettingsDict objectForKey:@"sub_menu_enable"]isEqualToString:@"Yes"]){
            for (int i=0; i<[self.mainMenuArray count]; i++) {
                if ([self.subMenuArray count]>0) {
                    //NSLog(@"Sub menu = %@",self.subMenuArray);
                    
                    for(int k=0; k<[[self.subMenuArray objectAtIndex:i] count]; k++){
                        for (int j=0; j<[self.marrLanguageSettings count]; j++) {
                            NSString *strMainMenuText = [NSString stringWithFormat:@"menu%d_submenu%d_%@",i,k,[self.marrLanguageSettings objectAtIndex:j]];
                            if ([self.strCurrentMainMenuSettingString isEqualToString:strMainMenuText]) {
                                [self.mutableTextDictionary setObject:self.currentElementValue forKey:[self.marrLanguageSettings objectAtIndex:j]];
                                //NSLog(@"self.currentmenustring = %@",self.strCurrentMainMenuSettingString);
                                //NSLog(@"self.marrTextArray = %@",self.marrTextArray);
                                if(j==0){
                                    
                                    [self.marrTextArray insertObject:[self.mutableTextDictionary mutableCopy] atIndex:k];
                                }
                                else{
                                    [self.marrTextArray replaceObjectAtIndex:k withObject:[self.mutableTextDictionary mutableCopy]];
                                }
                                if (k==0&&j==0) {
                                    [self.marrTextSubmenuArray insertObject:[self.marrTextArray mutableCopy] atIndex:i];
                                }
                                else{
                                    [self.marrTextSubmenuArray replaceObjectAtIndex:i withObject:[self.marrTextArray mutableCopy]];
                                }
                                
                                //NSLog(@"submenu text array = %@",self.marrTextSubmenuArray);
                                if ([self.marrTextArray count]==[[self.subMenuArray objectAtIndex:i] count] && [[self.mutableTextDictionary allKeys] count]==[self.marrLanguageSettings count]) {
                                    [self.marrTextArray removeAllObjects];
                                }
                                if ([[self.mutableTextDictionary allKeys] count]==[self.marrLanguageSettings count]) {
                                    self.mutableTextDictionary = NULL;
                                    self.mutableTextDictionary = [[NSMutableDictionary alloc]init];
                                }
                            }
                            
                        }
                        
                    }
                    
                }
            }
            
        }
    }
    
    
    if([elementName isEqualToString:@"resources"])
    {
        return;
    }
    
    if ([elementName isEqualToString:@"string-array"])
    {
        if ([self.strMainMenuArrayString  isEqualToString:@"mainmenu_array"])
        {
            self.boolMenuArrayTag = NO;
        }
        else if([self.strMainMenuArrayString isEqualToString:@"submenu_array"]){
            self.boolMenuArrayTag = NO;
            [self.subMenuArray addObject:[self.marrLocalSubMenuArray mutableCopy]];
            [self.marrLocalSubMenuArray removeAllObjects];
        }
        /*else if([self.strMainMenuArrayString isEqualToString:@"submenu_text_enable_array"]){
         self.boolMenuArrayTag = NO;
         [self.marrSubMenuTextEnable addObject:[self.marrSubMenuTextEnableLocal mutableCopy]];
         [self.marrSubMenuTextEnableLocal removeAllObjects];
         }*/
        
        /*else if([self.strMainMenuArrayString isEqualToString:@"text_enable"])
         {
         self.boolMenuArrayTag = NO;
         }*/
        
        else if([self.strMainMenuArrayString isEqualToString:@"Setting_items"])
        {
            self.boolMenuArrayTag = NO;
        }
        else if([self.strMainMenuArrayString isEqualToString:@"Audio_Setting_Items"])
        {
            self.boolMenuArrayTag = NO;
        }
        else if([self.strMainMenuArrayString isEqualToString:@"Language_Setting_Items"])
        {
            self.boolMenuArrayTag = NO;
        }
        else if([self.strMainMenuArrayString isEqualToString:@"Narration_Setting_Items"])
        {
            self.boolMenuArrayTag = NO;
        }
    }
    
    if ([elementName isEqualToString:@"item"])
    {
        if ([self.strMainMenuArrayString  isEqualToString:@"mainmenu_array"])
        {
            [self.mainMenuArray addObject:self.currentElementValue];
        }
        /*else if([self.strMainMenuArrayString isEqualToString:@"text_enable"])
         {
         [self.marrMainMenuTextEnable addObject:self.currentElementValue];
         }*/
        else if([self.strMainMenuArrayString isEqualToString:@"submenu_array"])
        {
            [self.marrLocalSubMenuArray addObject:self.currentElementValue];
        }
        /*else if([self.strMainMenuArrayString isEqualToString:@"submenu_text_enable_array"])
         {
         [self.marrSubMenuTextEnableLocal addObject:self.currentElementValue];
         }*/
        else if([self.strMainMenuArrayString isEqualToString:@"Setting_items"])
        {
            //NSLog(@"CURRENT ELEMENT VALUE %@", self.currentElementValue);
            [self.marrSettings addObject:self.currentElementValue];
        }
        else if([self.strMainMenuArrayString isEqualToString:@"Audio_Setting_Items"])
        {
            [self.marrAudioSettings addObject:self.currentElementValue];
        }
        else if([self.strMainMenuArrayString isEqualToString:@"Language_Setting_Items"])
        {
            [self.marrLanguageSettings addObject:self.currentElementValue];
        }
        else if([self.strMainMenuArrayString isEqualToString:@"Narration_Setting_Items"])
        {
            [self.marrNarrationSettings addObject:self.currentElementValue];
        }
        self.boolMenuArrayTag = NO;
    }
    
    if ([elementName isEqualToString:@"string"])
    {
        self.boolStringTag = NO;
    }
    
    
    
    self.currentElementValue = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
													message:[parseError localizedDescription]
												   delegate:nil
										  cancelButtonTitle:@"Ok"
										  otherButtonTitles:nil];
	[alert show];
	
	
	
}


@end
