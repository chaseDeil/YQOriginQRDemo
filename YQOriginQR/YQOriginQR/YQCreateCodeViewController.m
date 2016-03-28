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
    
    UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.frame.size.width / 2 - 20, _imgView.frame.size.height / 2 - 20, 40, 40)];
    logoImg.layer.cornerRadius = 4.0f;
    logoImg.clipsToBounds = YES;
    logoImg.backgroundColor = [UIColor redColor];
    logoImg.image = [UIImage imageNamed:@"29(1)"];
    [_imgView addSubview:logoImg];
    
    [self createQRCode];
    // Do any additional setup after loading the view.
}

- (void)createQRCode
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [@"有限责任公司 注册号：210403000015196 名称：抚顺市固厦土建维修有限公司 企业类型：有限责任公司 地址：抚顺市东洲区搭连街新苑小区8号楼1单元203号 负责人：孙桂香；人民币贰佰万元整；成立日期：2015年01月23日；经营期限：自2015年01月23日至2035年01月23日；经营范围：土建维修、道路普通货物运输（依法须经批准的项目，经相关部门批准后方可开展经营活动）。http://gext.lngs.gov.cn" dataUsingEncoding:NSUTF8StringEncoding];
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
