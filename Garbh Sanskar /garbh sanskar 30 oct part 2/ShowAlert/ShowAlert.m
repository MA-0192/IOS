//
//  ShowAlert.m
//  NewsForDragonball
//
//  Created by Sachin Khard on 10/5/12.
//  Copyright (c) 2012 Sachin Khard. All rights reserved.
//

#import "ShowAlert.h"

@implementation ShowAlert

+(void)showMyAlert:(NSString *)title :(NSString *)message
{
    UIAlertView * loginAlert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [loginAlert show];
  
    loginAlert = nil;
}

@end
