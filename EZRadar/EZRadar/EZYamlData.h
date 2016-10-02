//
//  EZYamlData.h
//  EZRadar
//
//  Created by sibinlu on 16/10/2.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZYamlData : NSObject
@property (nonatomic,strong) NSURL* file;
@property (nonatomic,strong) NSMutableDictionary* dataDict;
@property float occupied_threshold;
@property float free_threshold;

-(id) initWithYAMLFile:(NSURL*) fileURL;
@end
