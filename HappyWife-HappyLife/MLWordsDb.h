//
//  MLWordsDb.h
//  GlobalReading
//
//  Created by MLinc on 2014-06-12.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import "MLDatabase.h"
#import "MLWord.h"

@interface MLWordsDb : MLDatabase


+(NSMutableArray*)getWords:(int)cnt;
+(NSMutableArray*)getAllWords;
+(NSMutableArray*)getAllWordsFromCategory:(int)categoryA categoryB:(int)categoryB;
+(NSString*)getWord;
+(BOOL)saveWord:(NSString*)word selected:(BOOL)selected;
+(BOOL)updateWord:(NSString*)word selected:(BOOL)selected wordId:(int)wordId;
@end
