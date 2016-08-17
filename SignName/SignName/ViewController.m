//
//  ViewController.m
//  SignName
//
//  Created by 杨修涛 on 16/8/16.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "ViewController.h"

#import "InputPassword.h"
#import "PopMenu_CollectionView.h"
#import <UIImageView+WebCache.h>
#import "TouchIdManager.h"

@interface ViewController ()<UIAlertViewDelegate,InputPasswordDelegate,PopMenu_CollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *signImageView;

- (IBAction)selectedSignName:(UIBarButtonItem *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  选择签章前，弹出输入密码框
 *
 *  @param sender
 */
- (IBAction)selectedSignName:(UIBarButtonItem *)sender {
    
    [TouchIdManager authenticateUser];
    
    InputPassword *input = [InputPassword showWithCorrectPassword:@"q"];
    input.delegate = self;

}

- (void)inputPassword:(InputPassword *)inputPassword password:(NSString *)password{
    
        PopMenu_CollectionView *menu = [PopMenu_CollectionView show];
        menu.collectionViewDataArray = @[
  @{@"signId":@"1",@"signImgURL":@"http://img1.vbooking.net/inf/travel/0196/1958170b9c029d182b401795bdad3e468cbe8f.jpg"},
  @{@"signId":@"2",@"signImgURL":@"http://image.tianjimedia.com/uploadImages/2014/126/14/99DPC7722YXH_680x500.jpg"},
  @{@"signId":@"3",@"signImgURL":@"http://image.tianjimedia.com/uploadImages/2014/126/22/S6GV0A927Y51_680x500.jpg"},
  @{@"signId":@"4",@"signImgURL":@"http://image.tianjimedia.com/uploadImages/2014/126/17/32CUJ3W6X3B0_680x500.jpg"},
  @{@"signId":@"5",@"signImgURL":@"http://image.tianjimedia.com/uploadImages/2014/126/16/ZDW18D38HD0F_680x500.jpg"},
  @{@"signId":@"6",@"signImgURL":@"http://t1.27270.com/uploads/150613/7-150613113155J4.jpg"},
  @{@"signId":@"7",@"signImgURL":@"http://t1.27270.com/uploads/150609/7-1506091506401R.jpg"},
  @{@"signId":@"8",@"signImgURL":@"http://t1.27270.com/uploads/allimg/150616/7_06161630203W8.jpg"}];
        menu.delegate = self;
     
}

- (void)popMenu_CollectionView:(PopMenu_CollectionView *)menu didSelectedItem:(id)item{
    
    NSDictionary *dic = (NSDictionary *)item;
    NSString *imgURL = [dic valueForKey:@"signImgURL"];
    [self.signImageView sd_setImageWithURL:[NSURL URLWithString:imgURL]]; 
    
}
@end
