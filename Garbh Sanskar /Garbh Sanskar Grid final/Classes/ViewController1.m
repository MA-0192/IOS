//
//  ViewController1.m
//  iChant
//
//  Created by User on 2/8/13.
//
//

#import "ViewController1.h"
#import "GlobalValues.h"
#import "RootViewController.h"
#import <Twitter/Twitter.h>

@interface ViewController1 ()
@end
@implementation ViewController1
@synthesize fbObject;
@synthesize tableViewViewController1 = _tableViewViewController1;
@synthesize flipButton = _flipButton;
@synthesize instructionsView = _instructionsView;
@synthesize mainImage = _mainImage;
@synthesize txtViewInfoText = _txtViewInfoText;
@synthesize btnOtherApps = _btnOtherApps;
@synthesize btnWebsite = _btnWebsite;
@synthesize btnFeedback = _btnFeedback;
@synthesize footerView = _footerView;
@synthesize lblCopyRight = _lblCopyRight;
@synthesize lblAudioCopyRight = _lblAudioCopyRight;
@synthesize btnFooterIcon1 = _btnFooterIcon1;
@synthesize btnFooterIcon2 = _btnFooterIcon2;
@synthesize btnFooterIcon3 = _btnFooterIcon3;
@synthesize btnFooterIcon4 = _btnFooterIcon4;
@synthesize btnFooterIcon5 = _btnFooterIcon5;
@synthesize activityIndicator = _activityIndicator;

//iPod
@synthesize imgViewBG = _imgViewBG;
@synthesize imgViewAppIcons = _imgViewAppIcons;

@synthesize imgViewPoojaPresents = _imgViewPoojaPresents;
@synthesize imgViewAppIcon = _imgViewAppIcon;
@synthesize imgViewFountainIcon = _imgViewFountainIcon;


