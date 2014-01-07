//
//  SettingsController.m
//  iChant
//
//  Created by User on 2/21/13.
//
//

#import "AudioSettingsViewController.h"
#import "GlobalValues.h"
#import "Constants.h"

@interface AudioSettingsViewController ()

@end


@implementation AudioSettingsViewController

@synthesize tableViewAudioSettings = _tableViewAudioSettings;
@synthesize selectedRow = _selectedRow;
@synthesize languageArray = _languageArray;
@synthesize numberPicker = _numberPicker;
@synthesize pickerData = _pickerData;
@synthesize selectedAudioSettingArray = _selectedAudioSettingArray;
@synthesize audioSettingsType = _audioSettingsType;
@synthesize numberOfTimesArray = _numberOfTimesArray;
@synthesize noOfTimes = _noOfTimes;
@synthesize selectedAudioSetting = _selectedAudioSetting;
@synthesize timeDurationPicker = _timeDurationPicker;
@synthesize numberOfSecondArray = _numberOfSecondArray;
@synthesize noOfSecs = _noOfSecs;
@synthesize userDefaults = _userDefaults;
@synthesize doneButton = _doneButton;
@synthesize imgViewBG = _imgViewBG;

@synthesize delegate = _delegate;

GlobalValues *globalValues;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout=UIRectEdgeNone;
    globalValues = [GlobalValues sharedManager];
    
    self.title = [globalValues.marrAllSettings objectAtIndex:0];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    self.languageArray = [[[NSUserDefaults standardUserDefaults] objectForKey:globalValues.kRestoreLanguage1] mutableCopy];
    
	if (self.languageArray == nil){
        self.languageArray = [[NSMutableArray alloc]init];
        for (int i=0; i<[globalValues.marrAudioSettings count]; i++) {
            [self.languageArray addObject:@"0"];
        }
    }
	//saving language index form user defaults
	self.selectedRow = [[self.languageArray objectAtIndex:0] intValue];

//    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
//    doneButton.frame = CGRectMake(260, 7, 50, 30);
//    [self.navigationController.navigationBar addSubview:doneButton];
//    [doneButton addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.doneButton.title = @"Done";
	self.doneButton.style = UIBarButtonSystemItemDone;
	self.navigationItem.rightBarButtonItem = self.doneButton;
    
    // for  number picker data.
	NSMutableArray *data = [[NSMutableArray alloc]init];
	for (int i=0; i<=1000; i++)
	{
		NSString *str = [[NSNumber numberWithInt:i+1] stringValue];
		[data insertObject:str atIndex:i];
		self.pickerData = data;
	}
	
    self.selectedAudioSettingArray=[[[NSUserDefaults standardUserDefaults] objectForKey:kSelectedAudioSetting] mutableCopy];
	self.numberOfTimesArray=[[[NSUserDefaults standardUserDefaults]objectForKey:kNumberOfTimesArray] mutableCopy];
    self.numberOfSecondArray=[[[NSUserDefaults standardUserDefaults] objectForKey:kNumberOfSecondsArray] mutableCopy];
    
    self.audioSettingsType = globalValues.marrAudioSettings;
    NSLog(@"selectedAudioSetting Array = %@",self.selectedAudioSettingArray);
	self.selectedAudioSetting=[[self.selectedAudioSettingArray objectAtIndex:self.selectedRow] intValue];
	self.noOfTimes = [[self.numberOfTimesArray objectAtIndex:self.selectedRow] intValue];
    self.noOfSecs = [[self.numberOfSecondArray objectAtIndex:self.selectedRow] intValue];
    

    if([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSetting] isEqualToString:@"Continuous"])
    {
        self.numberPicker.hidden = YES;
		self.timeDurationPicker.hidden = YES;
    }
    if([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSetting] isEqualToString:@"Play all"])
    {
        self.numberPicker.hidden = YES;
		self.timeDurationPicker.hidden = YES;
    }
    else if([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSetting] isEqualToString:@"Number Of Times"])
    {
        self.numberPicker.hidden = NO;
		[self.numberPicker selectRow:self.noOfTimes-1 inComponent:0 animated:YES];
		self.timeDurationPicker.hidden = YES;
    }
    else if([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSetting] isEqualToString:@"Duration"])
    {
        self.numberPicker.hidden = YES;
		self.timeDurationPicker.hidden = NO;
		self.timeDurationPicker.countDownDuration = self.noOfSecs;
    }

}

