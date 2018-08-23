//
//  BlueToothViewController.m
//  Demo
//
//  Created by hztuen on 2017/7/10.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "BlueToothViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BlueToothViewController () <UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate, CBPeripheralDelegate, CBPeripheralManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CBCentralManager *centerManager;//中心管理者
@property (nonatomic, strong) CBPeripheral *peripheral;//连接到的外部设备
@property (nonatomic, strong) NSMutableArray *peripheralArrs;//外设数组
@property (nonatomic, strong) NSMutableArray *peripheralNameArrs;//外设名字数组
@property (nonatomic, strong) CBCharacteristic *characteristic;


@end

@implementation BlueToothViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self buildUI];
}

- (void)initData {
    self.title = @"蓝牙";

    self.peripheralArrs = [NSMutableArray new];
    self.peripheralNameArrs = [NSMutableArray new];
    
    self.centerManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
}

- (void)buildUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
//    UIBarButtonItem *scanBtn = [[UIBarButtonItem alloc] initWithTitle:@"写入数据" style:UIBarButtonItemStylePlain target:self action:@selector(clickScanButton)];
//    self.navigationItem.rightBarButtonItem = scanBtn;
}

//将16进制的字符串转换成NSData
- (NSMutableData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] %2 == 0) {
        range = NSMakeRange(0,2);
    } else {
        range = NSMakeRange(0,1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}

- (NSData *)dataFromHexString:(NSString *)string
{
    NSLog(@"string = %@", string);
    string = [string lowercaseString];
    NSMutableData *data= [NSMutableData new];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i = 0;
    long length = string.length;
    while (i < length-1) {
        char c = [string characterAtIndex:i++];
        if (c < '0' || (c > '9' && c < 'a') || c > 'f')
            continue;
        byte_chars[0] = c;
        byte_chars[1] = [string characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}

- (NSData*)hexToBytes:(NSString *)str {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

//点击写入按钮
- (void)clickScanButton {
    
    NSString *str = @"0x02";
//    NSData *data = [self convertHexStrToData:str];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.peripheralArrs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    cell.textLabel.text = [self.peripheralNameArrs objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.centerManager connectPeripheral:[self.peripheralArrs objectAtIndex:indexPath.row] options:nil];
}

#pragma mark - BlueTooth

//只要中心管理者初始化 就会触发此代理方法 判断手机蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case 0:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
        case 1:
            NSLog(@"CBCentralManagerStateResetting");
            break;
        case 2:
            NSLog(@"CBCentralManagerStateUnsupported");//不支持蓝牙
            break;
        case 3:
            NSLog(@"CBCentralManagerStateUnauthorized");
            break;
        case 4:
        {
            NSLog(@"CBCentralManagerStatePoweredOff");//蓝牙未开启
        }
            break;
        case 5:
        {
            NSLog(@"CBCentralManagerStatePoweredOn");//蓝牙已开启
            [self.peripheralArrs removeAllObjects];
            [self.peripheralNameArrs removeAllObjects];
            [self.centerManager scanForPeripheralsWithServices:nil options:nil];//搜索外设
        }
            break;
        default:
            break;
    }
}

// 发现外设后调用的方法
- (void)centralManager:(CBCentralManager *)central // 中心管理者
 didDiscoverPeripheral:(CBPeripheral *)peripheral // 外设
     advertisementData:(NSDictionary *)advertisementData // 外设携带的数据
                  RSSI:(NSNumber *)RSSI // 外设发出的蓝牙信号强度
{
//    NSString *deviceName = [NSString stringWithFormat:@"%@",[advertisementData objectForKey:@"kCBAdvDataLocalName"]];
//    if (![deviceName isEqualToString:@"(null)"] && ![deviceName isKindOfClass:[NSNull class]] && deviceName.length != 0) {
//        NSLog(@"发现外设 ====== cetral = %@,peripheral = %@, advertisementData = %@, RSSI = %@", central, peripheral, advertisementData, RSSI);
//        self.peripheral = peripheral;
//        [self.peripheralArrs addObject:peripheral];
//        [self.peripheralNameArrs addObject:deviceName];
//    }
    
    if ([peripheral.name hasPrefix:@"SEVEN"]) {
        NSLog(@"发现外设 ====== cetral = %@,peripheral = %@, advertisementData = %@, RSSI = %@", central, peripheral, advertisementData, RSSI);
        self.peripheral = peripheral;
        [self.peripheralArrs addObject:peripheral];
        [self.peripheralNameArrs addObject:peripheral.name];
    }
    
    [self.tableView reloadData];
}

// 连接外设
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    // 连接成功之后,可以进行服务和特征的发现
    NSLog(@"连接外设成功: %@", peripheral);
    self.peripheral.delegate = self;
    [self.centerManager stopScan];
    //外设发现服务，传nil表示不过滤
    [peripheral discoverServices:nil];
    
}

// 连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接外设失败: %@, error: %@", peripheral, error);
}

// 丢失连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"%@=断开连接", peripheral.name);
}

// 发现服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    //服务并不是我们的目标，也没有实际意义。我们需要用的是服务下的特征，查询（每一个服务下的若干）特征
    for (CBService *service in peripheral.services)
    {
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

// 发现外设服务里的特征的时候调用的代理方法(这个是比较重要的方法，你在这里可以通过事先知道UUID找到你需要的特征，订阅特征，或者这里写入数据给特征也可以)
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *characteristic in service.characteristics) {
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE9"]]) //write
        {
            NSLog(@"外设发现服务1 = %@", service);
            NSLog(@"服务特征1 = %@", characteristic);
            self.peripheral = peripheral;
            self.characteristic = characteristic;
            NSString *str = @"0C010300000193FC";
            NSData *data = [self hexToBytes:str];
            NSLog(@"data = %@", data);
            [self.peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        }
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE4"]]) //notify
        {
            NSLog(@"外设发现服务2 = %@", service);
            NSLog(@"服务特征2 = %@", characteristic);
            self.peripheral = peripheral;
            self.characteristic = characteristic;
            [self.peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

// 更新特征的value的时候会调用 （凡是从蓝牙传过来的数据都要经过这个回调，简单的说这个方法就是你拿数据的唯一方法）
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"读取数据错误信息 = %@", error);
    } else {
        NSLog(@"读取数据成功");
        NSData *data = characteristic.value;
        Byte * resultByte = (Byte *)[data bytes];
        NSLog(@"读取数据字节 %s", resultByte);
    }

}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    if (error) {
        NSLog(@"通知错误信息 = %@", error);
    } else {
        NSLog(@"通知成功");
        NSLog(@"通知数据 = %@", characteristic);
        self.peripheral = peripheral;
        [self.peripheral readValueForCharacteristic:characteristic];
    }
    
}

//写入数据
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    if (error) {
        NSLog(@"写入错误信息 = %@", error);
    } else {
        NSLog(@"写入成功");
        NSLog(@"写入数据 = %@", characteristic);
        self.peripheral = peripheral;
        [self.peripheral readValueForCharacteristic:characteristic];
    }
    
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
