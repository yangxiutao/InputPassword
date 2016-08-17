/**
 ---------------------------------------------------------------------
 * 文件名：    PopMenu_CollectionView.m
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

#import "PopMenu_CollectionView.h"
#import "PopMenuCell.h"

#define keyWindow [UIApplication sharedApplication].keyWindow
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#pragma mark -----------------分-----------------类----------------线-----------------
#pragma mark - CollectionViewMaskView

@interface CollectionViewMaskView ()

@end

@implementation CollectionViewMaskView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.alpha = 0.5;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (UIView *view in keyWindow.subviews) {
        
        if ([view isKindOfClass:[PopMenu_CollectionView class]] || [view isKindOfClass:[CollectionViewMaskView class]]) {
            [view removeFromSuperview];
        }
    }
}

@end

#pragma mark -----------------分-----------------类----------------线-----------------
#pragma mark - PopMenu_CollectionView

@interface PopMenu_CollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PopMenu_CollectionView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        [self addSubview:self.collectionView];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    
    return self;
}

+(instancetype)show{

    PopMenu_CollectionView *menu = [[PopMenu_CollectionView alloc]initWithFrame:CGRectMake(0, 0, kWidth - 40, kHeight * 2 / 3 + 40)];
    menu.center = keyWindow.center;
    [keyWindow addSubview:[[CollectionViewMaskView alloc] initWithFrame:keyWindow.bounds]];
    [keyWindow addSubview:menu];
    return menu;
}


#pragma mark -----------------分-----------------类----------------线-----------------
#pragma mark - UICollectionView

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 40, self.frame.size.width - 10, self.frame.size.height - 40) collectionViewLayout:flowLayout];
        [_collectionView registerClass:[PopMenuCell class] forCellWithReuseIdentifier:@"PopMenu_CollectionViewCell"];
        
        UIView *backView = [[UIView alloc]initWithFrame:_collectionView.frame ];
        backView.backgroundColor = [UIColor whiteColor];
        _collectionView.backgroundView = backView;
    }
    
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.collectionViewDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PopMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PopMenu_CollectionViewCell" forIndexPath:indexPath];
    
    if (self.collectionViewDataArray.count != 0) {
        
        NSDictionary *dic = [self.collectionViewDataArray objectAtIndex:indexPath.row];
        cell.imgURLString = [dic valueForKey:@"signImgURL"];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [self dismiss];
    
    id item = [self.collectionViewDataArray objectAtIndex:indexPath.row];
    if (self.delegate || [self.delegate respondsToSelector:@selector(popMenu_CollectionView:didSelectedItem:)]) {
        [self.delegate popMenu_CollectionView:self didSelectedItem:item];
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_IPHONE_5) {
        return CGSizeMake(120, 120);
        
    }else if (IS_IPHONE_6){
        return CGSizeMake(90, 90);
        
    }else if (IS_IPHONE_6P){
        return CGSizeMake(100, 100);
        
    }else if (IS_IPHONE_4_OR_LESS) {
        return CGSizeMake(70, 70);
        
    }else {
        return CGSizeMake(100, 100);
    }
    
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
   
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}



- (void)setCollectionViewDataArray:(NSArray *)collectionViewDataArray{
    
    _collectionViewDataArray = collectionViewDataArray;
    
    [self.collectionView reloadData];
}
#pragma mark -----------------分-----------------类----------------线-----------------
#pragma mark - PopMenu 消失

- (void)dismiss{
    
    for (UIView *view in keyWindow.subviews) {
        
        if ([view isKindOfClass:[PopMenu_CollectionView class]] || [view isKindOfClass:[CollectionViewMaskView class]]) {
            [view removeFromSuperview];
        }
    }
}


- (void)drawRect:(CGRect)rect{
    
    NSString *text = @"请选择签章";
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                NSForegroundColorAttributeName:[UIColor blackColor],
                                NSParagraphStyleAttributeName:style};
    [text drawInRect:CGRectMake(0, 10, self.frame.size.width, 30) withAttributes:attribute];
    
}
@end
