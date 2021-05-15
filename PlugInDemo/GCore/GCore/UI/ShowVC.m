//
//  ShowVC.m
//  GCore
//
//  Created by GreeX on 2021/5/6.
//

#import "ShowVC.h"
#import "GMacros.h"
#import "UIViewController+Ex.h"
#import "SecShowVC.h"

@interface ShowVC ()


@end

@implementation ShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth - 40, 44)];
    tf.placeholder = @"请输入文字";
    [self.view addSubview:tf];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, 200, 100, 44);
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 300, 100, 100)];
    imgView.image = bImage(@"image.png");
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    
    [self addNavBackItemWithColor:nil];
}

- (void)goBackAction {
    [self navigationBack];
}

- (void)pushAction {
    SecShowVC *vc = [[SecShowVC alloc] init];
    vc.title = @"第二页";
    [self.navigationController pushViewController:vc animated:true];
}



@end
