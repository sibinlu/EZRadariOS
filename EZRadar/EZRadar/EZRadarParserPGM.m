//
//  EZRadarParserPGM.m
//  EZRadar
//
//  Created by sibinlu on 16/10/2.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import "EZRadarParserPGM.h"

@interface EZRadarParserPGM()
@property (nonatomic,strong) NSString* pgmFile;
@property (nonatomic,strong) NSString* yamlFile;
@end

@implementation EZRadarParserPGM

-(id) initWithPGMFile:(NSString*) pgmFile andYAMLFile:(NSString*) yamlFile;{
    self = [super init];
    if (self) {
        self.pgmFile = pgmFile;
        self.yamlFile = yamlFile;
        [self readPGM];
    }
    return self;
}

-(void)readPGM{
    NSURL* fileurl = [[NSBundle mainBundle] URLForResource:self.pgmFile withExtension:@""];
    NSData* data = [NSData dataWithContentsOfURL:fileurl ];
    NSUInteger* l =  [data length];
    
    NSLog(@"%lu",l);
}

-(UIImage*) resultImage;{
    return [[UIImage alloc] init];
}




@end
