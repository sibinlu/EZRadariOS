//
//  EZPGMImage.m
//  EZRadar
//
//  Created by sibinlu on 16/10/2.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import "EZPGMImage.h"

@interface EZPGMImage ()
@end

@implementation EZPGMImage
-(id)initWithFile:(NSURL*) file;{
    self = [super init];
    if (self) {
        self.file = file;
        [self loadFile];
    }
    return self;
}

-(void)loadFile{
    NSData* data = [NSData dataWithContentsOfURL:self.file];
    //NSUInteger size = [data length] / sizeof(unsigned char);
    unsigned char* cdata = (unsigned char*) [data bytes];
    
    int index = 0;
    
    //First line
    if(cdata[index] != 'P'){
        NSLog(@"Not a pgm file");
        return;
    }
    index++;
    self.type = cdata[index] - 48;
    //if((type != 2) && (type != 3) && (type != 5) && (type != 6)){
    if (self.type != 5) // only handle P5
    {
        NSLog(@"Not valid pgm file type");
        return;
    }
    index++;
    while(cdata[index++] != '\n');             /* skip to end of line*/
    
    //Comment
    if (cdata[index] == '#')              /* skip comment lines */
    {
        while (cdata[index++] != '\n');          /* skip to end of comment line */
    }
    
    //Second line
    self.width = 0;
    while(cdata[index] >= '0'  && cdata[index] <= '9'){
        self.width = self.width*10 + cdata[index]-'0';
        index++;
    }
    while(cdata[index++] != ' ');             /* skip space*/
    
    self.height = 0;
    while(cdata[index] >= '0'  && cdata[index] <= '9'){
        self.height = self.height*10 + cdata[index]-'0';
        index++;
    }
    while(cdata[index++] != '\n');             /* skip to end of line*/
    
    //Third line
    self.maxVal = 0;
    while(cdata[index] >= '0'  && cdata[index] <= '9'){
        self.maxVal = self.maxVal*10 + cdata[index]-'0';
        index++;
    }
    while(cdata[index++] != '\n');             /* skip to end of line*/
    
    self.pixel = malloc(self.width*self.height*sizeof(char));
    memcpy(self.pixel, cdata+index, self.width*self.height);
    
}

-(UIImage*)UIImage{
    return [self UIImageWithOccupiedThreshold:1.f FreeThreshold:0.f];
}

-(UIImage*)UIImageWithOccupiedThreshold:(CGFloat)occupied_threshold  FreeThreshold:(CGFloat)free_threshold{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    int freePoint = 0xffffffff;
    int occupyPoint = 0xff000000;
    
    int occupied_gray_threshold = 0xff - 0xff * occupied_threshold;
    int free_gray_threshold = 0xff - 0xff * free_threshold;
    //int bg = 0xcd;
    
    size_t width = self.width;
    size_t height = self.height;
    size_t bytesPerPixel = 4;
    size_t bytesPerRow = bytesPerPixel * width;
    size_t bitsPerComponent = 8;
    //4 bytes per pixel (R, G, B, A) = 8 bytes for a pixel image:
    
    int32_t* rgbPixels = malloc(width*height* sizeof(int32_t));
    
    for (int i =0 ; i<=width*height-1;i++){
        int apixel = self.pixel[i];
        apixel = apixel & 0x000000ff;
        if (apixel<=occupied_gray_threshold) {
            rgbPixels[i] = occupyPoint;
        }
        else if (apixel>=free_gray_threshold) {
            rgbPixels[i] = freePoint;
        }
        else{
            rgbPixels[i] = (0xff<<24) | (apixel<<16) |(apixel<<8) |apixel;
        }
        
    }
    
    CGContextRef context = CGBitmapContextCreate(rgbPixels, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    //This is your image:
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    //Don't forget to clean up:
    CGImageRelease(cgImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    if (rgbPixels) {
        free(rgbPixels);
    }
    return image;
}

-(void)dealloc{
    if (self.pixel){
        free(self.pixel);
    }
}
@end