GlobalValues *globalValues;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"ok" forKey:@"shake"];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"shake"]) {
        UIAlertView *shakealert=[[UIAlertView alloc]initWithTitle:nil message:@"Do you want to enable shake feature" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [shakealert show];
    }
    
    UISwipeGestureRecognizer *showExtrasSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipe:)];
    showExtrasSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.tableViewViewController1 addGestureRecognizer:showExtrasSwipe];
    
     fbObject=[Facebook alloc];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    globalValues = [GlobalValues sharedManager];
    
    self.title = globalValues.strAppName;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Helvetica" size:22.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor =[UIColor whiteColor];
    label.text=self.title;
    self.navigationItem.titleView = label;
    
    //self.txtViewInfoText.text = globalValues.strInfoText;
    self.txtViewInfoText.textAlignment = NSTextAlignmentJustified;
    self.lblCopyRight.text = globalValues.strCopyRightText;
    self.lblAudioCopyRight.text = globalValues.strAudioCopyRightText;
    
    //NSLog(@"BOOL VARIABLE FOR INFO %d",globalValues.boolForInfoViewController1);
    
    if(globalValues.boolForInfoViewController1)
    {
        // add our custom flip button as the nav bar's custom right view
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [infoButton addTarget:self action:@selector(flipAction:) forControlEvents:UIControlEventTouchUpInside];
        self.flipButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        self.navigationItem.rightBarButtonItem = self.flipButton;
    }
    
    //NSLog(@"BOOL VARIABLE FOR TELL A FRND %d",globalValues.boolForTellFriendViewController1);
    
    if(globalValues.boolForTellFriendViewController1)
    {
        UIImage* imgTellFriend = [UIImage imageNamed:@"tell_a_friend.png"];
        CGRect frameimg = CGRectMake(0, 0, imgTellFriend.size.width, imgTellFriend.size.height);
        UIButton *btnTellFriend = [[UIButton alloc] initWithFrame:frameimg];
        [btnTellFriend setBackgroundImage:imgTellFriend forState:UIControlStateNormal];
        [btnTellFriend addTarget:self action:@selector(tellFriendClicked)
                forControlEvents:UIControlEventTouchUpInside];
        [btnTellFriend setShowsTouchWhenHighlighted:YES];
        
        UIBarButtonItem *barButtonTellFriend =[[UIBarButtonItem alloc] initWithCustomView:btnTellFriend];
        self.navigationItem.leftBarButtonItem = barButtonTellFriend;
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
 
    if([[UIScreen mainScreen] bounds].size.height == 568)
    {
        self.view.frame=CGRectMake(0, 0, 320, 568);
        self.MyScrollView.frame=CGRectMake(0, 60, 320, 440);
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 480)
    {
        self.view.frame=CGRectMake(0, 0, 320, 480);
        self.MyScrollView.frame=CGRectMake(0, 60, 320, 343);
    }
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        
        self.MyScrollView.contentSize = CGSizeMake(287, 90*[globalValues.marrForViewController1 count]);
        int xCor = 25, yCor= 14 ;
        for (int i = 0; i<globalValues.marrForViewController1.count ; i++)
        {
            
            catButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            catButton.frame=CGRectMake(xCor, yCor, 100, 100);
            [catButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"main_menu_icon%d",i] ofType:@"png"]] forState:UIControlStateNormal];
            
            //    [catButton setBackgroundImage:[UIImage imageNamed:[poojasections.sectionImages objectAtIndex:i] ]forState:UIControlStateNormal];
            [catButton addTarget:self action:@selector(CatAction:) forControlEvents:UIControlEventTouchUpInside];
            catButton.backgroundColor=[UIColor clearColor];
            [ self.MyScrollView addSubview:catButton];
            catButton.tag=i;
            
            UILabel *titleLbl=[[UILabel alloc]init];
            titleLbl.frame=CGRectMake(xCor-10, yCor+100, 120, 40);
            //  titleLbl.font=[UIFont systemFontOfSize:18];
            titleLbl.backgroundColor=[UIColor clearColor];
            titleLbl.numberOfLines=2;
            titleLbl.textAlignment=NSTextAlignmentCenter;
            titleLbl.font=[UIFont fontWithName:@"Arial-BoldMT" size:14.0];
            titleLbl.text= [globalValues.marrForViewController1 objectAtIndex:i];
            titleLbl.textColor=[UIColor blackColor];
            [self.MyScrollView addSubview:titleLbl];
            xCor=xCor+170;
            int j=i+1;
            
            if (j%2==0)
            {
                xCor = 25;
                yCor = yCor+150;
            }
        }
    }
    else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        //        bgimage.backgroundColor=[UIColor clearColor];
        
        NSLog(@"%@",globalValues.marrForViewController1);
        
        self.MyScrollView.contentSize = CGSizeMake(768, 80*[globalValues.marrForViewController1 count]);
        int xCor = 40, yCor= 70 ;
        for (int i = 0; i<globalValues.marrForViewController1.count ; i++)
        {
            
            catButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            catButton.frame=CGRectMake(xCor, yCor, 200, 200);
            [catButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"main_menu_icon%d",i] ofType:@"png"]] forState:UIControlStateNormal];
            [catButton addTarget:self action:@selector(CatAction:) forControlEvents:UIControlEventTouchUpInside];
            catButton.backgroundColor=[UIColor clearColor];
            [self.MyScrollView addSubview:catButton];
            catButton.tag=i;
            
            UILabel *titleLbl=[[UILabel alloc]init];
            titleLbl.frame=CGRectMake(xCor+7, yCor+200, 180, 60);
            titleLbl.font=[UIFont fontWithName:@"Arial-BoldMT" size:25];
            titleLbl.backgroundColor=[UIColor clearColor];
            titleLbl.textAlignment=NSTextAlignmentCenter;
            titleLbl.numberOfLines=2;
            titleLbl.text=[globalValues.marrForViewController1 objectAtIndex:i];
            titleLbl.textColor=[UIColor blackColor];
            titleLbl.tag=i;
            [  self.MyScrollView addSubview:titleLbl];
            xCor=xCor+240;
            int j=i+1;
            
            if (j%3==0)
            {
                xCor = 40;
                yCor = yCor+300;
            }
        }
    }
    

}
#pragma mark- scroll method
-(void)CatAction:(id)sender
{
    
    
    //	NSString *viewname = [poojasections.sections objectAtIndex:[sender tag]];
    
    globalValues.strMainMenuSelectedRow = [NSString stringWithFormat:@"%d",[sender tag]];
    
    if(globalValues.boolSubMenuEnable)
    {
        
    }
    else
    {
        [self.activityIndicator startAnimating];
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            RootViewController *objRootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
            
            
            NSLog(@"%@",[globalValues.marrForViewController1 objectAtIndex:[sender tag]]);
            
            objRootViewController.strNavigationTitle = [globalValues.marrForViewController1 objectAtIndex:[sender tag]];
            objRootViewController.selectedRow = [sender tag];
            
            [self.navigationController pushViewController:objRootViewController animated:YES];
        }
        else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            
            
                    NSLog(@"%@",[globalValues.marrForViewController1 objectAtIndex:[sender tag]]);
            
            RootViewController *objRootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController_iPad" bundle:nil];
            objRootViewController.strNavigationTitle = [globalValues.marrForViewController1 objectAtIndex:[sender tag]];
            objRootViewController.selectedRow = [sender tag];
            
            [self.navigationController pushViewController:objRootViewController animated:YES];
        }
        
        [self.activityIndicator startAnimating];
        
        [self.activityIndicator stopAnimating];
        
    }
    
    
    
}

