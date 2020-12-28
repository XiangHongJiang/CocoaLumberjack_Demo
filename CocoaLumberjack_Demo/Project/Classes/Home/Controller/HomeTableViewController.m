//
//  HomeTableViewController.m
//  CocoaLumberjack_Demo
//
//  Created by JXH on 2020/12/23.
//

#import "HomeTableViewController.h"
#import "ZDFileLoggerManager.h"

@interface HomeTableViewController ()

/** data*/
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.dataArray = [NSMutableArray arrayWithArray:@[@"Info",@"Warn",@"Error",@"添加数据",@"写文件",@"拷贝文件到临时文件夹",@"压缩文件",@"清除文件"]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HomeTableViewController"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"奔溃模拟" style:UIBarButtonItemStylePlain target:self action:@selector(crashTest)];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewController" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}
#pragma mark - -------------- tabelview Delegate -----------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            DDLogInfo(@"LogInfo → 输出Info日志");
            break;
        case 1:
            DDLogWarn(@"LogWarn → 输出Warn日志");
            break;
        case 2:
            DDLogError(@"LogError → 输出Error日志");
            break;
        case 3:
        {
            [self.dataArray addObject:[NSString stringWithFormat:@"%ld",self.dataArray.count + 1]];
            [self.tableView reloadData];
        }
            break;
        case 4:
        {
            [self savaStr];
        }
            break;
        case 5:
        {
            [self copyLogs];
        }
            break;
        case 6:
            [self archiverFile];
            break;
        case 7:
            [self cleanTmpItem];
            break;
        default:
            break;
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    DDLogInfo(@"scrollViewDidScroll: %ld",scrollView.contentOffset.y);
//    [self savaStr];
}
#pragma mark - -------------- custom Method -----------------
- (void)crashTest {
   
    NSMutableArray *mA = @[];
    [mA addObject:@1];
}
- (void)savaStr  {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@".txt"];
    NSString *dataStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    DDLogInfo(@"%@",dataStr);
}

- (void)copyLogs {
    
   NSArray *logsNameA = [ZDFileLoggerManager copyLogsItemToTmpDirectory];
    DDLogInfo(@"%@",logsNameA);
    
}
- (void)archiverFile {
    
    NSString *filePath =  [ZDFileLoggerManager archiveLogsToZipWithPath:nil andFileNames:nil];
    DDLogInfo(@"压缩文件路径：%@",filePath);
}
- (void)cleanTmpItem {
    [ZDFileLoggerManager cleanTmpItem];
}


@end
