//
//  MLComplementNotification.m
//  GlobalReading
//
//  Created by MLinc on 2014-06-29.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import "MLComplementNotification.h"
#import "MLWordsDb.h"


@interface MLComplementNotification()

@property(nonatomic, strong)NSDate* fireDate;

@end

@implementation MLComplementNotification

- (instancetype)initWithFireDate:(NSDate*)date
{
    self = [super init];
    if (self) {
        self.fireDate = date;
        self.alertBody = [MLWordsDb getWord];//@"HELLO";
        self.alertAction = @"View";
        self.applicationIconBadgeNumber = 1;
    }
    return self;
}

@end
