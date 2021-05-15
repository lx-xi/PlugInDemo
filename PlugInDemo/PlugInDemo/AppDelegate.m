//
//  AppDelegate.m
//  PlugInDemo
//
//  Created by GreeX on 2021/5/6.
//

#import "AppDelegate.h"
#import "TestVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    self.window.rootViewController = [[TestVC alloc] init];
    
    return YES;
}





@end