-(void)cellSwipe:(UISwipeGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self.tableViewViewController1];
    NSIndexPath *swipedIndexPath = [self.tableViewViewController1 indexPathForRowAtPoint:location];
   
    
 //   NSLog(@"%@",swipedCell);
     NSLog(@"%d",swipedIndexPath.row);
    //Your own code...
    globalValues.strMainMenuSelectedRow = [NSString stringWithFormat:@"%d",swipedIndexPath.row];
    
    if(globalValues.boolSubMenuEnable)
    {
        
    }
    else
    {
        [self.activityIndicator startAnimating];
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            
        
            
            RootViewController *objRootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
            
            objRootViewController.strNavigationTitle = [globalValues.marrForViewController1 objectAtIndex:swipedIndexPath.row];
            objRootViewController.selectedRow =swipedIndexPath.row;
            ;
            NSLog(@"%@",globalValues.marrForViewController1 );
            [objRootViewController setFbObject:fbObject];
            [self.navigationController pushViewController:objRootViewController animated:YES];
        }
        else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            RootViewController *objRootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController_iPad" bundle:nil];
            objRootViewController.strNavigationTitle = [globalValues.marrForViewController1 objectAtIndex:swipedIndexPath.row];
            objRootViewController.selectedRow = swipedIndexPath.row;
            [objRootViewController setFbObject:fbObject];
            [self.navigationController pushViewController:objRootViewController animated:YES];
        }
        
        [self.activityIndicator startAnimating];
        
        [self.activityIndicator stopAnimating];
        
    }
    
 //   [self.tableViewViewController1 deselectRowAtIndexPath:indexPath animated:NO];

}
-(void)tellFriendClicked
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail])
        {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            
            [picker setSubject:globalValues.strTellFriendSubject];
            
            // Set up recipients
            NSArray *toRecipients = [NSArray arrayWithObject:@""];
            [picker setToRecipients:toRecipients];
            
            // Fill out the email body text
            NSString *emailBody = globalValues.strTellFriendText;
            [picker setMessageBody:emailBody isHTML:YES];
            
            [self presentModalViewController:picker animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Email" message:@"Please Login to Your Mail !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
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
                self.instructionsView.frame = CGRectMake(self.instructionsView.frame.origin.x, self.instructionsView.frame.origin.y, self.instructionsView.frame.size.width, 540);
                self.lblAudioCopyRight.frame = CGRectMake(self.lblAudioCopyRight.frame.origin.x, 470, self.lblAudioCopyRight.frame.size.width, self.lblAudioCopyRight.frame.size.height);
                self.lblCopyRight.frame = CGRectMake(39, 450, self.lblCopyRight.frame.size.width, self.lblCopyRight.frame.size.height);
                self.btnFacebook.frame = CGRectMake(self.btnFacebook.frame.origin.x, 410, self.btnFacebook.frame.size.width, self.btnFacebook.frame.size.height);
                self.btnTwitter.frame = CGRectMake(self.btnTwitter.frame.origin.x, 410, self.btnTwitter.frame.size.width, self.btnTwitter.frame.size.height);
                self.btnFeedback.frame = CGRectMake(self.btnFeedback.frame.origin.x, 410, self.btnFeedback.frame.size.width, self.btnFeedback.frame.size.height);
                self.txtViewInfoText.frame = CGRectMake(self.txtViewInfoText.frame.origin.x, self.txtViewInfoText.frame.origin.y, self.txtViewInfoText.frame.size.width, 300);
            }
        }
    }
	else
    {
        self.title = globalValues.strAppName;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica" size:22.0];
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
-(void)viewWillAppear:(BOOL)animated
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            self.imgViewBG.image = [UIImage imageNamed:@"Bg_iPhone.png"];
        }
        if(result.height == 568)
        {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,self.view.frame.size.width, 568);
            self.imgViewBG.frame = CGRectMake(self.imgViewBG.frame.origin.x, self.imgViewBG.frame.origin.y,self.imgViewBG.frame.size.width, 568);
            self.imgViewBG.image = [UIImage imageNamed:@"Bg_iPod.png"];
            
            self.tableViewViewController1.frame = CGRectMake(self.tableViewViewController1.frame.origin.x, self.tableViewViewController1.frame.origin.y,self.tableViewViewController1.frame.size.width, 520);
            
            self.imgViewAppIcons.frame = CGRectMake(self.imgViewAppIcons.frame.origin.x, 435, self.imgViewAppIcons.frame.size.width, self.imgViewAppIcons.frame.size.height);
            self.btnFooterIcon1.frame = CGRectMake(self.btnFooterIcon1.frame.origin.x, 439, self.btnFooterIcon1.frame.size.width, self.btnFooterIcon1.frame.size.height);
            self.btnFooterIcon2.frame = CGRectMake(self.btnFooterIcon2.frame.origin.x, 439, self.btnFooterIcon2.frame.size.width, self.btnFooterIcon2.frame.size.height);
            self.btnFooterIcon3.frame = CGRectMake(self.btnFooterIcon3.frame.origin.x, 439, self.btnFooterIcon3.frame.size.width, self.btnFooterIcon3.frame.size.height);
            self.btnOtherApps.frame = CGRectMake(self.btnOtherApps.frame.origin.x, 439, self.btnOtherApps.frame.size.width, self.btnOtherApps.frame.size.height);
            
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        
        
        return  150;
        
    }else
    {
        return 80;
    }

        
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
        return  80;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [globalValues.marrForViewController1 count];
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
    
 //   if ([[globalValues.marrForViewController1 objectAtIndex:indexPath.row] length] >18) {
        if([[UIDevice currentDevice] userInterfaceIdiom]== UIUserInterfaceIdiomPhone)
    {
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 2;
        //    }
        
    	cell.textLabel.text = [globalValues.marrForViewController1 objectAtIndex:indexPath.row];
     

        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
//      cell.textLabel.font = [UIFont boldSystemFontOfSize:30.0];
    }else
    {
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 2;
        //    }
        
    	cell.textLabel.text = [NSString stringWithFormat:@"                  %@",[globalValues.marrForViewController1 objectAtIndex:indexPath.row]];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:30];

    }
   

    if(globalValues.boolForCellImageIcons)
    {
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            NSString *strIconName = [NSString stringWithFormat:@"main_menu_icon%d",indexPath.row];
            NSString *path = [[NSBundle mainBundle] pathForResource:strIconName ofType:@"png"];
             if(path!=nil)
             {
                  UIImageView *tableimage=[[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:path]];
                 tableimage.frame=CGRectMake(15, 10, 125, 125);
                 [cell.contentView addSubview:tableimage];
             }
            //    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 200, 44)];
            //    label.backgroundColor = [UIColor clearColor];
            //    label.font = [UIFont fontWithName:@"Helvetica" size:15];
            //  //  label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
            //    label.textAlignment = UITextAlignmentLeft;
            //    label.textColor =[UIColor blackColor];
            //    label.text=[globalValues.marrForViewController1 objectAtIndex:indexPath.row];
            //    [cell.contentView addSubview:label];
            //    NSLog(@"%d",label.text.length);

            // cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }else
        {
        
        
        NSString *strIconName = [NSString stringWithFormat:@"main_menu_icon%d",indexPath.row];
        NSString *path = [[NSBundle mainBundle] pathForResource:strIconName ofType:@"png"];
        
        if(path!=nil)
            cell.imageView.image=[UIImage imageWithContentsOfFile:path];
        }
    }
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_mainmenu.png"]];
    
