//
//  EZRadarParserPGM.h
//  EZRadar
//
//  Created by sibinlu on 16/10/2.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EZRadarParserPGM : NSObject

-(id) initWithPGMFile:(NSString*) pgmFile andYAMLFile:(NSString*) yamlFile;
-(UIImage*) resultImage;
@end
