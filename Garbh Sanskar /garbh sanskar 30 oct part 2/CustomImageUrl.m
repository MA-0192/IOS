




#import "CustomImageUrl.h"


@implementation CustomImageUrl
@synthesize parent,current;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    startupActivityIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-7 , self.frame.size.height/2-7, 15, 15)];
	//startupActivityIndicator.hidden = YES;
	[self addSubview:startupActivityIndicator];
	startupActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	startupActivityIndicator.backgroundColor=[UIColor clearColor];
	
	appDel = (iChantAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    return self;
}

- (void)loadImageFromURL:(NSURL*)url ForIndex:(int)index
{
	indexInt = index;
	[startupActivityIndicator startAnimating];
	
    
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval:60.0];
    connection = [[NSURLConnection alloc]
				  initWithRequest:request delegate:self];
    //TODO error handling, what if connection is nil?
}
- (void)connection:(NSURLConnection *)theConnection
	didReceiveData:(NSData *)incrementalData
{
    if (data==nil)
    {
     data =[[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}


- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {	
    connection=nil;	
    if ([[self subviews] count]>0)
	{
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
	
	if(data)
		[appDel.thumbImageArr replaceObjectAtIndex:indexInt withObject:data];
	
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
	//UIImageView* imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stores.png"]] autorelease];
    
	
    //imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
	[imageView setBackgroundColor:[UIColor clearColor]];
//    imageView.layer.masksToBounds = YES;
//    imageView.layer.borderColor = [UIColor blackColor].CGColor;
//    imageView.layer.borderWidth = 3;
    [self addSubview:imageView];
    
    imageView.frame = self.bounds;
    [imageView setNeedsLayout];
    [self setNeedsLayout];
    data=nil;
	
	[startupActivityIndicator stopAnimating];
}
- (UIImage*) image 
{
    UIImageView* iv = [[self subviews] objectAtIndex:0];
    return [iv image];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
