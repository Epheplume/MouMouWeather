//
//  TableViewCell.m
//  weather-3
//
//  Created by 王情嫒 on 15/11/1.
//  Copyright © 2015年 Jae. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIFont *font=[UIFont systemFontOfSize:14];
        
        self.days=[[UILabel alloc]initWithFrame:CGRectMake(22, 0, 80, 20)];
        self.days.textAlignment=UITextAlignmentLeft;
        self.days.font=font;
        [self.contentView addSubview:self.days];
        self.weather=[[UILabel alloc]initWithFrame:CGRectMake(50, 2, [UIScreen mainScreen].bounds.size.width-100, 20)];
        self.weather.textAlignment=UITextAlignmentCenter;
        self.weather.font=font;
        [self.contentView addSubview:self.weather];
        self.temp=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120, 2, 100, 20)];
        self.temp.textAlignment=UITextAlignmentRight;
        self.temp.font=font;
        [self.contentView addSubview:self.temp];
    }
    return self;
}

@end
