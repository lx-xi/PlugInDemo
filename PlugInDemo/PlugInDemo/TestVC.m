//
//  TestVC.m
//  PlugInDemo
//
//  Created by GreeX on 2021/5/6.
//

#import "TestVC.h"
#import <AFNetworking.h>
#import <SSZipArchive.h>

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

/// 下载并解压
- (IBAction)downloadPlugInAction:(id)sender {
    NSString *frameworkPath = [NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[frameworkPath stringByAppendingPathComponent:@"GCore.zip"]]){
        [[NSFileManager defaultManager] removeItemAtPath:[frameworkPath stringByAppendingPathComponent:@"GCore.zip"] error:nil];
    }
    
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    
    NSString *url = @"http://localhost/GCore.zip";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress = %@", downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *filePath = [NSString stringWithFormat:@"%@/Documents/GCore.zip", NSHomeDirectory()];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"下载完成");
        
        NSString *errMsg = @"";
        if (error == nil) {
            //删除原有库
            NSString *frameworkPath = [NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()];
            if ([[NSFileManager defaultManager] fileExistsAtPath:[frameworkPath stringByAppendingPathComponent:@"GCore.framework"]]){
                [[NSFileManager defaultManager] removeItemAtPath:[frameworkPath stringByAppendingPathComponent:@"GCore.framework"] error:nil];
            }
            if ([[NSFileManager defaultManager] fileExistsAtPath:[frameworkPath stringByAppendingPathComponent:@"GCore.bundle"]]){
                [[NSFileManager defaultManager] removeItemAtPath:[frameworkPath stringByAppendingPathComponent:@"GCore.bundle"] error:nil];
            }
            
            //解压库
            NSString *zipPath = [NSString stringWithFormat:@"%@/Documents/GCore.zip", NSHomeDirectory()];
            BOOL res = [SSZipArchive unzipFileAtPath:zipPath toDestination:frameworkPath];
            if (res) {
                errMsg = @"下载并解压成功";
            } else {
                errMsg = @"下载但解压失败";
            }
            NSLog(@"frameworkPath = %@", frameworkPath);
        } else {
            errMsg = @"下载失败";
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errMsg message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }];
    [downloadTask resume];
}

/// 加载
- (IBAction)loadPlugInAction:(id)sender {
    NSString *frameworkPath = [NSString stringWithFormat:@"%@/Documents/GCore.framework", NSHomeDirectory()];
    NSError *err = nil;
    NSBundle *bundle = [NSBundle bundleWithPath:frameworkPath];
    NSString *str = @"加载动态库失败!";
    if ([bundle loadAndReturnError:&err]) {
        NSLog(@"bundle load framework success.");
        str = @"加载动态库成功!";
    } else {
        NSLog(@"bundle load framework err:%@",err);
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

/// 调用
- (IBAction)plugInAction:(id)sender {
    Class GPluginFunc = NSClassFromString(@"GPluginFunc");
    if(GPluginFunc){
        UIViewController *ctrl = [GPluginFunc performSelector:@selector(showUI)];
        [self presentViewController:ctrl animated:true completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"调用方法失败!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}


// MARK: - 设置AFHTTPSessionManager相关属性
- (AFHTTPSessionManager *)createAFHTTPSessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*",
                                                                              @"application/jason/javascript"]];
    return manager;
}


@end
