//
//  MLWord.m
//  GlobalReading
//
//  Created by MLinc on 2014-06-13.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import "MLWord.h"

@implementation MLWord
- (instancetype)initWithWord:(NSString*)word  wordId:(int)wordId
{
    self = [super init];
    if (self) {
        self.word = word;
        self.wordId = wordId;
    }
    return self;
}
@end
