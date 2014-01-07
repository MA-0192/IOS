//
//  wallpaperViewController.h
//  iChant
//
//  Created by Vivek Yadav on 10/1/13.
//
//

#import <UIKit/UIKit.h>
#import "POPUPViewController.h"
#import "MBProgressHUD.h"
@interface wallpaperViewController : UIViewController<NSXMLParserDelegate>
{
    MBProgressHUD *objHUd;
    
    NSURLConnection *connetion1;
  //  __weak IBOutlet UITableView *MyTableview;
   int startPoint;
    NSMutableData *webData;
    __weak IBOutlet UIScrollView *ScrollView;
    int k;
    UITapGestureRecognizer *tapGesture;
    POPUPViewController *objPOP;
}

@end
