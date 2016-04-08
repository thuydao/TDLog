//
//  TDEngineLog.m
//  TDEngineLog
//
//  Created by Dao Duy Thuy on 11/27/15.
//  Copyright © 2015 Moboco. All rights reserved.
//

#import "TDEngineLog.h"
#include <sys/sysctl.h>
#include <sys/utsname.h>

#define TD_EMAIL_DEVELOPMENT @"daoduythuy@gmail.com"
#define FILE_LENGTH 500000

#define TD_LOG_FILE_NAME @"log"

void uncaughtExceptionHandler(NSException *exception) {
        NSString *crashLog = [NSString stringWithFormat:@"%@ \nCRASH: %@ \nStack Trace: %@",[NSDate date], exception,[exception callStackSymbols]];
    // Internal error reporting
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"1" forKey:@"td_didCrashedBefore"];
    [ud setObject:crashLog forKey:@"td_crashLog"];
    [ud synchronize];
    
}


@interface TDEngineLog()

/**
 *  td_twoFingerTapGesture
 */
@property (nonatomic, retain) UITapGestureRecognizer *td_twoFingerTapGesture;

/**
 *  td_btnSendLog
 */
@property (nonatomic, retain) UIButton *td_btnSendLog;

@property (nonatomic, retain) UIViewController *td_viewController;

@end

@implementation TDEngineLog

#pragma mark - private method

+ (NSString *)td_getPlatform
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    @try {
        if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
        if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
        if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
        if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
        if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4 CDMA";
        if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
        if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
        if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
        if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
        if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
        if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
        if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
        if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
        if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
        if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
        if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
        if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
        if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
        if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
        if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
        if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
        if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
        if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (Cellular)";
        if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (Cellular)";
        if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
        if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
        if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (Cellular)";
        if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (Cellular)";
        if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
        if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (Cellular)";
        if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (Cellular)";
        if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
        if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (Cellular)";
        if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (Cellular)";
        if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
        if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
        if ([platform isEqualToString:@"i386"])         return @"Simulator";
        if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    }
    @catch (NSException *exception) {    
        NSLog(@"*** TDEngineLog: error when get device platform %@ ***", platform);
        return @"Unknown";
    }
    
    return @"Unknown";
}


+ (NSString *)td_getDeviceInfo
{
    NSMutableDictionary *res = [NSMutableDictionary new];
    [res setObject:[UIDevice currentDevice].model forKey:@"model"];
    [res setObject:[UIDevice currentDevice].description forKey:@"description"];
    [res setObject:[UIDevice currentDevice].localizedModel forKey:@"localizedModel"];
    [res setObject:[UIDevice currentDevice].name forKey:@"name"];
    [res setObject:[UIDevice currentDevice].systemVersion forKey:@"systemVersion"];
    [res setObject:[UIDevice currentDevice].systemName forKey:@"systemName"];
    [res setObject:[NSNumber numberWithFloat:[UIDevice currentDevice].batteryLevel] forKey:@"batteryLevel"];
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    [res setObject:[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding] forKey:@"systemInfo.machine"];
    [res setObject:[self td_getPlatform] forKey:@"platform"];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:res
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"*** TDEngineLog: error when get device info %@ ***", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
   
}

/**
 *  clearFile
 *
 *  @param fileName NSString
 */
+ (void)td_clearFile:(NSString *)fileName
{
    NSString *contents = @"";
    BOOL didWrite = [contents writeToFile:[self td_getPathLog]
                               atomically:YES
                                 encoding:NSUTF8StringEncoding
                                    error:nil];
    if (didWrite) {
        // NSLog(@"writed : %@",appFile);
    }
    else
    {
        //NSLog(@"cant write : %@",appFile);
    }
}


/**
 *  getPathLog
 *
 *  @return NSString
 */
+ (NSString *)td_getPathLog
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/EngineLog"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:TD_LOG_FILE_NAME];
    
    return appFile;
}

/**
 *  writeFile
 *
 *  @param content  NSString
 *  @param fileName NSString
 */
+ (void)td_writeFile:(NSString*)content fileName:(NSString *)fileName
{
    
    NSString *appFile = [self td_getPathLog];
    NSError *error = nil;
    NSString *contents = [NSString stringWithContentsOfFile:appFile encoding:NSUTF8StringEncoding error:&error];
    if (error || !contents) {
        contents = @"";
    }
    contents = [contents stringByAppendingString:[NSString stringWithFormat:@"\n\n %@",content]];
    
    if (contents.length > FILE_LENGTH) {
        contents = [contents substringToIndex:contents.length - FILE_LENGTH];
    }
    
    error = nil;
    BOOL didWrite = [contents writeToFile:appFile
                               atomically:YES
                                 encoding:NSUTF8StringEncoding
                                    error:&error];
    if (didWrite) {
//         NSLog(@"writed : %@",appFile);
    }
    else
    {
        NSLog(@"*** TDEngineLog: can't write : %@ \n error: %@***",appFile, error);
    }
}

+ (void)td_clearLog:(NSString *)fileName {
  NSString *appFile = [self td_getPathLog];
  NSError *error = nil;
  NSString *contents = @"";
  error = nil;
  BOOL didWrite = [contents writeToFile:appFile
                             atomically:YES
                               encoding:NSUTF8StringEncoding
                                  error:&error];
  if (didWrite) {
  }
  else
  {
    NSLog(@"*** TDEngineLog: can't write : %@ \n error: %@***",appFile, error);
  }
}


- (UIViewController *)td_getCurrentViewController
{
    id WindowRootVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    UIViewController *currentViewController = [self td_findTopViewController:WindowRootVC];
    
    return currentViewController;
}

