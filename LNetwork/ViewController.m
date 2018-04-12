//
//  ViewController.m
//  LNetwork
//
//  Created by idea on 2018/4/9.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "ViewController.h"
#import "Api.h"
#import "TabPageController.h"
#pragma mark - 请求事例
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(100, 150, 100, 50);
    lab.font = [UIFont systemFontOfSize:15];
    lab.text = @"点击屏幕";
    lab.textColor= [UIColor cyanColor];
    [self.view addSubview:lab];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Api * api1 =[[Api alloc] init:self tag:@"gethello"];
    [api1 gethello];
    
    Api * api2 =[[Api alloc] init:self tag:@"getList"];
    [api2 getList:@"1111111"];
    
    TabPageController *apv =[ [TabPageController alloc]init];
    [self presentViewController:apv animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 接口请求出错 sucess=1
-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    
    NSLog(@"tag:%@  message=%@",tag,message);
    
}
#pragma mark 接口请求成功 sucess=0
-(void)Sucess:(id)response tag:(NSString*)tag
{
    if([tag isEqualToString:@"getList"]){

        NSLog(@"👩🏻‍🎨@@@@@@!!!!%@",response);
    }
    else if ([tag isEqualToString:@"gethello"]){
        
        NSLog(@"👩🏻‍🎨@#########!%@",response);
    }
}

@end
