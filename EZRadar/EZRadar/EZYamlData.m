//
//  EZYamlData.m
//  EZRadar
//
//  Created by sibinlu on 16/10/2.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import "EZYamlData.h"

@implementation EZYamlData
-(id) initWithYAMLFile:(NSURL*) fileURL;{
    self = [super init];
    if (self) {
        self.file = fileURL;
        self.occupied_threshold = 1;
        self.free_threshold = 0;
        self.dataDict = [NSMutableDictionary dictionary];
        [self loadData];
    }
    return self;
}

-(void)loadData{
    NSString* content = [NSString stringWithContentsOfURL:self.file encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [content componentsSeparatedByString:@"\n"];
    for (NSString* line in lines) {
        NSArray* keyValue = [line componentsSeparatedByString:@":"];
        if (keyValue.count>=2) {
            NSString* key = [keyValue[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString* value = [keyValue[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [self.dataDict setValue:value forKey:key];
        }
    }
    
    [self loadThreshold];
}

-(void)loadThreshold{
    NSString* occupied_threshold = [self.dataDict objectForKey:@"occupied_thresh"];
    NSString* free_threshold = [self.dataDict objectForKey:@"free_thresh"];
    
    if (occupied_threshold) {
        self.occupied_threshold = [occupied_threshold floatValue];
    }
    if (free_threshold) {
        self.free_threshold = [free_threshold floatValue];
    }

}
@end