- (UIViewController *)td_findTopViewController:(id)inController
{
    /* if ur using any Customs classes, do like this.
     * Here SlideNavigationController is a subclass of UINavigationController.
     * And ensure you check the custom classes before native controllers , if u have any in your hierarchy.
     if ([inController isKindOfClass:[SlideNavigationController class]])
     {
     return [self findTopViewController:[inController visibleViewController]];
     }
     else */
    if ([inController isKindOfClass:[UITabBarController class]])
    {
        return [self td_findTopViewController:[inController selectedViewController]];
    }
    else if ([inController isKindOfClass:[UINavigationController class]])
    {
        return [self td_findTopViewController:[inController visibleViewController]];
    }
    else if ([inController isKindOfClass:[UIViewController class]])
    {
        return inController;
    }
    else
    {
        NSLog(@"*** TDEngineLog: Unhandled ViewController class : %@ ***",inController);
        return nil;
    }
}


/**
 *  sendMailLog
 *
 *  @param sender id
 */
+ (MFMailComposeViewController *)td_mailViewController
{
    //    Internal error reporting
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = (id)[TDEngineLog td_sharedManager];
    [mailComposer setSubject:[NSString stringWithFormat:@"[ReportLog %@]",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]]];
    
    NSString *emailAdress = @"";
    @try
    {
        emailAdress = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"TD_EmailDevelopment"];
    }
    @catch (NSException *exception) {
        NSLog(@"*** TDEngineLog: you need add email of feeback on 'TD_EmailDevelopment' field in split file!!! ***");
    }
    if ([emailAdress isEqualToString:@""])
    {
        emailAdress = TD_EMAIL_DEVELOPMENT;
    }

    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObjects:emailAdress, nil];
    [mailComposer setToRecipients:toRecipients];
    
    // Attach the Crash Log..
    NSString *logPath = [self td_getPathLog];
    NSData *myData = [NSData dataWithContentsOfFile:logPath];
    
    [mailComposer addAttachmentData:myData mimeType:@"Text/XML" fileName:@"Console.log"];
    
    // Fill out the email body text
    NSString *emailBody = [NSString stringWithFormat:@"Please write detail description for the reason that you want to send to development team, below: \n\n\n\n\n\n\n\n\nDeivice info: \n %@ \n\n\n@copyright of Thuỷ Đào" ,[self td_getDeviceInfo]];
    
    [mailComposer setMessageBody:emailBody isHTML:NO];
    
    return mailComposer;
}

/**
 *  mailComposeController
 *
 *  @param controller MFMailComposeViewController
 *  @param result     MFMailComposeResult
 *  @param error      NSError
 */
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Target
/**
 *  addLogFuntion
 */
- (void)td_addLogFuntion
{
    if(!self.td_viewController) return;
    
    if (!self.td_btnSendLog) {
        self.td_btnSendLog = [[UIButton alloc] initWithFrame:CGRectMake((self.td_viewController.view.frame.size.width -150)/2, (self.td_viewController.view.frame.size.height -45)/2, 150, 45)];
        [self.td_btnSendLog setBackgroundColor:[UIColor grayColor]];
        [self.td_btnSendLog setTitle:@"Error Report" forState:UIControlStateNormal];
        [self.td_btnSendLog addTarget:self action:@selector(td_sendMailLog:) forControlEvents:UIControlEventTouchUpInside];
        self.td_btnSendLog.hidden = NO;
    }
    [self.td_viewController.view addSubview:self.td_btnSendLog];
}


/**
 *  sendMailLog
 *
 *  @param sender id
 */
- (void)td_sendMailLog:(id)sender
{
    if(!self.td_viewController) return;
    
    [self.td_btnSendLog removeFromSuperview];
    
    [self.td_viewController presentViewController:[TDEngineLog td_mailViewController] animated:YES completion:nil];
}

- (void)td_showAlertFeedBack
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FeedBack"
                                                    message:@"The app just crashed. Do you want to sent crash log to developer?"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
         NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:@"0" forKey:@"td_didCrashedBefore"];
        [ud synchronize];
        [self td_sendMailLog:nil];
    }
}

#pragma mark - public method

+ (id)td_sharedManager
{
    static TDEngineLog *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        if ([[ud objectForKey:@"td_didCrashedBefore"] integerValue] == 1) {
            [self td_processLog:[ud objectForKey:@"td_crashLog"]];
            [sharedMyManager performSelector:@selector(td_showAlertFeedBack) withObject:nil afterDelay:3.0];
        }
    });
    return sharedMyManager;
}


+ (void)td_processLog:(NSString *)log
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self td_writeFile:log fileName:TD_LOG_FILE_NAME];
    });
    
}

+ (void)td_clearLog {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self td_clearFile:TD_LOG_FILE_NAME];
  });
}

+ (void)td_enableTDLog:(BOOL)isEnable onViewController:(UIViewController *)viewcontroller
{
    TDEngineLog *engineLog = [TDEngineLog td_sharedManager];
    
    if (isEnable)
    {
        engineLog.td_viewController = viewcontroller;
        if (!engineLog.td_twoFingerTapGesture) {
            engineLog.td_twoFingerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:engineLog action:@selector(td_addLogFuntion)];
            engineLog.td_twoFingerTapGesture.numberOfTapsRequired = 2;
            engineLog.td_twoFingerTapGesture.numberOfTouchesRequired = 1;
            [viewcontroller.view addGestureRecognizer:engineLog.td_twoFingerTapGesture];
        }
    }
    else
    {
        [viewcontroller.view removeGestureRecognizer:engineLog.td_twoFingerTapGesture];
    }
}


@end
