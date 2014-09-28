//
//  MLWordsDb.m
//  GlobalReading
//
//  Created by MLinc on 2014-06-12.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import "MLWordsDb.h"
#import "MLWord.h"

@interface MLWordsDb ()
@property (nonatomic, strong) MLDatabase* database;
@end

@implementation MLWordsDb
static const int DB_COL_COUNT                           = 2;
static const int DB_DEFAULT_VALUES[]                    = {5, 5, 10};

static const char* DB_WORD_ID     = "ML_PHRASE_ID";
static const char* DB_TABLE_NAME  = "ML_PHRASE_TABLE";
static const char* DB_WORD   = "PHRASE";

static const char* DB_CAT_TABLE_NAME = "ML_CAT_TABLE";
static const char* DB_CAT_ID = "ML_CAT_ID";
static const char* DB_CAT_LABEL = "CAT";

static const char* DB_CAT_PHRASE_TABLE_NAME = "ML_CAT_PH_TABLE";
//static const char* DB_SELECTED     = "SELECTED";


+(MLWordsDb*) sharedInstance
{
    static MLWordsDb* instance = nil;
    static dispatch_once_t onceToken = 0;
    
    if (!instance)
    {
        dispatch_once(&onceToken, ^{
            NSString* DB_CREATE_QUERY = [NSString stringWithFormat:
                    @"CREATE TABLE IF NOT EXISTS %s (%s INTEGER PRIMARY KEY AUTOINCREMENT, %s TEXT);"
                    @"CREATE TABLE IF NOT EXISTS %s (%s INTEGER PRIMARY KEY AUTOINCREMENT, %s TEXT);"
                    @"CREATE TABLE IF NOT EXISTS %s (%s INTEGER , %s INTEGER);", DB_CAT_TABLE_NAME, DB_CAT_ID, DB_CAT_LABEL, DB_TABLE_NAME, DB_WORD_ID, DB_WORD, DB_CAT_PHRASE_TABLE_NAME, DB_CAT_ID, DB_WORD_ID];
            
            instance = [[super allocWithZone: nil] init];
            instance->_database = [[MLDatabase alloc] initDatabaseWithCreateQuery: DB_CREATE_QUERY];
            NSMutableArray *a = [MLWordsDb getAllWords];
            if([a count]==0)
                [instance saveWords];
            
        });
    }
    
    return instance;
}

+(id) allocWithZone:(NSZone*)zone
{
    return [self sharedInstance];
}

-(id) copyWithZone:(NSZone*)zone
{
    return self;
}

+(void) getDefaultSettings:(uint32_t*)time_listen_and_select withTimeListenAndRead:(uint32_t*)time_listen_and_read withListenAndTypeQuestion:(uint32_t*)listen_and_type_question
{
    if (time_listen_and_select && time_listen_and_read && listen_and_type_question)
    {
        *time_listen_and_select = DB_DEFAULT_VALUES[0];
        *time_listen_and_read = DB_DEFAULT_VALUES[1];
        *listen_and_type_question = DB_DEFAULT_VALUES[2];
    }
}

+(NSString*)getWord{
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM %s WHERE Selected IS 1 ORDER BY RANDOM() LIMIT 1", DB_TABLE_NAME];
    
    NSString* errorStr =@"";
    NSMutableArray* dataArr = [NSMutableArray array];
    if ([[[MLWordsDb sharedInstance] database] runQuery:query errorString:&errorStr returnArray:&dataArr])
    {
        if([dataArr count]>0){
//            for(int i =0; i<[dataArr count];i++)
//            {
                NSMutableArray* rowDataArr = [dataArr objectAtIndex:0];
                return [rowDataArr objectAtIndex:1];
//            }
        }
    }
    
    return nil;
}

+(NSMutableArray*)getWords:(int)cnt{

    NSString* query = [NSString stringWithFormat:@"SELECT * FROM %s WHERE Selected IS 1 ORDER BY RANDOM() LIMIT %d", DB_TABLE_NAME, cnt];

    NSString* errorStr =@"";
    NSMutableArray* dataArr = [NSMutableArray array];
    if ([[[MLWordsDb sharedInstance] database] runQuery:query errorString:&errorStr returnArray:&dataArr])
    {
        if([dataArr count]>0){
        NSMutableArray* result = [NSMutableArray array];
        for(int i =0; i<[dataArr count];i++)
        {
            NSMutableArray* rowDataArr = [dataArr objectAtIndex:i];
            MLWord* dataItem = [[MLWord alloc] initWithWord:[rowDataArr objectAtIndex:1]
                                                      wordId:[[rowDataArr objectAtIndex:0] intValue]
                                 ];
            [result addObject:dataItem];
        }
        return result;
        }
    }

    return nil;
}

+(NSMutableArray*)getAllWords{
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM %s AS a",//, %s AS b WHERE a.%s=b.%s AND b.%s=%d",
                       DB_TABLE_NAME];//, DB_CAT_PHRASE_TABLE_NAME, DB_WORD_ID, DB_WORD_ID, DB_CAT_ID, 1];
    
    NSString* errorStr =@"";
    NSMutableArray* dataArr = [NSMutableArray array];
    if ([[[MLWordsDb sharedInstance] database] runQuery:query errorString:&errorStr returnArray:&dataArr])
    {
        if([dataArr count]>0){
            NSMutableArray* result = [NSMutableArray array];
            for(int i =0; i<[dataArr count];i++)
            {
                NSMutableArray* rowDataArr = [dataArr objectAtIndex:i];
                MLWord* dataItem = [[MLWord alloc] initWithWord:[rowDataArr objectAtIndex:1]                                                         wordId:[[rowDataArr objectAtIndex:0] intValue]];
                [result addObject:dataItem];
            }
            return result;
        }
    }

    return nil;

}

