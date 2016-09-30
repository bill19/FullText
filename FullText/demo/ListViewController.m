//
//  ListViewController.m
//  FullText
//
//  Created by HaoSun on 16/9/29.
//  Copyright © 2016年 MaiTian. All rights reserved.
//

#import "ListViewController.h"
#import "ListCell.h"
#import "ListModel.h"


#define TitleFont [UIFont systemFontOfSize:14]
#define ContentFont [UIFont systemFontOfSize:10]
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width*0.8

@interface ListViewController ()<UITableViewDelegate, UITableViewDataSource, ListCellDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点击展开全文";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
    [self requestdataSource];
    // Do any additional setup after loading the view.
}

/**
 *  数据源－－直接换成你的网络请求
 */
- (void)requestdataSource{

    for (int i = 0; i < 20; i++) {
        ListModel *model = [[ListModel alloc] init];
        model.title = @"你好";
        model.content = [NSString stringWithFormat:@"凉风有幸秋月无边///.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边//.凉风有幸秋月无边."];

//大于3行展示全文按钮。可以折叠  小于3行不展示按钮
        if ([self stringToHeight:model.content] < [self stringToHeight:@"凉风"]*3) {
            model.isShow = NO;
        }else{
            model.isShow = YES;
        }
        model.isOpen = NO;
        model.other = [NSString stringWithFormat:@"无边落木萧萧下."];
        [self.dataSource addObject:model];
    }

}

/**
 *  设置tableview
 */
- (void)setupTableView{

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    [self.view addSubview:_tableView];

}

/**
 *  数据源方法
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ListCell *cell = [ListCell listCell:tableView];
    cell.model = _dataSource[indexPath.row];
    cell.delegate = self;
    self.cellHeight = cell.cellHeight;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ListCell *cell = [ListCell listCell:tableView];
    cell.model = _dataSource[indexPath.row];
    return cell.cellHeight;

}


/**
 *  计算下需要的高度-可以抽取出来一个类
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)stringToHeight:(NSString *)string{

    CGSize size = CGSizeMake(ScreenWidth, MAXFLOAT);
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ContentFont} context:nil].size.height;
    return height;
}


/**
 *  代理方法
 *
 *  @param model <#model description#>
 */
- (void)isOpenButtonClick:(ListModel *)model{

    model.isOpen = !model.isOpen;
    NSInteger index = [self.dataSource indexOfObject:model];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
