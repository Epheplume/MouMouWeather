//
//  ViewController.h
//  weather-3
//
//  Created by 王情嫒 on 15/10/26.
//  Copyright © 2015年 Jae. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyClassDelegate <NSObject>

- (void) SetTheCityText: (NSString *)cityName;

@end


@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSString * imgNum;

@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIImageView *pngView;

@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSMutableArray *futuredata;
@property (nonatomic,strong) NSDictionary *message;
@property (nonatomic,strong) UIButton *cityBtn;
@property (nonatomic,strong) UILabel *city;

@property (nonatomic,strong) UIImage *backImg;
@property (nonatomic,strong) UILabel *weather;
@property (nonatomic,strong) UILabel *temperature;
@property (nonatomic,strong) UIImage *weathImg;

@property (nonatomic,strong) UILabel *week;
@property (nonatomic,strong) UILabel *days;

@property (nonatomic,strong) UILabel *_wind;
@property (nonatomic,strong) UILabel *_winp;
@property (nonatomic,strong) UILabel *_highTemp;
@property (nonatomic,strong) UILabel *_lowTemp;
@property (nonatomic,strong) UILabel *_humi;
@property (nonatomic,strong) UILabel *_highHumi;
@property (nonatomic,strong) UILabel *_lowHumi;


@property (nonatomic,strong) UITableView *tableView;

@end

