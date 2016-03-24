//
//  TDViewController.m
//  TDLog
//
//  Created by Mr Sa on 03/24/2016.
//  Copyright (c) 2016 Mr Sa. All rights reserved.
//

#import "TDViewController.h"
#import <TDLog/TDLog.h>


@interface TDViewController ()

@end

@implementation TDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
  TDLOG(@"abcdef");
  
  [[TDLogManagement td_sharedInstance] td_show];
}

@end
