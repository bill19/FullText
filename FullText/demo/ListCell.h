//
//  ListCell.h
//  FullText
//
//  Created by HaoSun on 16/9/29.
//  Copyright © 2016年 MaiTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@protocol ListCellDelegate <NSObject>

- (void)isOpenButtonClick:(ListModel *)model;

@end

@interface ListCell : UITableViewCell

+ (instancetype)listCell:(UITableView *)tableView;

@property (nonatomic, strong) ListModel *model;

@property (nonatomic, assign) id<ListCellDelegate> delegate;

@property (nonatomic, assign) CGFloat cellHeight;

@end