//    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_mainmenu_touch.png"]];

    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    globalValues.strMainMenuSelectedRow = [NSString stringWithFormat:@"%d",indexPath.row];
        
    if(globalValues.boolSubMenuEnable)
    {
        
    }
    else
    {
        [self.activityIndicator startAnimating];
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            RootViewController *objRootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
            
            objRootViewController.strNavigationTitle = [globalValues.marrForViewController1 objectAtIndex:indexPath.row];
            objRootViewController.selectedRow = indexPath.row;
            ;
            NSLog(@"%@",globalValues.marrForViewController1 );
            [objRootViewController setFbObject:fbObject];
            [self.navigationController pushViewController:objRootViewController animated:YES];
        }
        else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            RootViewController *objRootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController_iPad" bundle:nil];
            objRootViewController.strNavigationTitle = [globalValues.marrForViewController1 objectAtIndex:indexPath.row];
            objRootViewController.selectedRow = indexPath.row;
             [objRootViewController setFbObject:fbObject];
            [self.navigationController pushViewController:objRootViewController animated:YES];
        }
    
        [self.activityIndicator startAnimating];
        
        [self.activityIndicator stopAnimating];
        
    }

    [self.tableViewViewController1 deselectRowAtIndexPath:indexPath animated:NO];
		
}

