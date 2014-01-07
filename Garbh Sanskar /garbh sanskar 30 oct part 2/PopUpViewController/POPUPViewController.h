//
//  POPUPViewController.h
//  Fanest
//
//  Created by Amit on 9/21/12.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface POPUPViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *FrontImageView;

- (IBAction)saveButtonAction:(id)sender;
- (IBAction)emailButtonAction:(id)sender;
- (IBAction)CloseAction:(id)sender;

@end
