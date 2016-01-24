//
//  YQCreateCodeViewController.m
//  YQOriginQR
//
//  Created by chase on 16/1/24.
//  Copyright © 2016年 chase_liu. All rights reserved.
//

#import "YQCreateCodeViewController.h"

@interface YQCreateCodeViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation YQCreateCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生成二维码";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100, self.view.frame.size.height / 2 - 100, 200, 200)];
    _imgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imgView];
    [self createQRCode];
    // Do any additional setup after loading the view.
}

- (void)createQRCode
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [@"www.baidu.com" dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImg = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imgRef = [context createCGImage:outputImg fromRect:[outputImg extent]];
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    _imgView.image = img;
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
//    _imgView.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
//    
//    _imgView.layer.shadowRadius=1;//设置阴影的半径
//    
//    _imgView.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
//    
//    _imgView.layer.shadowOpacity=0.3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
