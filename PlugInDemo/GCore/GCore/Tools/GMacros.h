//
//  Macros.h
//  running
//
//  Created by GreeX on 2021/4/23.
//

#ifndef GMacros_h
#define GMacros_h

//MARK: - 工具宏
//获取物理屏幕的尺寸
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width

#define SafeAreaTopHeight           (isLiuhai ? 88 : 64)
#define SafeAreaBottomHeight        (isLiuhai ? 34 : 0)
#define STATUS_BAR_HEIGHT           20.0
#define NAVIGATION_BAR_HEIGHT       44.0

//typeof self
#define WEAK_SELF __weak typeof(self)weakSelf = self;
#define STRONG_SELF __strong typeof(weakSelf)strongSelf = weakSelf;

//插件路径
#define kFrameworkPath [NSString stringWithFormat:@"%@/Documents/GCore.framework", NSHomeDirectory()]
#define kBundlePath [NSString stringWithFormat:@"%@/Documents/GCore.bundle", NSHomeDirectory()]

//图片
#define image(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@", imageName]]
#define bImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", kBundlePath, imageName]]

//RGB color
#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//十六进制 色值
#define UIColorFromHex(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//是否刘海屏
#define isLiuhai ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})

//设置是否调试模式
#define RUN_DEBUG 1
#if RUN_DEBUG
#define GLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define GLog(xx, ...)  ((void)0)
#endif

//MARK: - 第三方
#define AMAP_KEY @"b7c60d18a077b636fb9844508c9d7072"



#endif /* Macros_h */
