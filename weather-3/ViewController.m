//
//  ViewController.m
//  weather-3
//
//  Created by 王情嫒 on 15/10/26.
//  Copyright © 2015年 Jae. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "CityViewController.h"
#import "TableViewCell.h"

@interface ViewController () <MyClassDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSDictionary *weatherResult;
}

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.code=@"101010100";
    [self getData];
    [self getFutureWeather];
    [self setModule];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)getData{
    
    NSString *url=[NSString stringWithFormat:@"http://api.k780.com:88/?app=weather.today&weaid=%@&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json",self.code];
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSLog(@"%@",url);
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
 
         NSError* error;

        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseObject
                              options:NSJSONReadingAllowFragments
                              error:&error];
        self.message = [json objectForKey:@"result"];
        
        NSLog(@"%@",self.message);
        [self reloadTodayData];
//        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
   
}


-(void) getFutureWeather{
    NSString *url=[NSString stringWithFormat:@"http://api.k780.com:88/?app=weather.future&weaid=%@&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json",self.code];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseObject
                              options:NSJSONReadingAllowFragments
                              error:&error];
        self.futuredata = [json objectForKey:@"result"];
        [self.tableView reloadData];
    
        NSLog(@"%@",self.futuredata);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

    
}



-(void)setModule{
    
    //weather today
    self.weather=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, 120, 20)];
    self.weather.text=[self.message objectForKey:@"weather"];
    self.weather.textColor=[UIColor blackColor];
    [self.weather setFont:[UIFont systemFontOfSize:23]];
    [self.view addSubview:self.weather];
    
    
    //png
    self.pngView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 0, 200, 200)];
    NSString *_weatext=[self setWeatherImg:self.weather.text];
    NSString *_wtext=[NSString stringWithFormat:@"%@_0",_weatext];
    self.weathImg=[UIImage imageNamed:_wtext];
    self.pngView.image=self.weathImg;
    [self.view addSubview:self.pngView];
    
    //tem
    float temY=CGRectGetMaxY(self.weather.frame)+5;
    self.temperature=[[UILabel alloc]initWithFrame:CGRectMake(20, temY, 120, 40)];
    self.temperature.text=[self.message objectForKey:@"temperature_curr"];
    self.temperature.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:self.temperature];
    
    //week
    float weekY=CGRectGetMaxY(self.temperature.frame)+30;
    self.week=[[UILabel alloc]initWithFrame:CGRectMake(22, weekY, 80, 20)];
    self.week.text=[self.message objectForKey:@"week"];
    self.week.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:self.week];
    //time
    self.days=[[UILabel alloc]initWithFrame:CGRectMake(72, weekY, 80, 20)];
    self.days.text=[self.message objectForKey:@"days"];
    self.days.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:self.days];
    //city
    self.city=[[UILabel alloc]initWithFrame:CGRectMake(160, weekY, 60, 20)];
    self.city.text=[self.message objectForKey:@"citynm"];
    self.city.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:self.city];
    //btn
    UIButton *cityBtn=[[UIButton alloc]init];
    cityBtn.frame=self.city.frame;
    cityBtn.alpha=0.2;
    [self.view addSubview:cityBtn];
    [cityBtn addTarget:self action:@selector(buttonDidPush) forControlEvents:UIControlEventTouchUpInside];
    
    //back image
    self.backImageView=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.backImg=[UIImage imageNamed:self.city.text];
    self.backImageView.alpha=0.3;
    self.backImageView.contentMode=UIViewContentModeScaleAspectFill;
    self.backImageView.image=self.backImg;
    [self.view addSubview:self.backImageView];
    
    
    //line
    float lineY=CGRectGetMaxY(self.week.frame);
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(20, lineY, [UIScreen mainScreen].bounds.size.width-40, 1)];
    line.backgroundColor=[UIColor whiteColor];
    line.alpha=0.35;
    [self.view addSubview:line];
    
    //wind
    float fengliY=CGRectGetMaxY(line.frame)+10;
    UIFont *font=[UIFont systemFontOfSize:12];
    float width=[UIScreen mainScreen].bounds.size.width/2-5;
    
    UILabel *wind=[[UILabel alloc]initWithFrame:CGRectMake(0, fengliY, width, 20)];
    wind.text=@"风向：";
    wind.textAlignment=UITextAlignmentRight;
    wind.font=font;
    [self.view addSubview:wind];
    
    self._wind=[[UILabel alloc]initWithFrame:CGRectMake(width+10, fengliY, width, 20)];
    self._wind.text=[self.message objectForKey:@"wind"];
    self._wind.textAlignment=UITextAlignmentLeft;
    self._wind.font=font;
    [self.view addSubview:self._wind];
    
    //winp
    float fengxiangY=CGRectGetMaxY(wind.frame);
    UILabel *winp=[[UILabel alloc]initWithFrame:CGRectMake(0, fengxiangY, width, 20)];
    winp.text=@"风力：";
    winp.textAlignment=UITextAlignmentRight;
    winp.font=font;
    [self.view addSubview:winp];
    
    self._winp=[[UILabel alloc]initWithFrame:CGRectMake(width+10, fengxiangY, width, 20)];
    self._winp.text=[self.message objectForKey:@"winp"];
   self. _winp.textAlignment=UITextAlignmentLeft;
    self._winp.font=font;
    [self.view addSubview:self._winp];
    
    //high temp
    float tempY=CGRectGetMaxY(winp.frame);
    UILabel *highTemp=[[UILabel alloc]initWithFrame:CGRectMake(0, tempY, width, 20)];
    highTemp.text=@"最高温：";
    highTemp.textAlignment=UITextAlignmentRight;
    highTemp.font=font;
    [self.view addSubview:highTemp];
    
    self._highTemp=[[UILabel alloc]initWithFrame:CGRectMake(width+10, tempY, width, 20)];
    self._highTemp.textAlignment=UITextAlignmentLeft;
    self._highTemp.text=[self.message objectForKey:@"temp_high"];
    self._highTemp.font=font;
    [self.view addSubview:self._highTemp];
    
    //low temp
    float lowTemY=CGRectGetMaxY(highTemp.frame);
    UILabel *lowTemp=[[UILabel alloc]initWithFrame:CGRectMake(0, lowTemY, width, 20)];
    lowTemp.text=@"最低温：";
    lowTemp.textAlignment=UITextAlignmentRight;
    lowTemp.font=font;
    [self.view addSubview:lowTemp];
    
    self._lowTemp=[[UILabel alloc]initWithFrame:CGRectMake(width+10, lowTemY, width, 20)];
    self._lowTemp.textAlignment=UITextAlignmentLeft;
    self._lowTemp.text=[self.message objectForKey:@"temp_low"];
    self._lowTemp.font=font;
    [self.view addSubview:self._lowTemp];
    
    //humi
    float humiY=CGRectGetMaxY(lowTemp.frame);
    UILabel *humi=[[UILabel alloc]initWithFrame:CGRectMake(0, humiY, width, 20)];
    humi.text=@"湿度：";
    humi.textAlignment=UITextAlignmentRight;
    humi.font=font;
    [self.view addSubview:humi];
    
    self._humi=[[UILabel alloc]initWithFrame:CGRectMake(width+10, humiY, width, 20)];
   self._humi.textAlignment=UITextAlignmentLeft;
    self._humi.text=[self.message objectForKey:@"humidity"];
    [self.view addSubview:self._humi];
    self._humi.font=font;
    
    //humi-high
    float higeHY=CGRectGetMaxY(humi.frame);
    UILabel *highHumi=[[UILabel alloc]initWithFrame:CGRectMake(0, higeHY, width, 20)];
    highHumi.text=@"最大湿度：";
    highHumi.textAlignment=UITextAlignmentRight;
    highHumi.font=font;
    [self.view addSubview:highHumi];
    
    self._highHumi=[[UILabel alloc]initWithFrame:CGRectMake(width+10, higeHY, width, 20)];
    self._highHumi.textAlignment=UITextAlignmentLeft;
    self._highHumi.text=[self.message objectForKey:@"humi_high"];
    self._highHumi.font=font;
    [self.view addSubview:self._highHumi];
    
    //low-humi
    float lowHY=CGRectGetMaxY(highHumi.frame);
    UILabel *lowHumi=[[UILabel alloc]initWithFrame:CGRectMake(0, lowHY, width, 20)];
    lowHumi.textAlignment=UITextAlignmentRight;
    lowHumi.text=@"最小湿度：";
    lowHumi.font=font;
    [self.view addSubview:lowHumi];
    
    self._lowHumi=[[UILabel alloc]initWithFrame:CGRectMake(width+10, lowHY, width, 20)];
    self._lowHumi.text=[self.message objectForKey:@"humi_low"];
    self._lowHumi.textAlignment=UITextAlignmentLeft;
    self._lowHumi.font=font;
    [self.view addSubview: self._lowHumi];
    
    
    //table view
    float tableY=CGRectGetMaxY(lowHumi.frame)+20;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, tableY, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-tableY)];
    self.tableView.alpha=0.5;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:0.8];
     [self.view addSubview:self.tableView];
}

