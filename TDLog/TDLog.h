//
//  TDLog.h
//  TDLog
//
//  Created by Thuỷ Đào on 19/02/2014.
//  Copyright (c) 2014 Thuỷ Đào. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TDLog/TDEngineLog.h>
#import <TDLog/TDLogManagement.h>


//--------------------------------------------------------
//  TUTORIAL
//--------------------------------------------------------
//STEP1: You need add email of feeback on 'TD_EmailDevelopment' field in split file!!! ***";
//STEP2: Insert '[TDEngineLog td_sharedManager];' into 'application:didFinishLaunchingWithOptions:'. The app will auto detect crash. So, enduser can choose the option to send crash log to mail did configure in above
//STEP3: use  [[TDLogManagement td_sharedInstance] td_show]; to  show float icon that enduser can tap to send log or debug to email of developer
//STEP4: Use TDLog same as NSLOG
//STEP 5: set color for debug popupview

/*
 Ex:
 
 [[TDLogManagement td_sharedInstance].td_LogFilter setValue:@"tex1" forKey:L_Yellow];
 [[TDLogManagement td_sharedInstance].td_LogFilter setValue:@"text2" forKey:L_Red];
 
 */
