//
//  AppDelegate.m
//  SFCrashLogTool
//
//  Created by suifumin on 2021/3/3.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SFCrashLogTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    NSString *logs = [SFCrashLogTool getCrashLogData];
    //上传之后删除
    //[SFCrashLogTool removeLogFile];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[ViewController alloc]init];
    [self.window makeKeyAndVisible];
    return YES;
}

void UncaughtExceptionHandler(NSException *exception) {
    BOOL flag = [SFCrashLogTool generateLog:exception];
    
}

@end
