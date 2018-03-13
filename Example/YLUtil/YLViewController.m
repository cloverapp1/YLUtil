//
//  YLViewController.m
//  YLUtil
//
//  Created by 2510479687@qq.com on 03/13/2018.
//  Copyright (c) 2018 2510479687@qq.com. All rights reserved.
//

#import "YLViewController.h"
#import "YLUtils.h"

@interface YLViewController ()

@end

@implementation YLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self testString];
}

- (void)testString{
    NSString *str0 = @"";
    NSString *str1 = @" ";
    NSString *str2 = @"test";
    
    BOOL isNil0 = [NSString isEqualToNil:str0];
    BOOL isNil1 = [NSString isEqualToNil:str1];
    BOOL isNil2 = [NSString isEqualToNil:str2];
    
    NSLog(@"isNil0 = %d\n isNil1 = %d\n isNil2 = %d\n",isNil0,isNil1,isNil2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
