//
//  ZDFileLoggerManager.m
//  TestLogDemoOriginal
//
//  Created by JXH on 2020/12/25.
//

#import "ZDFileLoggerManager.h"
#import "ZDFileLogger.h"
#import "ZipArchive.h"

@implementation ZDFileLoggerManager

+ (void)start {
    //添加：控制台日志
//    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    //添加：文件日志
    ZDFileLogger *fileLogger = [ZDFileLogger loggerWithCustomLogFileManager];
    [DDLog addLogger:fileLogger];
    NSLog(@"%@",CACHE_PATH);
}

#pragma mark - -------------- custom method -----------------
//把log文件拷贝到临时文件，返回文件名
+ (NSArray <NSString *> *)copyLogsItemToTmpDirectory {
    
    //清除原先的数据
    [self cleanTmpItem];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSError *error;
    //获取Logs文件名
    NSMutableArray *fileNamesArr = [[NSMutableArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:Logs_Path error:nil]];
    [fileNamesArr removeObject:@".DS_Store"];
    
    //有文件
    if (fileNamesArr.count) {
        //copy 文件
        BOOL copySucceed = [fileManager copyItemAtPath:Logs_Path toPath:Logs_Tmp_Path error:&error];
        
        if (copySucceed) {
            NSLog(@"拷贝文件成功");
        }else {
            NSLog(@"%@",error.description);
        }
    }else {
        return nil;
    }
    
    return fileNamesArr;
    
}

//不传默认压缩 tmp 文件夹下除.zip的文件，到 tmp文件夹。 返回压缩后的文件路径。
+ (NSString *)archiveLogsToZipWithPath:(NSString * __nullable)filesPath andFileNames:(NSArray *__nullable)fileNamesArray {

    NSFileManager * fileManager = [NSFileManager defaultManager];
    //文件路径
    NSString *logsPath = nil;
    if (filesPath != nil && filesPath.length) {
        logsPath = filesPath;
    }else {
        logsPath = Logs_Tmp_Path;
    }
    
    //获取log文件名
    NSMutableArray *zipFilesName = [NSMutableArray array];
    NSArray *fileNamesArr = [fileManager contentsOfDirectoryAtPath:logsPath error:nil];
    [fileNamesArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //如果传了文件名，只压缩传进来的文件名的文件
        if (fileNamesArray.count) {
            
            if ( [fileNamesArray containsObject:obj]) {
                [zipFilesName addObject:obj];
            }

        }else {
            if (![obj hasSuffix:@".zip"] && ![obj isEqualToString:@".DS_Store"]) {
                [zipFilesName addObject:obj];
            }
        }
        

    }];
    
    NSString *logZipPath = nil;
    
    if (zipFilesName.count) {
        //zip文件名
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"yyyy'-'MM'-'dd'_'HH'-'mm'-'ss"];
        [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        NSString *formattedDate = [df stringFromDate:[NSDate date]];
        //zip文件路径
        logZipPath = [NSString stringWithFormat:@"%@/行情数据_%@.zip",Logs_Tmp_Path, formattedDate];
        
        //创建zip文件
        ZipArchive *logZip = [[ZipArchive alloc] init];
        
        if ([logZip CreateZipFile2:logZipPath]) {
            DDLogDebug(@"创建zip成功");
            //添加log文件
            [zipFilesName enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                //添加非zip文件到 tmp文件
                //使用log本身的名字命名
                [logZip addFileToZip:[logsPath stringByAppendingString:[NSString stringWithFormat:@"/%@", obj]] newname:obj];
                
            }];
        }else{
            DDLogDebug(@"创建zip失败");
            [logZip CloseZipFile2];
            //返回为空
        }
        //关闭
        [logZip CloseZipFile2];
        
    }else {
        return nil;
    }
    
    return logZipPath;
}

//清理临时文件夹下的所有文件
+ (BOOL)cleanTmpItem {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *logsTmpPath = Logs_Tmp_Path;
    return [fileManager removeItemAtPath:logsTmpPath error:nil];
}

@end
