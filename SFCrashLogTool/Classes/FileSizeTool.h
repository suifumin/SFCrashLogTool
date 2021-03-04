//
//  FileSizeTool.h
//  AppLog
//
//  Created by suifumin on 2021/2/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileSizeTool : NSObject
+ (float)folderSizeAtPath:(NSString*) folderPath;
@end

NS_ASSUME_NONNULL_END
