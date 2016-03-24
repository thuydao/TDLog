//
//  TDEngineLog.h
//  TDEngineLog
//
//  Created by Dao Duy Thuy on 11/27/15.
//  Copyright © 2015 Moboco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <UIKit/UIKit.h>


#ifdef DEBUG
#define TDLOG(fmt, ...) {\
    NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);\
    NSString *logtext = [NSString stringWithFormat:(@"%@ %s [Line %d] " fmt),[NSDate date], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__];\
    [TDEngineLog td_processLog:logtext];\
}
#else
#define TDLOG(fmt, ...) {\
    NSString *logtext = [NSString stringWithFormat:(@"%@ %s [Line %d] " fmt),[NSDate date], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__];\
    [TDEngineLog td_processLog:logtext];\
}
#endif


@interface TDEngineLog : NSObject

+ (void)td_processLog:(NSString *)log;
+ (void)td_clearLog;

+ (id)td_sharedManager;
+ (NSString *)td_getPathLog;
+ (MFMailComposeViewController *)td_mailViewController;

//+ (void)td_enableTDLog:(BOOL)isEnable onViewController:(UIViewController *)viewcontroller;

@end
