//
//  POPUPViewController.m
//  Fanest
//
//  Created by Amit on 9/21/12.
//
//

#import "POPUPViewController.h"
#import "ShowAlert.h"
@interface POPUPViewController ()

@end

@implementation POPUPViewController
@synthesize FrontImageView;

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
}

- (void)viewDidUnload
{
    [self setFrontImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)CloseAction:(id)sender {
    self.view.frame=[[UIScreen mainScreen]applicationFrame];
    self.view.transform=CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:1 animations:^{
        self.view.transform=CGAffineTransformMakeScale(1,1);
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
}
- (void)dealloc {
    [FrontImageView release];
    [super dealloc];
}

- (IBAction)saveButtonAction:(id)sender {
    UIImageWriteToSavedPhotosAlbum(FrontImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(NSDictionary *)contextInfo
{
    
    if (error != NULL)
    {
        [ShowAlert showMyAlert:@"Error" :[NSString stringWithFormat:@"Please enable access to Photos album from Settings-->Privacy-->Photos-->%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]]];
    }
    else
    {
        [ShowAlert showMyAlert:nil :@"Image saved to photos Album"];
    }
}


- (IBAction)emailButtonAction:(id)sender {
    if([MFMailComposeViewController canSendMail])
    {
        NSData *imageAttachment = UIImageJPEGRepresentation(FrontImageView.image,1);

        MFMailComposeViewController * mailComposer=[[MFMailComposeViewController alloc]init];
        mailComposer.mailComposeDelegate=self;
        mailComposer.navigationBar.barStyle=UIBarStyleBlackOpaque;
        [mailComposer setSubject:[NSString stringWithFormat:@"E-Mail From %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]]];
        [mailComposer addAttachmentData:imageAttachment mimeType:@"image/jpeg" fileName:@"imageAttachment.jpg"];
        
        [mailComposer setMessageBody:[NSString stringWithFormat:@"Thanks for using \"%@\" app.",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]]  isHTML:YES];
        [self presentModalViewController:mailComposer animated:YES];

        [mailComposer release];
        
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"E-Mail" message:@"You need an email account setup on the device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];[alert release];
    }  
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}

@end
