//
//  MLWord.h
//  GlobalReading
//
//  Created by MLinc on 2014-06-13.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLWord : NSObject
@property(strong, nonatomic)NSString* word;
@property(nonatomic)int wordId;
- (instancetype)initWithWord:(NSString*)word  wordId:(int)wordId;

@end
