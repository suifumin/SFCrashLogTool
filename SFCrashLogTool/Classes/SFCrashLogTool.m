//
//  SFCrashLogTool.m
//  AppLog
//
//  Created by suifumin on 2021/2/26.
//

#import "SFCrashLogTool.h"
#import "DeviceTypeTool.h"
#import "NSString+Time.h"
#import <UIKit/UIKit.h>
#import "FileSizeTool.h"



@interface SFCrashLogTool ()
@end
static SFCrashLogTool * tool = nil;
@implementation SFCrashLogTool
/**
 生成crash日志
 Bool为YES，生成日志成功
 Bool为NO，生成日志失败
 */
+(BOOL)generateLog:(NSException *)ception {
    NSArray<NSString *> *array = ception.callStackSymbols;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"LogFile"];
    //获取闪退的时间
    NSString *timeStr = [NSString getNowTimeTimestamp];
    NSString *fileType = [NSString stringWithFormat:@"%@.txt",timeStr];
    NSString * filePath =  [path stringByAppendingPathComponent:fileType];
    NSMutableArray *logArray = [NSMutableArray arrayWithArray:array];
    //获取手机类型
    NSString *deviceType = [NSString stringWithFormat:@"手机型号:%@",DeviceTypeTool.getCurrentDeviceType];
    //获取当前系统的版本号
    NSString * sysTemVersion = [NSString stringWithFormat:@"手机系统版本号%@",[UIDevice currentDevice].systemVersion];
    //获取当前app版本号
    NSString * appVersion = [NSString stringWithFormat:@"APP版本号%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    NSString *crashTime = [NSString stringWithFormat:@"闪退时间:%@",timeStr];
    [logArray addObject:deviceType];
    [logArray addObject:sysTemVersion];
    [logArray addObject:appVersion];
    [logArray addObject:crashTime];
    BOOL flag =  [logArray writeToFile:filePath atomically:YES];
    return flag;
    
}
/**
 获取crash日志
 */
+(NSString *)getCrashLogData {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *directryPath = [path stringByAppendingPathComponent:@"LogFile"];
    [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
   NSArray *childA =  [fileManager subpathsAtPath:directryPath];
    NSMutableArray *logResultA = [NSMutableArray arrayWithCapacity:childA.count];
    for (NSString *fileName in childA) {
     
        NSString *tempPath = [directryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
        NSArray *logA = [NSArray arrayWithContentsOfFile:tempPath];
       
        NSData *data = [NSJSONSerialization dataWithJSONObject:logA options:NSJSONWritingPrettyPrinted error:nil];
     
        NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        [logResultA addObject:jsonStr];
        
    }
    
    
    float num = [FileSizeTool folderSizeAtPath:directryPath];
    if (num > 1) {
       BOOL flag = [fileManager removeItemAtPath:directryPath error:nil];
        if (flag) {
            NSLog(@"移除成功");
        }
    }
    NSString *resultstr = [logResultA componentsJoinedByString:@","];
    return resultstr;
}
+ (BOOL)removeLogFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *directryPath = [path stringByAppendingPathComponent:@"LogFile"];
    return [fileManager removeItemAtPath:directryPath error:nil];
}


+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[super allocWithZone:NULL]init];
    });
    return tool;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [SFCrashLogTool shareInstance];
}
- (id)copyWithZone:(NSZone *)zone {
    return [SFCrashLogTool shareInstance];
}

@end