#pragma mark - BUTTON EVENT HANDLERS
-(IBAction)btnOtherAppsClicked
{
    NSString *urlString = [NSString stringWithFormat:@"%@",globalValues.strOtherAppsLink];
    
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

-(IBAction)btnWebsiteClicked
{
	NSString *urlString = [NSString stringWithFormat:@"%@",globalValues.strWebsiteLink];
    
      NSLog(@"%@",urlString);
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
            
            [picker setSubject:@"Feedback! -  Garbh Sanskar "];
            
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
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Email" message:@"Please Login to Your Mail !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    
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

-(IBAction)btnFooterIcon1Pressed
{
    NSString *urlString = [NSString stringWithFormat:@"%@",globalValues.strFooterLink1];
    
      NSLog(@"%@",urlString);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

-(IBAction)btnFooterIcon2Pressed
{
    
    NSString *urlString = [NSString stringWithFormat:@"%@",globalValues.strFooterLink2];
    
      NSLog(@"%@",urlString);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

-(IBAction)btnFooterIcon3Pressed
{
    NSString *urlString = [NSString stringWithFormat:@"%@",globalValues.strFooterLink3];
    
     NSLog(@"%@",urlString);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

-(IBAction)btnFooterIcon4Pressed
{
    NSString *urlString = [NSString stringWithFormat:@"%@",globalValues.strFooterLink4];
    
    NSLog(@"%@",urlString);
    
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

-(IBAction)btnFooterIcon5Pressed
{
    
}

-(IBAction)btnFacebookClicked
{
    
    [self  loginBtnAction];
//    NSString *urlString = @"https://www.facebook.com/iPoojaMobileApps";
//	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

-(IBAction)btnTwitterClicked
{
  
    
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
   NSString *sStatusMessage =@"You can more downloads from- http://www.ipooja.com/  or https://twitter.com/iPooja";
    [twitter setInitialText:sStatusMessage];
    [twitter addImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
    [self presentModalViewController:twitter animated:YES];
//    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result){
//    };

    
//    NSString *urlString = @"https://twitter.com/iPooja";
//	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
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
    self.imgViewBG.frame = CGRectMake(self.imgViewBG.frame.origin.x, self.imgViewBG.frame.origin.y, 1024, 768);
    self.imgViewBG.image = [UIImage imageNamed:@"Bg_Landscape"];
    
    self.imgViewAppIcons.frame = CGRectMake(self.imgViewAppIcons.frame.origin.x, 640, 1025, 70);
    
    self.btnFooterIcon1.frame =  CGRectMake(self.btnFooterIcon1.frame.origin.x, 640, self.btnFooterIcon1.frame.size.width,self.btnFooterIcon1.frame.size.height);
    self.btnFooterIcon2.frame =  CGRectMake(250, 640, self.btnFooterIcon2.frame.size.width,self.btnFooterIcon2.frame.size.height);
    self.btnFooterIcon3.frame =  CGRectMake(500, 640, self.btnFooterIcon3.frame.size.width,self.btnFooterIcon3.frame.size.height);
    self.btnFooterIcon4.frame =  CGRectMake(740, 640, self.btnFooterIcon4.frame.size.width,self.btnFooterIcon4.frame.size.height);
    self.btnOtherApps.frame =  CGRectMake(950, 640, self.btnOtherApps.frame.size.width,self.btnOtherApps.frame.size.height);
    
    self.instructionsView.frame = CGRectMake(self.instructionsView.frame.origin.x, self.instructionsView.frame.origin.y, 1024, 800);
    self.imgViewPoojaPresents.frame = CGRectMake(self.imgViewPoojaPresents.frame.origin.x, self.imgViewPoojaPresents.frame.origin.y, 60, self.imgViewPoojaPresents.frame.size.height);
    self.imgViewAppIcon.frame = CGRectMake(500, self.imgViewAppIcon.frame.origin.y, self.imgViewAppIcon.frame.size.width, self.imgViewAppIcon.frame.size.height);
    self.txtViewInfoText.frame = CGRectMake(self.txtViewInfoText.frame.origin.x, self.txtViewInfoText.frame.origin.y, 950, 420);
    self.btnFacebook.frame = CGRectMake(self.btnFacebook.frame.origin.x, 607, self.btnFacebook.frame.size.width, self.btnFacebook.frame.size.height);
    self.btnTwitter.frame = CGRectMake(500, 607, self.btnTwitter.frame.size.width, self.btnTwitter.frame.size.height);
    self.btnFeedback.frame = CGRectMake(860, 607, self.btnFeedback.frame.size.width, self.btnFeedback.frame.size.height);
    self.lblCopyRight.frame = CGRectMake(460,660 , self.lblCopyRight.frame.size.width, self.lblCopyRight.frame.size.height);
    self.lblAudioCopyRight.frame = CGRectMake(420, 680, self.lblAudioCopyRight.frame.size.width, self.lblAudioCopyRight.frame.size.height);
    self.imgViewFountainIcon.frame = CGRectMake(860, self.imgViewFountainIcon.frame.origin.y, self.imgViewFountainIcon.frame.size.width, self.imgViewFountainIcon.frame.size.height);
    
    
   // self.view.frame=CGRectMake(0, 0, 768, 1024);
    self.MyScrollView.frame=CGRectMake(0, 0, 1024, 650);
    int xCor = 40, yCor= 70 ;
    for (UIView *view in self.MyScrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.frame=CGRectMake(xCor, yCor, 200, 200);
            xCor=xCor+370;
            int j=(int)view.tag+1;
            if (j%3==0)
            {
                xCor = 40;
                yCor = yCor+300;
            }
        }
    }
    xCor = 40, yCor= 70 ;
    for (UIView *view in self.MyScrollView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            view.frame=CGRectMake(xCor+7, yCor+200, 180, 60);
            xCor=xCor+370;
            int j=(int)view.tag+1;
            if (j%3==0)
            {
                xCor = 40;
                yCor = yCor+300;
            }
        }
        
    }

}

-(void)changeViewForPortraitMode
{   self.view.frame = CGRectMake(0, 0, 768, 1004);
    self.imgViewBG.frame = CGRectMake(self.imgViewBG.frame.origin.x, self.imgViewBG.frame.origin.y, 768, 1004);
    self.imgViewBG.image = [UIImage imageNamed:@"Bg_Portrait"];
    
    self.imgViewAppIcons.frame = CGRectMake(self.imgViewAppIcons.frame.origin.x, 890, 768, 70);
    
    self.btnFooterIcon1.frame =  CGRectMake(self.btnFooterIcon1.frame.origin.x, 891, self.btnFooterIcon1.frame.size.width,self.btnFooterIcon1.frame.size.height);
    self.btnFooterIcon2.frame =  CGRectMake(169, 891, self.btnFooterIcon2.frame.size.width,self.btnFooterIcon2.frame.size.height);
    self.btnFooterIcon3.frame =  CGRectMake(348, 891, self.btnFooterIcon3.frame.size.width,self.btnFooterIcon3.frame.size.height);
    self.btnFooterIcon4.frame =  CGRectMake(525, 891, self.btnFooterIcon4.frame.size.width,self.btnFooterIcon4.frame.size.height);
    self.btnOtherApps.frame = CGRectMake(691, 891, self.btnOtherApps.frame.size.width, self.btnOtherApps.frame.size.height);
    
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
    
    
    self.MyScrollView.frame=CGRectMake(0, 0, 768, 900);
      int xCor = 40, yCor= 70 ;
    for (UIView *view in self.MyScrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.frame=CGRectMake(xCor, yCor, 200, 200);
            xCor=xCor+240;
            int j=(int)view.tag+1;
            if (j%3==0)
            {
                xCor = 40;
                yCor = yCor+300;
            }
        }
    }
    xCor = 40, yCor= 70 ;
    for (UIView *view in self.MyScrollView.subviews) {
        
        
        if ([view isKindOfClass:[UILabel class]]) {
            //      NSLog(@" thisButton------>%ld", (int)view.tag);
            view.frame=CGRectMake(xCor, yCor+200, 180, 60);
            
            
            xCor=xCor+250;
            int j=(int)view.tag+1;
            
            if (j%3==0)
            {
                xCor = 40;
                yCor = yCor+300;
            }
            
        }
        
    }
    

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return YES;
    
    return 0;
}
#pragma mark- buttons method
-(void)loginBtnAction
{
//    Status=NO;
//    
//    objhud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    objhud.labelText=@"Loading....";
//    
    
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

@end
