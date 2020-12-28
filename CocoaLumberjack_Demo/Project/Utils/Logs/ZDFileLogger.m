//
//  ZDFileLogger.m
//  TestLogDemoOriginal
//
//  Created by JXH on 2020/12/24.
//

#import "ZDFileLogger.h"

@implementation ZDFileLogger

- (instancetype)init {
    if (self = [super init]) {
        [self initial];
    }
    return self;
}
//自定义FileLog初始化
+ (instancetype)loggerWithCustomLogFileManager {
    ZDFileLogger *logger = [[ZDFileLogger alloc] initWithLogFileManager:[ZDLogFileManger new]];
    [logger initial];
    return logger;
}
//初始化日志设置
- (void)initial {
    //最大的日志文件数量
    self.logFileManager.maximumNumberOfLogFiles = 2;
#ifdef DEBUG
    //文件大小
    self.maximumFileSize = 1024*1024;// 1m
    //保存周期
    self.rollingFrequency = 60;//60s
#else
    //文件大小
    self.maximumFileSize = 1024*1024*10;// 10M
    //保存周期
    self.rollingFrequency = 60*60*24;//1天
#endif
}

@end

#pragma mark - -------------- 自定义文件输出路径 -----------------
@implementation ZDLogFileManger
/**
 自定义文件名
 */
- (NSString *)newLogFileName
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat: @"yyyy'-'MM'-'dd'_'HH'-'mm'-'ss"];
    [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    NSString *title = @"行情数据";
    NSString *formattedDate = [df stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%@_%@.txt", title, formattedDate];
    
}
/**
 是否每个log文件都重写
 */
- (BOOL)isLogFile:(NSString *)fileName {
    
    return YES;
}

@end
