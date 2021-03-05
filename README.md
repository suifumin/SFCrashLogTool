# SFCrashLogTool
线上应用闪退收集
# Use
#import <SFCrashLogTool.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    //获取闪退日志
    NSString *logData = [SFCrashLogTool getCrashLogData];
    //上传成功以后删除数据
    //[SFCrashLogTool removeLogFile];
  
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[ViewController alloc]init];
    [self.window makeKeyAndVisible];
    
   

    return YES;
}
void UncaughtExceptionHandler(NSException *exception) {
    //生成闪退日志
    [SFCrashLogTool generateLog:exception];
}
@end