-(void)buttonDidPush{
    CityViewController *viewCon=[[CityViewController alloc]init];
    //viewCon.delegate=self;
    viewCon.delegate=self;
    //viewCon.tableView.delegate=self;
    [self presentViewController:viewCon animated:YES completion:nil];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.futuredata count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=self.futuredata[indexPath.row];
    static NSString *CellIdentifier=@"Cell";
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.days.text=[dic objectForKey:@"days"];
    cell.weather.text=[dic objectForKey:@"weather"];
    cell.temp.text=[dic objectForKey:@"temperature"];

    return cell;
}



-(void)SetTheCityText:(NSString *)cityName{
    
    self.code=[self getCityNumbel:cityName];
    NSLog(@"%@",self.code);

    [self getData];
    [self getFutureWeather];
}


-(void)reloadTodayData{

    self.weather.text=[self.message objectForKey:@"weather"];
    NSString *text=self.weather.text;
    NSString *_weatext=[self setWeatherImg:text];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    NSString *str = [formatter stringFromDate:[NSDate date]];
    int time = [str intValue];
    if (time>=18||time<=06) {
        NSLog(@"晚上");
        self.imgNum= @"1";
    }
    else{
        NSLog(@"早上");
        self.imgNum= @"0";
    }
    
    NSString *_wtext=[NSString stringWithFormat:@"%@_%@",_weatext,self.imgNum];
    self.weathImg=[UIImage imageNamed:_wtext];
    self.pngView.image=self.weathImg;
    
    self.temperature.text=[self.message objectForKey:@"temperature_curr"];
    self.week.text=[self.message objectForKey:@"week"];
    self.days.text=[self.message objectForKey:@"days"];
    self.city.text=[self.message objectForKey:@"citynm"];
    
    self.backImg=[UIImage imageNamed:self.city.text];
    self.backImageView.image = self.backImg;
    
    self._wind.text=[self.message objectForKey:@"wind"];
    self._winp.text=[self.message objectForKey:@"winp"];
    self._highTemp.text=[self.message objectForKey:@"temp_high"];
    self._lowTemp.text=[self.message objectForKey:@"temp_low"];
    self._humi.text=[self.message objectForKey:@"humidity"];
    self._highHumi.text=[self.message objectForKey:@"humi_high"];
    self._lowHumi.text=[self.message objectForKey:@"humi_low"];
    
    
}


