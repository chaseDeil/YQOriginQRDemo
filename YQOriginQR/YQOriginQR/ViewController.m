//
//  ViewController.m
//  YQOriginQR
//
//  Created by chase on 16/1/21.
//  Copyright © 2016年 chase_liu. All rights reserved.
//

#import "ViewController.h"
#import "YQQRViewController.h"
#import "YQCreateCodeViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"YQ二维码Demo";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 60, 200, 120, 40)];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"开始扫描" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(QRAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *CreateCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 60, 250, 120, 40)];
    CreateCodeBtn.backgroundColor = [UIColor orangeColor];
    [CreateCodeBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
    [CreateCodeBtn addTarget:self action:@selector(QRAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CreateCodeBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)QRAction:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"开始扫描"]) {
        
        YQQRViewController *yqView = [[YQQRViewController alloc] init];
        [self.navigationController pushViewController:yqView animated:YES];
    } else if ([sender.titleLabel.text isEqualToString:@"生成二维码"]) {
        YQCreateCodeViewController *createView = [[YQCreateCodeViewController alloc] init];
        [self.navigationController pushViewController:createView animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