+(NSMutableArray*)getAllWordsFromCategory:(int)categoryA categoryB:(int)categoryB{
    //return [MLWordsDb getAllWords];
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM %s AS a, %s AS b, %s AS c WHERE a.%s=b.%s AND a.%s=c.%s AND b.%s=%d AND c.%s=%d AND b.%s=c.%s", DB_TABLE_NAME, DB_CAT_PHRASE_TABLE_NAME, DB_CAT_PHRASE_TABLE_NAME, DB_WORD_ID, DB_WORD_ID, DB_WORD_ID, DB_WORD_ID,  DB_CAT_ID, categoryB, DB_CAT_ID, categoryA, DB_WORD_ID, DB_WORD_ID];
    //NSLog(query);
    NSString* errorStr =@"";
    NSMutableArray* dataArr = [NSMutableArray array];
    if ([[[MLWordsDb sharedInstance] database] runQuery:query errorString:&errorStr returnArray:&dataArr])
    {
        if([dataArr count]>0){
            NSMutableArray* result = [NSMutableArray array];
            for(int i =0; i<[dataArr count];i++)
            {
                NSMutableArray* rowDataArr = [dataArr objectAtIndex:i];
                MLWord* dataItem = [[MLWord alloc] initWithWord:[rowDataArr objectAtIndex:1]                                                         wordId:[[rowDataArr objectAtIndex:0] intValue]];
                [result addObject:dataItem];
            }
            return result;
        }
    }
    
    return nil;
    
}


+(BOOL)saveWord:(NSString*)word selected:(BOOL)selected{

    NSString* query = [NSString stringWithFormat:@"INSERT INTO %s (%s) VALUES('%@');",DB_TABLE_NAME, DB_WORD, word];
    
    NSString* errorStr =@"";
    
    return [[[MLWordsDb sharedInstance] database] runQuery:query errorString:&errorStr];
}

-(BOOL)saveWords
{
    NSArray *c = @[@"Romantic", @"On a lighter note", @"Dating", @"In relation"];
    
    for (int i=0; i<c.count; i++) {
        
        NSString* query =[NSString stringWithFormat:@"INSERT INTO %s (%s) VALUES('%@');",DB_CAT_TABLE_NAME, DB_CAT_LABEL, c[i]];
        NSString* errorStr;
        if(![[[MLWordsDb sharedInstance] database] runQuery:query errorString:&errorStr])
        {
            NSLog(@"%@",errorStr);
            return NO;
        }
    }
    
    
    NSArray *w = @[
                   @"You are beautiful.",//1,2,3,4
                   @"You are an awesome mom.",//1,4
                   @"(Fill in the blank) looks so clean.",//1,4
                   @"You’re so good at your job.",//2,3
                   @"Your mom is cool.",//2,3,4
                   @"I like that shirt/dress on you.",//1,2,3,4
                   @"I like it when you (fill in the blank).",//1,2,3,4
                   @"You take such a good care of our family.",//1,4
                   @"I sure love you."];
    //int cnt = 0;
    for (int i=0; i<w.count; i++) {

        NSString* query =[NSString stringWithFormat:@"INSERT INTO %s (%s) VALUES('%@');",DB_TABLE_NAME, DB_WORD, w[i]];
        NSString* errorStr;
        if(![[[MLWordsDb sharedInstance] database] runQuery:query errorString:&errorStr])
        {
            NSLog(@"%@",errorStr);
            return NO;
        }
    }
    
    NSArray *cp = @[@[@1,@2,@3,@4], @[@1,@4], @[@1,@4], @[@2,@3], @[@2,@3,@4], @[@1,@2,@3,@4], @[@1,@2,@3,@4], @[@1,@4], @[@1,@2,@3,@4]];
    
    
    for (int i=1; i<=cp.count; i++) {
        NSLog(@"cp.cnt=%d\n", cp.count);
        NSLog(@"cp[i].cnt=%d\n", [cp[i-1] count]);
        for(int j=1; j<=[cp[i-1] count]; j++){
            NSString* query =[NSString stringWithFormat:@"INSERT INTO %s (%s, %s) VALUES(%d, %d);",DB_CAT_PHRASE_TABLE_NAME, DB_WORD_ID, DB_CAT_ID, i, [(cp[i-1])[j-1] intValue]];
            NSString* errorStr;
            if(![[[MLWordsDb sharedInstance] database] runQuery:query errorString:&errorStr])
            {
                NSLog(@"%@",errorStr);
                return NO;
            }
        }
    }
    

    
    
    return YES;
}

+(BOOL)updateWord:(NSString*)word selected:(BOOL)selected wordId:(int)wordId
{
    NSString* query =[NSString stringWithFormat:@"UPDATE %s SET %s = '%@' WHERE %s = %d;",DB_TABLE_NAME, DB_WORD, word, DB_WORD_ID, wordId];
        NSString* errorStr;
        if(![[[MLWordsDb sharedInstance] database] runQuery:query errorString:&errorStr])
        {
            NSLog(@"%@",errorStr);
            return NO;
        }else{
            NSLog(@"%@",errorStr);
            return YES;
        }
}

@end
