//
//  ZDFileLogger.h
//  TestLogDemoOriginal
//
//  Created by JXH on 2020/12/24.
//

#import "DDFileLogger.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDFileLogger : DDFileLogger

//init初始化
- (instancetype)init;

//自定义文件日志设置的FileLogger
+ (instancetype)loggerWithCustomLogFileManager;

@end

NS_ASSUME_NONNULL_END

#pragma mark - -------------- 自定义文件日志设置 -----------------
@interface ZDLogFileManger : DDLogFileManagerDefault

@end
