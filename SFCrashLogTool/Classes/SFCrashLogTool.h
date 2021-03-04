//
//  SFCrashLogTool.h
//  AppLog
//
//  Created by suifumin on 2021/2/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFCrashLogTool : NSObject
/**
 生成闪退日志
 */
+ (BOOL)generateLog:(NSException *)ception;
/**
 获取日志数组
 */
+(NSString*)getCrashLogData;
/**
 上传至服务器之后删除沙盒内的日志文件
 */
+ (BOOL)removeLogFile;

@end

NS_ASSUME_NONNULL_END
