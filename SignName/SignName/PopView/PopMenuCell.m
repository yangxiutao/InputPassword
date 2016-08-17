/**
 ---------------------------------------------------------------------
 * 文件名：    PopMenuCell.m
 * 工程名：    SignName
 * 创建者：    Created by YXT on 16/8/16.
 * 所有者：    Copyright © 2016年 YXT. All rights reserved.
 *
 ---------------------------------------------------------------------
 * Date  : 16/8/16
 * Author: YXT
 * Notes :
 *
 ---------------------------------------------------------------------
 */

#import "PopMenuCell.h"
#import <UIImageView+WebCache.h>

@interface PopMenuCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation PopMenuCell

- (UIImageView *)imgView{
    
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    
    return _imgView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        [self addSubview:self.imgView];
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (void)setImgURLString:(NSString *)imgURLString{
    _imgURLString = imgURLString;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgURLString]];
}
@end
