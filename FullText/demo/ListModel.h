//
//  ListModel.h
//  FullText
//
//  Created by HaoSun on 16/9/29.
//  Copyright © 2016年 MaiTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

//标题
@property (nonatomic, copy) NSString *title;
//内容
@property (nonatomic, copy) NSString *content;
//是否展开 1为展开 0 为不展开
@property (nonatomic, assign) BOOL isOpen;
//是否展示  1为展示 0 为隐藏
@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, copy) NSString *other;

@end
