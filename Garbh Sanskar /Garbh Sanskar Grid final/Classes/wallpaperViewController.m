//
//  wallpaperViewController.m
//  iChant
//
//  Created by Vivek Yadav on 10/1/13.
//
//
#import "CustomImageUrl.h"
#import "wallpaperViewController.h"
#import "ShowAlert.h"
#define skHomeUrl @"http://ajax.googleapis.com/ajax/services/search/"
#define skSearchkeyword @"god Ganesh"
@interface wallpaperViewController ()

@end

@implementation wallpaperViewController

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

    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg_iPhone.png"]];
        
         }
    if(result.height == 568)
    {
         self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg_iPod.png"]];
      
    }
    
    
    UISwipeGestureRecognizer *recognizerRITE = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRITE)];
    [recognizerRITE setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:recognizerRITE];
    
      startPoint= 0;
    [self getDataWebService];
}
-(void)handleSwipeRITE
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- web service
-(void)getDataWebService
{
    
    //   self.navigationController.view.userInteractionEnabled=NO;
    objHUd=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    objHUd.labelText=@"Loading photos..";
    
 
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@?v=1.0&q=%@&rsz=8&start=%d",skHomeUrl,@"images",skSearchkeyword,startPoint] stringByReplacingOccurrencesOfString:@" " withString:@"%20"]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0];
    
    
	connetion1=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	webData = [NSMutableData data] ;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	
    NSString *rtString=[[NSString alloc]initWithData:webData encoding:NSUTF8StringEncoding];
  //  NSLog(@"%@",rtString);
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:webData
                     options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableDictionary *deserializedDictionary = nil;
    
    if (jsonObject != nil && error == nil)
    {
        if ([jsonObject isKindOfClass:[NSMutableDictionary class]])
        {
            //Convert the NSData to NSDictionary in this final step
            deserializedDictionary = (NSMutableDictionary *)jsonObject;
               NSLog(@"%@",deserializedDictionary );
            
            NSLog(@"%@",[[[[deserializedDictionary objectForKey:@"responseData"] objectForKey:@"results"] objectAtIndex:0] objectForKey:@"url"]);
            
            
             ScrollView.contentSize = CGSizeMake(287, 40*[[[deserializedDictionary objectForKey:@"responseData"] objectForKey:@"results"] count]);
            int xCor = 10, yCor= 14 ;
            for (int i = 0; i<[[[deserializedDictionary objectForKey:@"responseData"] objectForKey:@"results"] count] ; i++)
            {
                CustomImageUrl *imageurl=[[CustomImageUrl alloc]initWithFrame:CGRectMake(xCor, yCor, 82, 85)];
                [imageurl loadImageFromURL:[NSURL URLWithString:[[[[deserializedDictionary objectForKey:@"responseData"] objectForKey:@"results"] objectAtIndex:i] objectForKey:@"url"]] ForIndex:i];
                imageurl.tag=i;
                k=imageurl.tag;
                
                tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(IMgaeTouhced:)] ;
                [imageurl addGestureRecognizer:tapGesture];
                [imageurl setUserInteractionEnabled:YES];
                [ScrollView addSubview:imageurl];
//                
//                
//                UIImageView *imagebg1=[[UIImageView alloc]init ];
//             /
                
                xCor=xCor+95;
                int j=i+1;
                
                if (j%3==0)
                {
                    xCor = 10;
                    yCor = yCor+100;
                }
            }

            
        }
    }
    
    objHUd.hidden=YES;
}
-(void)IMgaeTouhced:(UITapGestureRecognizer *)sender
{
//    UIImageView *imgTOuched=(UIImageView *)sender.view;
//    k=imgTOuched.tag;
    UIImageView *imgTOuched=(UIImageView *)sender.view;
    if (objPOP)
    {
               objPOP = nil;
    }
    objPOP=[[POPUPViewController alloc]initWithNibName:@"POPUPViewController" bundle:[NSBundle mainBundle]];
    
    objPOP.view.backgroundColor=[UIColor clearColor];
    objPOP.view.frame=[[UIScreen mainScreen]applicationFrame];
    objPOP.view.transform=CGAffineTransformMakeScale(FLT_EPSILON, FLT_EPSILON);
    
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:1 animations:^{
        objPOP.FrontImageView.image=imgTOuched.image;
        objPOP.view.transform=CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished){
        self.view.userInteractionEnabled = YES;
        // objPOP.view.transform=CGAffineTransformMakeScale(1, 1);
    }];
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:objPOP.view];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
