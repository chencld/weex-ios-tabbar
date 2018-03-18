//
//  WeexSDKManager.m
//  WeexDemo
//
//  Created by yangshengtao on 16/11/14.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "WeexSDKManager.h"
#import "DemoDefine.h"
#import <WeexSDK/WeexSDK.h>
#import "WXDemoViewController.h"
#import "WXImgLoaderDefaultImpl.h"

@implementation WeexSDKManager

+ (void)setup;
{
//    NSURL *url = nil;
//#if DEBUG
//    //If you are debugging in device , please change the host to current IP of your computer.
//    url = [NSURL URLWithString:BUNDLE_URL];
//#else
//    url = [NSURL URLWithString:BUNDLE_URL];
//#endif
//    NSString * entryURL = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"WXEntryBundleURL"];
//    if (entryURL) {
//        if ([entryURL hasPrefix:@"http"]) {
//            url = [NSURL URLWithString:entryURL];
//        } else {
//            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSBundle bundleForClass:self] resourceURL].absoluteString, entryURL]];
//        }
//    }
//
//#ifdef UITEST
//    url = [NSURL URLWithString:UITEST_HOME_URL];
//#endif
    
    [self initWeexSDK];
    [self loadCustomContainWithScanner];
}

+ (void)loadCustomContainWithScanner
{
    [[UIApplication sharedApplication] delegate].window.rootViewController = [self rootViewController];
}

+ (void)initWeexSDK
{
    [WXAppConfiguration setAppGroup:@"AliApp"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setAppVersion:@"1.8.3"];
    [WXAppConfiguration setExternalUserAgent:@"ExternalUA"];
    
    [WXSDKEngine initSDKEnvironment];
    
    [WXSDKEngine registerHandler:[WXImgLoaderDefaultImpl new] withProtocol:@protocol(WXImgLoaderProtocol)];
    
#ifdef DEBUG
    [WXLog setLogLevel:WXLogLevelLog];
#endif
}

+ (NSURL *)getJSFileURLWithName:(NSString *)jsName
{
    NSURL * jsUrl =[NSURL URLWithString:[NSString stringWithFormat:@"file://%@/bundlejs/%@",[NSBundle mainBundle].bundlePath,jsName]];
    return jsUrl;
}

+ (UIViewController *)createViewControlerWithUrl:(NSURL *)url title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)imageSel
{
    
    UIViewController * weexVC = [[WXDemoViewController alloc] init];
    ((WXDemoViewController *)weexVC).url = url;
    
    WXRootViewController * navgatorViewController = [[WXRootViewController alloc] initWithRootViewController:weexVC];
    
    UITabBarItem * weexItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:imageSel];
    navgatorViewController.tabBarItem = weexItem;
    return navgatorViewController;
}

+ (UITabBarController *)rootViewController
{
    
    UIImage *tab1 = [UIImage imageNamed:@""];
    UIImage *tabSel1 = [UIImage imageNamed:@""];
    UIImage *tab2 = [UIImage imageNamed:@""];
    UIImage *tabSel2 = [UIImage imageNamed:@""];
    UIImage *tab3 = [UIImage imageNamed:@""];
    UIImage *tabSel3 = [UIImage imageNamed:@""];
    UIImage *tab4 = [UIImage imageNamed:@""];
    UIImage *tabSel4 = [UIImage imageNamed:@""];
    UIViewController * homeViewController = [self createViewControlerWithUrl:[self getJSFileURLWithName:@"tab1.js"] title:@"tab1" image:[tab1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[tabSel1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIViewController * activityViewController = [self createViewControlerWithUrl:[self getJSFileURLWithName:@"tab2.js"] title:@"tab2" image:[tab2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[tabSel2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIViewController * createViewController = [self createViewControlerWithUrl:[self getJSFileURLWithName:@"tab3.js"] title:@"tab3" image:[tab3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[tabSel3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIViewController * mineViewController = [self createViewControlerWithUrl:[self getJSFileURLWithName:@"tab4.js"] title:@"tab4" image:[tab4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[tabSel4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarController * tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers =@[homeViewController, activityViewController, createViewController,mineViewController];
    
    return tabBarController;
}

+ (void)setTabIndex:(NSInteger)index
{
    UITabBarController *tabVC = (UITabBarController *)[[UIApplication sharedApplication] delegate].window.rootViewController;
    if (tabVC) {
        tabVC.selectedIndex = index;
    }
}



@end
