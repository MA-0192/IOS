//
//  SettingsController.m
//  iChant
//
//  Created by User on 2/21/13.
//
//

#import "SettingsController.h"
#import "AudioSettingsViewController.h"

@interface SettingsController ()

@end

@implementation SettingsController

@synthesize tableViewSettings = _tableViewSettings;
@synthesize doneButton = _doneButton;
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
    self.title = @"Settings";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    globalValues = [GlobalValues sharedManager];
    
//    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
//    doneButton.frame = CGRectMake(260, 7, 50, 30);
//    [self.navigationController.navigationBar addSubview:doneButton];
//    [doneButton addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.doneButton.title = @"Done";
	self.doneButton.style = UIBarButtonSystemItemDone;
	self.navigationItem.rightBarButtonItem = self.doneButton;
}

/*-(void)doneButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}*/

-(IBAction)doneButtonPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [globalValues.marrAllSettings count];
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
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [globalValues.marrAllSettings objectAtIndex:indexPath.row];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_mainmenu_touch.png"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if((globalValues.boolAudioSettingEnable) && (indexPath.row == 0))
    {
        AudioSettingsViewController  *objAudioSettingsController = [[AudioSettingsViewController alloc]initWithNibName:@"AudioSettingsViewController" bundle:nil];
        
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:objAudioSettingsController];
        [self presentModalViewController:navigationController animated:YES];

    }
    [self.tableViewSettings deselectRowAtIndexPath:indexPath animated:NO];
      
    
}

@end
