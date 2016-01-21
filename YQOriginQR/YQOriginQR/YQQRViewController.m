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
}


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
    // Do any additional setup after loading the view.
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
