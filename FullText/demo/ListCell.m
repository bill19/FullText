//
//  ListCell.m
//  FullText
//
//  Created by HaoSun on 16/9/29.
//  Copyright © 2016年 MaiTian. All rights reserved.
//

#import "ListCell.h"
#import "Masonry.h"


#define TitleFont [UIFont systemFontOfSize:14]
#define ContentFont [UIFont systemFontOfSize:10]
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width*0.8
@interface ListCell()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) UIButton *isOpenButton;

@property (nonatomic, weak) UILabel *otherLabel;

@end

@implementation ListCell

+ (instancetype)listCell:(UITableView *)tableView{

    static NSString *ID = @"ListCell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];

    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubView];
        [self setupLayout];

    }
    return self;
}

/**
 *  设置ui
 */
- (void)setupSubView{

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 1;
    [titleLabel setFont:TitleFont];
    _titleLabel = titleLabel;
    [self.contentView addSubview:_titleLabel];

    UILabel *contentLabel = [[UILabel alloc] init];
    [contentLabel setFont:ContentFont];
    _contentLabel = contentLabel;
    [self.contentView addSubview:_contentLabel];

    UIButton *isOpenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [isOpenButton setTitle:@"全文" forState:UIControlStateNormal];
    [isOpenButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [isOpenButton addTarget:self action:@selector(openButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _isOpenButton = isOpenButton;
    [self.contentView addSubview:_isOpenButton];

    UILabel *otherLabel = [[UILabel alloc] init];
    [otherLabel setFont:ContentFont];
    _otherLabel = otherLabel;
    [self.contentView addSubview:_otherLabel];

}
/**
 *  布局
 */
- (void)setupLayout{

    CGFloat space = 5;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(1);
        make.left.mas_equalTo(self.contentView.mas_left).offset(1);
        make.width.offset(ScreenWidth);
    }];

    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(space);
        make.left.mas_equalTo(self.contentView.mas_left).offset(space);
        make.width.offset(ScreenWidth);
    }];

    [_isOpenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(space);
        make.left.mas_equalTo(self.contentView.mas_left).offset(space);
        make.width.offset(ScreenWidth);
    }];

    [_otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(_isOpenButton.mas_bottom).offset(space);
        make.left.mas_equalTo(self.contentView.mas_left).offset(space);
        make.width.offset(ScreenWidth);
    }];


}

/**
 *  buttonclick事件
 */
- (void)openButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(isOpenButtonClick:)]) {
        [self.delegate isOpenButtonClick:_model];
    }
}


/**
 *   set model
 *
 *  @param model <#model description#>
 */
- (void)setModel:(ListModel *)model{

    _model = model;
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    _otherLabel.text = model.other;



    if (model.isShow) {
        _isOpenButton.hidden = NO;
        [self updateIsOpenButton:14];
    }else{
        _isOpenButton.hidden = YES;
        [self updateIsOpenButton:1];
    }

    if (model.isOpen) {
        _contentLabel.numberOfLines = 0;
        [_isOpenButton setTitle:@"收起全文" forState:UIControlStateNormal];
        self.cellHeight = 100+[self stringToHeight:_otherLabel.text]+[self stringToHeight:_contentLabel.text];
    }else{

        _contentLabel.numberOfLines = 3;
        [_isOpenButton setTitle:@"全文" forState:UIControlStateNormal];
        self.cellHeight = 100+[self stringToHeight:_otherLabel.text]+[self stringToHeight:@"全文"]*3;
    }
}


//更新isopen的按钮高度
- (void)updateIsOpenButton:(CGFloat)height{

    CGFloat space = 5;
    [_isOpenButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(space);
        make.left.mas_equalTo(self.contentView.mas_left).offset(space);
        make.height.offset(height);
        make.width.offset(ScreenWidth);
    }];
}

- (CGFloat)stringToHeight:(NSString *)string{

    CGSize size = CGSizeMake(ScreenWidth, MAXFLOAT);
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ContentFont} context:nil].size.height;
    return height;
}

@end
