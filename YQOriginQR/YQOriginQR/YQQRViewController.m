//
//  YQQRViewController.m
//  YQOriginQR
//
//  Created by chase on 16/1/21.
//  Copyright © 2016年 chase_liu. All rights reserved.
//

#import "YQQRViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface YQQRViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
{
    AVCaptureSession *session;
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}

@property (nonatomic, strong) UIImageView * line;

@end

@implementation YQQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    [session addInput:input];
    [session addOutput:output];
    
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]];
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:layer];
    [session startRunning];
    
    // 控制扫描区域 参考：http://blog.csdn.net/lc_obj/article/details/41549469
    [output setRectOfInterest:CGRectMake((124)/self.view.frame.size.height,((self.view.frame.size.width-300)/2)/self.view.frame.size.width,300/self.view.frame.size.height,300/self.view.frame.size.width)];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 145, 70, 290, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [self.view addSubview:labIntroudction];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 150, 125, 300, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 110, 125, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(YQAnimation) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

- (void)YQAnimation
{
    if (upOrdown) {
        num--;
        _line.frame = CGRectMake(self.view.frame.size.width / 2 - 110, 135 + 2 * num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    } else {
        num ++;
        _line.frame = CGRectMake(self.view.frame.size.width / 2 - 110, 135 + 2 * num, 220, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *matadataObject = [metadataObjects objectAtIndex:0];
        NSLog(@"%@", matadataObject.stringValue);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描信息" message:matadataObject.stringValue delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [session stopRunning];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [session startRunning];
    }
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
