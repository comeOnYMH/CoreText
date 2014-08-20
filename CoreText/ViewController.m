//
//  ViewController.m
//  CoreText
//
//  Created by 杨名海 on 14-8-14.
//  Copyright (c) 2014年 杨名海. All rights reserved.
//

#import "ViewController.h"
#import "CoreTextView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    CoreTextView *coreTextView = [[CoreTextView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    [self.view addSubview:coreTextView];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
