//
//  DownLoadZipViewController.m
//  Demo
//
//  Created by hztuen on 2017/6/5.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "DownLoadZipViewController.h"
#import "SSZipArchive.h"

@interface DownLoadZipViewController ()

@property (nonatomic, strong) NSString *dataPath;//下载完的zip包路径
@property (nonatomic, strong) NSString *unzipPath;//解压路径
@property (nonatomic, strong) NSString *unzipDataPath;//解压完文件路径
@property (nonatomic, strong) NSString *htmlFileName;//html名

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation DownLoadZipViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:self.unzipDataPath error:nil];
    if (isSuccess) {
        NSLog(@"delete success");
    }else{
        NSLog(@"delete fail");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
}

- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"文件下载";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, 84, 100, 40)];
    [button setTitle:@"开始下载" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickStartBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, 134, 100, 40)];
    [button2 setTitle:@"开始解压" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor grayColor];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clickUnarchiveBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, 184, 100, 40)];
    [button3 setTitle:@"读取数据" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor grayColor];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(clickReadDataBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 234, ScreenWidth, ScreenHeight-234)];
    [self.view addSubview:self.webView];
    

}

//下载
- (void)clickStartBtn {
    //下载，保存到沙盒
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    dispatch_async(queue, ^{
        
        NSLog(@"开始下载");
        NSString *stringURL = @"https://github.com/Cesaradu/ExampleAppDemo/archive/master.zip";
        NSURL  *url = [NSURL URLWithString:stringURL];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        
        NSLog(@"下载完成");
        NSString *path = [self getSavePath];
        
        NSLog(@"保存");
        self.dataPath = [path stringByAppendingPathComponent:@"demo.zip"];
        self.dataPath = [self.dataPath stringByStandardizingPath];
        NSLog(@"下载路径 = %@", self.dataPath);
        [urlData writeToFile:self.dataPath atomically:YES];
        
        [self showSuccessView:@"下载完成"];
        
    });

}

//解压
- (void)clickUnarchiveBtn {
    //解压
    self.unzipPath = [self getUnzipPath];
    NSLog(@"解压路径 = %@", self.unzipPath);
    BOOL success = [SSZipArchive unzipFileAtPath:self.dataPath toDestination:self.unzipPath];
    if (success) {
        NSLog(@"解压成功");
        BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:self.dataPath error:nil];
        if (isSuccess) {
            NSLog(@"delete success");
        }else{
            NSLog(@"delete fail");
        }
        
        [self showSuccessView:@"解压完成"];
    }
}

//读取数据
- (void)clickReadDataBtn {
    
    NSMutableArray<NSString *> *items = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.unzipPath error:nil] mutableCopy];
    NSLog(@"items = %@", items);
    if ([items containsObject:@".DS_Store"]) {
        [items removeObject:@".DS_Store"];
    }
    [items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0: {
                //解压完文件夹路径
                self.unzipDataPath = [self.unzipPath stringByAppendingPathComponent:obj];
                NSLog(@"unzipDataPath = %@", self.unzipDataPath);
                //解压完文件夹里的文件数组（名字）
                NSArray *fileNameList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.unzipDataPath error:nil];
                NSLog(@"读取的数据 = %@",fileNameList);
                [self loadWebViewWithHtmlName:fileNameList[0]];
            
                break;
            }
            default: {
                NSLog(@"Went beyond index of assumed files");
                break;
            }
        }
    }];
}

- (void)loadWebViewWithHtmlName:(NSString *)htmlName {
    //html文件路径
    NSString *htmlPath = [self.unzipDataPath stringByAppendingPathComponent:htmlName];
    //htmlString
    NSString *htmlstring = [[NSString alloc] initWithContentsOfFile:htmlPath  encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlstring baseURL:[NSURL URLWithString:htmlPath]];
}

//保存路径
- (NSString *)getSavePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths  objectAtIndex:0];
    return path;
}

//解压路径
- (NSString *)getUnzipPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths  objectAtIndex:0];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        return nil;
    }
    return url.path;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
