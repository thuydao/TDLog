//
//  TDLog.m
//  TDFloatIcon
//
//  Created by sa vincent on 3/23/16.
//  Copyright © 2016 sa vincent. All rights reserved.
//

#import "TDLogManagement.h"
#import "TDLogViewController.h"
#import "UIView+TDDragg.h"
#import "TDEngineLog.h"

@implementation TDLogManagement
{
  TDLogViewController *logViewController;
}

+ (instancetype)td_sharedInstance {
  static TDLogManagement *sharedMyManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedMyManager = [[self alloc] init];
  });
  return sharedMyManager;
}

- (NSBundle *)currentBundle {
  NSBundle * mainBundle = [NSBundle mainBundle];
  NSString * pathToMyBundle = [mainBundle pathForResource:@"TDLog" ofType:@"bundle"];
  NSBundle *myLibraryBundle = [NSBundle bundleWithPath:pathToMyBundle];
  return myLibraryBundle;
}

- (id)init {
  if (self = [super init]) {
    self.td_LogFilter = [NSMutableDictionary new];
    self.floatView = [[[self currentBundle] loadNibNamed:NSStringFromClass([FloatView class]) owner:self options:nil] firstObject];
    [self.floatView.btnOverlay addTarget:(id)self action:@selector(floatIconPress:) forControlEvents:UIControlEventTouchUpInside];
    self.floatView.layer.borderColor = [UIColor grayColor].CGColor;
    self.floatView.layer.borderWidth = 1.0f;
    self.floatView.layer.cornerRadius = self.floatView.frame.size.width/2;
    self.floatView.layer.masksToBounds = YES;
  }
  return self;
}

#pragma mark - Public

- (void)td_show {
  //  [self.view addSubview:view];
  UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
  
  for (UIView *view in window.subviews) {
    if ([view isEqual:self.floatView]) {
      [self td_dismis];
      return;
    }
  }
  NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
  CGPoint thePoint = CGPointFromString([userDefaults objectForKey:@"td_float_icon_point"]);
  if (!CGPointEqualToPoint(thePoint, CGPointZero)) {
    
    self.floatView.center = thePoint;
  }
  else {
    self.floatView.center = window.center;
    
  }

  [window addSubview:self.floatView];
  [self.floatView enableDragging];
}

- (void)td_dismis {
  [logViewController dismissViewControllerAnimated:YES completion:nil];
  logViewController = nil;
}

#pragma mark - Private

- (void)floatIconPress:(UIButton *)sender {
  logViewController = [[TDLogViewController alloc] initWithNibName:NSStringFromClass([TDLogViewController class]) bundle:[self currentBundle]];
  UIViewController *currentvc = [self topViewController];
  
  if (![currentvc isKindOfClass:[TDLogViewController class]]) {
    [currentvc presentViewController:logViewController animated:YES completion:nil];
  }
}

- (UIViewController*)topViewController {
  return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
  if ([rootViewController isKindOfClass:[UITabBarController class]]) {
    UITabBarController* tabBarController = (UITabBarController*)rootViewController;
    return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
  } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
    UINavigationController* navigationController = (UINavigationController*)rootViewController;
    return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
  } else if (rootViewController.presentedViewController) {
    UIViewController* presentedViewController = rootViewController.presentedViewController;
    return [self topViewControllerWithRootViewController:presentedViewController];
  } else {
    return rootViewController;
  }
}

- (void)dealloc {
  self.floatView = nil;
}

@end
