//
//  CityViewController.m
//  weather-3
//
//  Created by 王情嫒 on 15/10/29.
//  Copyright © 2015年 Jae. All rights reserved.
//

#import "CityViewController.h"
#import "ViewController.h"

@interface CityViewController ()

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *back=[UIButton buttonWithType:UIButtonTypeRoundedRect];
   // UIButton *back=[[UIButton alloc]init];
    back.frame=CGRectMake(1, 10, 50, 30);
    //[back buttonType:UIButtonTypeRoundedRect];
    //back.backgroundColor=[UIColor grayColor];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
   self. tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.view addSubview:self.tableView];
    
    seachBar=[[UISearchBar alloc]init];
    seachBar.frame=CGRectMake(0, 0, self.view.bounds.size.width, 0);
    seachBar.delegate=self;
    [seachBar sizeToFit];
    self.tableView.tableHeaderView=seachBar;
    
    dataCity=[[NSMutableArray alloc]initWithObjects:@"北京",@"上海",@"天津",@"重庆",@"哈尔滨",@"长春",@"沈阳",@"呼和浩特",@"石家庄",@"太原",@"西安",@"济南",@"乌鲁木齐",@"拉萨",@"西宁",@"兰州",@"银川",@"郑州",@"南京",@"武汉",@"杭州",@"合肥",@"福州",@"南昌",@"长沙",@"贵阳",@"成都",@"广州",@"昆明",@"南宁",@"海口",@"香港",@"澳门",@"台北",nil];
    dataBase=dataCity;
    
    
    // Do any additional setup after loading the view.
    
}

-(void)backViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataCity count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[dataCity objectAtIndex:indexPath.row];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cityName=[dataCity objectAtIndex:indexPath.row];
   // [self.delegate SetNewCityText:cityName];
    [self.delegate SetTheCityText:cityName];
    [self dismissViewControllerAnimated:YES completion:nil];
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
