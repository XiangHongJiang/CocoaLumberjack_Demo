//
//  LogHeader_Pch.h
//  CocoaLumberjack_Demo
//
//  Created by JXH on 2020/12/28.
//

#ifndef LogHeader_Pch_h
#define LogHeader_Pch_h


/** 日志记录*/
#import <DDLog.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;//收集所有
#else
static const DDLogLevel ddLogLevel = DDLogLevelInfo;//收集 Error、Waring、Info
#endif

//缓冲目录
#define CACHE_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject
//logs 文件目录
#define Logs_Path [NSString stringWithFormat:@"%@/Logs", CACHE_PATH]
//logs处理 临时文件目录
#define Logs_Tmp_Path [NSString stringWithFormat:@"%@/LogsTmp", CACHE_PATH]


#endif /* LogHeader_Pch_h */
