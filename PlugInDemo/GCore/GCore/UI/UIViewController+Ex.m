//
//  UIViewController+Ex.m
//  GCore
//
//  Created by GreeX on 2021/5/7.
//

#import "UIViewController+Ex.h"
#import "GMacros.h"

@implementation UIViewController (Ex)

- (void)addNavBackItemWithColor:(UIColor *__nullable)color {
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:bImage(@"arrow_left") style:UIBarButtonItemStylePlain target:self action:@selector(navigationBack)];
    if (color == nil) {
        color = UIColorFromHex(0x666666);
    }
    item.tintColor = color;
    self.navigationItem.leftBarButtonItem = item;
}

- (void)navigationBack {
    if (self.navigationController.viewControllers.count == 1 && [self.navigationController.viewControllers lastObject] == self) {
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
        return;
    }
    [self.navigationController popViewControllerAnimated:true];
}


@end
