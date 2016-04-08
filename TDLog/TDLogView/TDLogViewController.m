//
//  TDLogViewController.m
//  TDFloatIcon
//
//  Created by sa vincent on 3/23/16.
//  Copyright © 2016 sa vincent. All rights reserved.
//

#import "TDLogViewController.h"
#import "TDEngineLog.h"
#import "TDLogManagement.h"

@interface TDLogViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *wvLog;

@end

@implementation TDLogViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.wvLog.scrollView.backgroundColor = [UIColor blackColor];
  self.wvLog.backgroundColor = [UIColor blackColor];
  self.wvLog.delegate = (id)self;
  [self reloadWebView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (IBAction)dismisPress:(UIButton *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearLogPress:(UIButton *)sender {
  [TDEngineLog td_clearLog];
  [self performSelector:@selector(reloadWebView) withObject:nil afterDelay:1];
}

- (IBAction)clickSendMail:(id)sender {
  [self presentViewController:[TDEngineLog td_mailViewController] animated:YES completion:nil];
}

- (void)reloadWebView {
  NSString *logPath = [TDEngineLog td_getPathLog];
  NSData *myData = [NSData dataWithContentsOfFile:logPath];
  NSString* newStr = [[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding];
  
  
  newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@"</br>"];
  
  for (NSString *key in [TDLogManagement td_sharedInstance].td_LogFilter.allKeys) {
    NSString *value = [TDLogManagement td_sharedInstance].td_LogFilter[key];
    NSString *replace = [NSString stringWithFormat:@"<font color='%@'>%@</font>", key, value];
    newStr = [newStr stringByReplacingOccurrencesOfString:value withString:replace];
  }
  
  
  NSString *content = [NSString stringWithFormat:@"<html><head></head><body style=\"margin: 10px 10px 10px 10px auto;text-align:left;background-color: black; color:white\">%@</body></html>",newStr];
  [self.wvLog loadHTMLString:content baseURL:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  int height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
  
  NSString* javascript = [NSString stringWithFormat:@"window.scrollBy(0, %d);", height];
  [webView stringByEvaluatingJavaScriptFromString:javascript];
}


@end
