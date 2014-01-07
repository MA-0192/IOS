//
//  ViewController1.h
//  iChant
//
//  Created by User on 2/8/13.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "FBConnect.h"
@interface ViewController1 : UIViewController <MFMailComposeViewControllerDelegate,FBSessionDelegate,FBRequestDelegate,FBDialogDelegate>
{
     UIButton* catButton;
}

@property (nonatomic, retain) Facebook *fbObject;
@property (strong, nonatomic) IBOutlet UITableView *tableViewViewController1;
@property (strong, nonatomic) UIBarButtonItem *flipButton;
@property (strong, nonatomic) IBOutlet UIView *instructionsView;
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UITextView *txtViewInfoText;
@property (strong, nonatomic) IBOutlet UIButton *btnOtherApps;
@property (strong, nonatomic) IBOutlet UIButton *btnWebsite;
@property (strong, nonatomic) IBOutlet UIButton *btnFeedback;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UILabel *lblCopyRight;
@property (strong, nonatomic) IBOutlet UIButton *btnFooterIcon1;
@property (strong, nonatomic) IBOutlet UIButton *btnFooterIcon2;
@property (strong, nonatomic) IBOutlet UIButton *btnFooterIcon3;
@property (strong, nonatomic) IBOutlet UIButton *btnFooterIcon4;
@property (strong, nonatomic) IBOutlet UIButton *btnFooterIcon5;
@property (strong, nonatomic) IBOutlet UILabel *lblAudioCopyRight;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

//iPod
@property (strong, nonatomic) IBOutlet UIImageView *imgViewBG;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewAppIcons;
@property (strong, nonatomic) IBOutlet UIButton *btnFacebook;
@property (strong, nonatomic) IBOutlet UIButton *btnTwitter;

@property (strong, nonatomic) IBOutlet UIImageView *imgViewPoojaPresents;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewAppIcon;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewFountainIcon;

@property (weak, nonatomic) IBOutlet UIScrollView *MyScrollView;

- (void)flipAction:(id)sender;
-(IBAction)btnOtherAppsClicked;
-(IBAction)btnFooterIcon1Pressed;
-(IBAction)btnFooterIcon2Pressed;
-(IBAction)btnFooterIcon3Pressed;
-(IBAction)btnFooterIcon4Pressed;
-(IBAction)btnFooterIcon5Pressed;

-(void)changeViewForPortraitMode;
-(void)changeViewForLandscapeMode;

-(IBAction)btnFacebookClicked;
-(IBAction)btnTwitterClicked;
-(IBAction)btnFeedbackClicked;



@end
