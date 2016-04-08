//
//  TDLog.h
//  TDFloatIcon
//
//  Created by sa vincent on 3/23/16.
//  Copyright © 2016 sa vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FloatView.h"

#define L_Red             @"red"
#define L_Sienna          @"Sienna"
#define L_SkyBlue         @"SkyBlue"
#define L_SlateGray       @"SlateGray"
#define L_Yellow          @"Yellow"
#define L_Navy            @"Navy"
#define L_LimeGreen       @"LimeGreen"
#define L_LightSeaGreen   @"LightSeaGreen"
#define L_Indigo          @"Indigo"




@interface TDLogManagement : NSObject

@property (nonatomic, strong) FloatView *floatView;
@property (nonatomic, strong) NSMutableDictionary *td_LogFilter; //text: value, color: key

+ (instancetype)td_sharedInstance;

#pragma mark - Public
- (void)td_show;

@end
