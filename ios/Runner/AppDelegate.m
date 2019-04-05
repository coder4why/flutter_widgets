#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    [self initFlutterChannel];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

-(void)initFlutterChannel{
    
    FlutterViewController * controller = (FlutterViewController *)self.window.rootViewController;
    FlutterMethodChannel * channel = [FlutterMethodChannel methodChannelWithName:@"flutter_widgets_demo" binaryMessenger:controller];
    
    __weak typeof (self)wSelf = self;
    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        if ([call.method isEqualToString:@"openLibrary"]) {
            //打开系统相机
            [wSelf openLibrary];
            
        }else{
            //            @[FlutterMethodNotImplemented];
        }
    }];
    
}
-(UIImagePickerController *)imagePickerController{
    if (!_imagePickerController) {
        
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        //跳转动画效果
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}

-(void)openLibrary{
    UIAlertController *alertCtl =[[UIAlertController alloc]init];
    
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    UIAlertAction *xiangji =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"xiangji");
        
        [self openCamera];
    }];
    UIAlertAction *xiangce =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"xiangce");
        
        [self openPhotoLibrary];
    }];
    
    [alertCtl addAction:cancel];
    [alertCtl addAction:xiangji];
    [alertCtl addAction:xiangce];
    
    [self.window.rootViewController presentViewController:alertCtl animated:YES completion:nil];
    
    
}

/**
 *  调用照相机
 */
-(void)openCamera{
    
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        //摄像头
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.window.rootViewController presentViewController:self.imagePickerController animated:YES completion:nil];
    }
    else{
        NSLog(@"没有摄像头");
    }
}
/**
 *  打开相册
 */
-(void)openPhotoLibrary{
    
    // 进入相册
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.window.rootViewController presentViewController:self.imagePickerController animated:YES completion:^{
            NSLog(@"打开相册");
        }];
    }else{
        NSLog(@"不能打开相册");
    }
}
#pragma mark - UIImagePickerControllerDelegate
// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end




