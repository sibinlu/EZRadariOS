//
//  EZPGMImage.h
//  EZRadar
//
//  Created by sibinlu on 16/10/2.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EZPGMImage : NSObject
@property (nonatomic, strong)NSURL* file;
@property NSUInteger type;
@property NSUInteger width;
@property NSUInteger height;
@property NSUInteger maxVal;
@property char* pixel;
-(id)initWithFile:(NSURL*) file;
-(UIImage*)UIImage;
-(UIImage*)UIImageWithOccupiedThreshold:(CGFloat)occupied_threshold  FreeThreshold:(CGFloat)free_threshold;
@end
