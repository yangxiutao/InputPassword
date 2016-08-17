/**
 ---------------------------------------------------------------------
 * 文件名：    PopMenu_CollectionView.h
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

#import <UIKit/UIKit.h>

@class PopMenu_CollectionView;

@protocol PopMenu_CollectionViewDelegate <NSObject>

- (void)popMenu_CollectionView:(PopMenu_CollectionView *)menu didSelectedItem:(id)item;

@end

@interface PopMenu_CollectionView : UIView

@property (nonatomic, weak) id<PopMenu_CollectionViewDelegate>delegate;

@property (nonatomic, strong) NSArray *collectionViewDataArray;

+ (instancetype)show;

//- (void)dismiss;

@end


@interface CollectionViewMaskView : UIView

@end