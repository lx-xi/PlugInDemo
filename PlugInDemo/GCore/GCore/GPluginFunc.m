//
//  GPluginFunc.m
//  GCore
//
//  Created by GreeX on 2021/5/7.
//

#import "GPluginFunc.h"
#import "GCoreNavVC.h"
#import "ShowVC.h"

@implementation GPluginFunc

+ (UIViewController *)showUI {
    ShowVC *root = [[ShowVC alloc] init];
    GCoreNavVC *nav = [[GCoreNavVC alloc] initWithRootViewController:root];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    return nav;
}

@end