-(IBAction)doneButtonPressed:(id)sender
{
    [self.userDefaults setObject:self.selectedAudioSettingArray forKey:kSelectedAudioSetting];
    [self.userDefaults setObject:self.numberOfTimesArray forKey:kNumberOfTimesArray];
    [self.userDefaults setObject:self.numberOfSecondArray forKey:kNumberOfSecondsArray];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [self.selectedAudioSettingArray replaceObjectAtIndex:self.selectedRow withObject:[NSString stringWithFormat:@"%d",self.selectedAudioSetting]];
        [self.numberOfTimesArray replaceObjectAtIndex:self.selectedRow withObject:[NSString stringWithFormat:@"%d",self.noOfTimes]];
        NSLog(@"NO. OF Times%d",self.noOfTimes);
        [self.numberOfSecondArray replaceObjectAtIndex:self.selectedRow withObject:[NSString stringWithFormat:@"%d",self.noOfSecs]];
        [[NSUserDefaults standardUserDefaults] setObject:self.selectedAudioSettingArray forKey:kSelectedAudioSetting];
        [[NSUserDefaults standardUserDefaults] setObject:self.numberOfTimesArray forKey:kNumberOfTimesArray];
        [[NSUserDefaults standardUserDefaults] setObject:self.numberOfSecondArray forKey:kNumberOfSecondsArray];
        
        [_delegate reflectSettingsChanges];
        
    }
    else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self dismissModalViewControllerAnimated:YES];
    
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.imgViewBG.image = [UIImage imageNamed:@"Bg_iPhone.png"];
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
        self.imgViewBG.image = [UIImage imageNamed:@"Bg_iPhone.png"];
    }
    if(result.height == 568)
    {
        self.imgViewBG.frame = CGRectMake(self.imgViewBG.frame.origin.x, self.imgViewBG.frame.origin.y, self.imgViewBG.frame.size.width, 568);
        self.imgViewBG.image = [UIImage imageNamed:@"Bg_iPod.png"];
        
        self.numberPicker.frame = CGRectMake(self.numberPicker.frame.origin.x, 290, self.numberPicker.frame.size.width, self.numberPicker.frame.size.height);
        self.timeDurationPicker.frame = CGRectMake(self.timeDurationPicker.frame.origin.x, 290, self.timeDurationPicker.frame.size.width, self.timeDurationPicker.frame.size.height);

    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) timeDurationPickerValueChanged
{
	self.noOfSecs = self.timeDurationPicker.countDownDuration;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.selectedAudioSettingArray replaceObjectAtIndex:self.selectedRow withObject:[NSString stringWithFormat:@"%d",self.selectedAudioSetting]];
    [self.numberOfTimesArray replaceObjectAtIndex:self.selectedRow withObject:[NSString stringWithFormat:@"%d",self.noOfTimes]];
    NSLog(@"NO. OF Times%d",self.noOfTimes);
    [self.numberOfSecondArray replaceObjectAtIndex:self.selectedRow withObject:[NSString stringWithFormat:@"%d",self.noOfSecs]];
    [[NSUserDefaults standardUserDefaults] setObject:self.selectedAudioSettingArray forKey:kSelectedAudioSetting];
    [[NSUserDefaults standardUserDefaults] setObject:self.numberOfTimesArray forKey:kNumberOfTimesArray];
    [[NSUserDefaults standardUserDefaults] setObject:self.numberOfSecondArray forKey:kNumberOfSecondsArray];	
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
	viewFooter.backgroundColor = [UIColor clearColor];
	return viewFooter;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [globalValues.marrAudioSettings count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier: CellIdentifier];
    }
    
	cell.textLabel.text = [globalValues.marrAudioSettings objectAtIndex:indexPath.row];
    if(indexPath.row == self.selectedAudioSetting)
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType=UITableViewCellAccessoryNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.selectedAudioSetting = indexPath.row;
	
    if([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSetting] isEqualToString:@"Continuous"])
    {
        self.numberPicker.hidden = YES;
		self.timeDurationPicker.hidden = YES;
    }
    else if([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSetting] isEqualToString:@"Number Of Times"])
    {
        self.numberPicker.hidden = NO;
		[self.numberPicker selectRow:self.noOfTimes-1 inComponent:0 animated:YES];
		self.timeDurationPicker.hidden = YES;
       
    }
    else if([[globalValues.marrAudioSettings objectAtIndex:self.selectedAudioSetting] isEqualToString:@"Duration"])
    {
        self.numberPicker.hidden = YES;
		self.timeDurationPicker.hidden = NO;
		self.timeDurationPicker.countDownDuration = self.noOfSecs;
    }
   	[tableView reloadData];
    [self.tableViewAudioSettings deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark Picker Data Source Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.pickerData count];
}
#pragma mark Picker delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [self.pickerData objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
	self.noOfTimes=[[self.pickerData objectAtIndex:row] intValue];
	
}
@end
