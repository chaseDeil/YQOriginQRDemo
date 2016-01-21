//
//  ViewController.m
//  YQOriginQR
//
//  Created by chase on 16/1/21.
//  Copyright © 2016年 chase_liu. All rights reserved.
//

#import "ViewController.h"
#import "YQQRViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"YQ扫描Demo";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 40, 200, 80, 40)];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"开始扫描" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(QRAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)QRAction:(UIButton *)sender
{
    YQQRViewController *yqView = [[YQQRViewController alloc] init];
    [self.navigationController pushViewController:yqView animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