-(NSString *)setWeatherImg:(NSString *)weather{
    // 去空格
   NSString* weatherText = [weather stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([weatherText isEqualToString: @"暴雨"]) {
        return @"baoyu";
    }else if ([weatherText isEqualToString: @"冰雹"]){
        return @"bingbao";
    }else if ([weatherText isEqualToString: @"大雪"]){
        return @"daxue";
    }else if ([weatherText isEqualToString: @"大雨"]){
        return @"dayu";
    }else if ([weatherText isEqualToString: @"多云"]){
        return @"duoyun";
    }else if ([weatherText isEqualToString: @"浮尘"]){
        return @"fuchen";
    }else if ([weatherText isEqualToString: @"雷阵雨"]){
        return @"leizhenyu";
    }else if ([weatherText isEqualToString: @"霾"]){
        return @"mai";
    }else if ([weatherText isEqualToString: @"晴"]){
        return @"qing";
    }else if ([weatherText isEqualToString: @"霜冻"]){
        return @"shuangdong";
    }else if ([weatherText isEqualToString: @"雾"]){
        return @"wu";
    }else if ([weatherText isEqualToString: @"小雪"]){
        return @"xiaoxue";
    }else if ([weatherText isEqualToString: @"小雨"]){
        return  @"xiaoyu";
    }else if ([weatherText isEqualToString: @"扬沙"]){
        return @"yangsha";
    }else if ([weatherText isEqualToString: @"阴"]){
        return @"yin";
    }else if ([weatherText isEqualToString: @"雨夹雪"]){
        return @"yujiaxue";
    }else if ([weatherText isEqualToString: @"阵雨"]){
        return @"zhenyu";
    }else if ([weatherText isEqualToString: @"中雪"]){
        return @"zhongxue";
    }else if ([weatherText isEqualToString: @"中雨"]){
        return @"zhongyu";
    }else {
        return @"";
    }
    
}

-(NSString *)getCityNumbel:(NSString *)theCityName{
    if ([theCityName isEqualToString: @"北京"]) {
        return @"101010100";
    } else if([theCityName isEqualToString: @"上海"]){
        return @"101020100";
    } else if ([theCityName isEqualToString: @"天津"]){
        return @"101030100";
    } else if ([theCityName isEqualToString: @"重庆"]){
        return @"101040100";
    }else if ([theCityName isEqualToString: @"哈尔滨"]){
        return @"101050101";
    }else if ([theCityName isEqualToString: @"长春"]) {
        return @"101060101";
    }else if ([theCityName isEqualToString: @"沈阳"]){
        return @"101070101";
    }else if ([theCityName isEqualToString: @"呼和浩特"]){
        return @"101080101";
    }else if ([theCityName isEqualToString: @"石家庄"]) {
        return @"101090101";
    }else if ([theCityName isEqualToString: @"太原"]){
        return @"101100101";
    }else if ([theCityName isEqualToString: @"西安"]){
        return @"101110101";
    }else if ([theCityName isEqualToString: @"济南"]){
        return @"101120101";
    }else if ([theCityName isEqualToString: @"乌鲁木齐"]){
        return @"101130101";
    }else if ([theCityName isEqualToString: @"拉萨"]){
        return @"101140101";
    }else if ([theCityName isEqualToString: @"西宁"]){
        return @"101150101";
    }else if ([theCityName isEqualToString: @"兰州"]){
        return @"101160101";
    }else if ([theCityName isEqualToString: @"银川"]){
        return @"101170101";
    }else if ([theCityName isEqualToString: @"郑州"]){
        return @"101180101";
    }else if ([theCityName isEqualToString: @"南京"]){
        return @"101190101";
    }else if ([theCityName isEqualToString: @"武汉"]){
        return @"101200101";
    }else if ([theCityName isEqualToString: @"杭州"]){
        return @"101210101";
    }else if ([theCityName isEqualToString: @"合肥"]){
        return @"101220101";
    }else if ([theCityName isEqualToString: @"福州"]){
        return @"101230101";
    }else if ([theCityName isEqualToString: @"南昌"]){
        return @"101240101";
    }else if ([theCityName isEqualToString: @"长沙"]){
        return @"101250101";
    }else if ([theCityName isEqualToString: @"贵阳"]){
        return @"101260101";
    }else if ([theCityName isEqualToString: @"成都"]){
        return @"101270101";
    }else if ([theCityName isEqualToString: @"广州"]){
        return @"101280101";
    }else if ([theCityName isEqualToString: @"昆明"]){
        return @"101290101";
    }else if ([theCityName isEqualToString: @"南宁"]){
        return @"101300101";
    }else if ([theCityName isEqualToString: @"海口"]){
        return @"101310101";
    }else if ([theCityName isEqualToString: @"香港"]){
        return @"101320101";
    }else if ([theCityName isEqualToString: @"澳门"]){
        return @"101330101";
    }else if ([theCityName isEqualToString: @"台北"])
    {
        return @"101340101";
    }else{
    return @"";
    }
    
}


@end
