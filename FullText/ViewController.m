//
//  ViewController.m
//  FullText
//
//  Created by HaoSun on 16/9/29.
//  Copyright © 2016年 MaiTian. All rights reserved.
//

#import "ViewController.h"

#import "ListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.backgroundColor = [UIColor redColor];
    [openBtn setTitle:@"点击进入下一页" forState:UIControlStateNormal];
    [openBtn setFrame:CGRectMake(100, 100, 100, 100)];
    [openBtn addTarget:self action:@selector(openButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];
    
}


- (void)openButtonClick{

    ListViewController *list = [[ListViewController alloc] init];
    [self.navigationController pushViewController:list animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
