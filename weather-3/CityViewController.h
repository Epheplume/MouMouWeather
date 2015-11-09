//
//  CityViewController.h
//  weather-3
//
//  Created by 王情嫒 on 15/10/29.
//  Copyright © 2015年 Jae. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyClassDelegate;

@interface CityViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

{
@protected
    UISearchBar *seachBar;
    NSMutableArray *dataBase;
    NSMutableArray *dataCity;
    
   // UITableView *tableView;
}

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic,strong) id <MyClassDelegate>delegate;

@end
