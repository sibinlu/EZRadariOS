//
//  ViewController.m
//  EZRadar
//
//  Created by sibinlu on 16/10/2.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import "EZRadarViewController.h"
#import "EZPGMImage.h"
#import "EZYamlData.h"

@interface EZRadarViewController ()
@property (nonatomic,strong) UIImageView* radarView;
@property (nonatomic,strong) EZPGMImage* pgm;
@property (nonatomic,strong) EZYamlData* yaml;
@end

@implementation EZRadarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSInteger size = MIN(self.view.frame.size.width, self.view.frame.size.height);
    self.radarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    self.radarView.center = self.view.center;
    self.radarView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.radarView];
    
    
    //load test data
    NSString* file_pgm = @"tb_condo_2.pgm";
    NSString* file_yaml = @"tb_condo_2.yaml";
    //NSString* file_pgm = @"test_map.pgm";
    NSURL* pgm_url = [[NSBundle mainBundle] URLForResource:file_pgm withExtension:@""];
    NSURL* yaml_url = [[NSBundle mainBundle] URLForResource:file_yaml withExtension:@""];
    self.pgm = [[EZPGMImage alloc] initWithFile:pgm_url];
    self.yaml = [[EZYamlData alloc] initWithYAMLFile:yaml_url];
    
    
    
    self.radarView.image = [self.pgm UIImageWithOccupiedThreshold:self.yaml.occupied_threshold
                                                    FreeThreshold:self.yaml.free_threshold];
    self.radarView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
