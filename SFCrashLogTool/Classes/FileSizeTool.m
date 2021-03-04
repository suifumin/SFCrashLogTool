//
//  FileSizeTool.m
//  AppLog
//
//  Created by suifumin on 2021/2/25.
//

#import "FileSizeTool.h"

@implementation FileSizeTool

//遍历文件夹获得文件夹大小，返回多少M

+ (float ) folderSizeAtPath:(NSString*) folderPath{

    NSFileManager* manager = [NSFileManager defaultManager];

    if (![manager fileExistsAtPath:folderPath]) return 0;

    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];

    NSString* fileName;

    long long folderSize = 0;

    while ((fileName = [childFilesEnumerator nextObject]) != nil){

        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];

        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }

    return folderSize/(1024.0*1024.0);

}

//单个文件的大小

+ (float) fileSizeAtPath:(NSString*) filePath{

    NSFileManager* manager = [NSFileManager defaultManager];

    if ([manager fileExistsAtPath:filePath]){

        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }

    return 0;

 

}
@end
