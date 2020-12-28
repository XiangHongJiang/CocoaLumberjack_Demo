//
//  ZDFileLoggerManager.h
//  TestLogDemoOriginal
//
//  Created by JXH on 2020/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDFileLoggerManager : NSObject
//启动log收集 : appdelegate 里启动
+ (void)start;

//把log文件拷贝到临时文件，返回文件名
+ (NSArray <NSString *> *)copyLogsItemToTmpDirectory;

//不传默认压缩 tmp 文件夹下除.zip的文件，到 tmp文件夹。 返回压缩后的文件路径。
+ (NSString *)archiveLogsToZipWithPath:(NSString *__nullable)filesPath andFileNames:(NSArray *__nullable)fileNamesArray;

//清理临时文件夹下的所有文件
+ (BOOL)cleanTmpItem;

@end

NS_ASSUME_NONNULL_END
