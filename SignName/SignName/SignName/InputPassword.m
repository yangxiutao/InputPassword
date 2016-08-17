/**
 ---------------------------------------------------------------------
 * 文件名：    InputPassword.m
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

#import "InputPassword.h"

#define keyWindow [UIApplication sharedApplication].keyWindow
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


#pragma mark -----------------分-----------------类----------------线-----------------
#pragma mark - MaskView

@interface MaskView ()

@end

@implementation MaskView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.alpha = 0.5;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (UIView *view in keyWindow.subviews) {
        
        if ([view isKindOfClass:[InputPassword class]] || [view isKindOfClass:[MaskView class]]) {
            [view removeFromSuperview];
        }
    }
}

@end

#pragma mark -----------------分-----------------类----------------线-----------------
#pragma mark - InputPassword

@interface InputPassword ()

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) NSString *correctPassword;

@property (nonatomic, strong) UIButton *cancleBtn;

@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation InputPassword


//输入密码
- (UITextField *)passwordTextField{
    
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 35, self.frame.size.width - 20, 40)];
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    
    return _passwordTextField;
}

//取消按钮
- (UIButton *)cancleBtn{
    
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        _cancleBtn.frame = CGRectMake(0, 90, self.frame.size.width/2, self.frame.size.height - 90);
        [_cancleBtn setTitle:@"取    消" forState:(UIControlStateNormal)];
        _cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _cancleBtn;
}

//确定按钮
- (UIButton *)sureBtn{
    
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        _sureBtn.frame = CGRectMake(self.frame.size.width/2, 90, self.frame.size.width/2, self.frame.size.height - 90);
        [_sureBtn setTitle:@"确    定" forState:(UIControlStateNormal)];
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
         [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _sureBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        [self.passwordTextField becomeFirstResponder];
        [self addSubview:self.passwordTextField];
        [self addSubview:self.cancleBtn];
        [self addSubview:self.sureBtn];
    }
    
    return self;
}


#pragma mark -----------------分-----------------类----------------线-----------------
#pragma mark - 弹出 输入密码 框

+ (instancetype)showWithCorrectPassword:(NSString *)password{
    
    InputPassword *inputPassword = [[self alloc]initWithFrame:CGRectMake(0, 0, kWidth - 40, 150)];
    inputPassword.center = CGPointMake(keyWindow.center.x, keyWindow.center.y - 30);
    inputPassword.correctPassword = password;
    [keyWindow addSubview:[[MaskView alloc] initWithFrame:keyWindow.frame]];
    [keyWindow addSubview:inputPassword];
    return inputPassword;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //1.  text
     NSString *text = @"请输入密码";
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                NSForegroundColorAttributeName:[UIColor blackColor],
                                NSParagraphStyleAttributeName:style};
    [text drawInRect:CGRectMake(0, 10, self.frame.size.width, 30) withAttributes:attribute];
    
    //2.line1
    CGPoint aPoint[2];
    aPoint[0] = CGPointMake(0, 90);
    aPoint[1] = CGPointMake(self.frame.size.width, 90);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 0.3);
    CGContextAddLines(ctx, aPoint, 2);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //3. line2
    CGPoint bPoint[2];
    bPoint[0] = CGPointMake(self.frame.size.width/2, 90);
    bPoint[1] = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    CGContextRef ctx1 = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx1, 0.3);
    CGContextAddLines(ctx1, bPoint, 2);
    CGContextDrawPath(ctx1, kCGPathStroke);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.passwordTextField resignFirstResponder];
}


#pragma mark -----------------分-----------------类----------------线-----------------
#pragma mark - 输入密码框消失

- (void)dismiss{
    
    for (UIView *view in keyWindow.subviews) {
        
        if ([view isKindOfClass:[InputPassword class]] || [view isKindOfClass:[MaskView class]]) {
            [view removeFromSuperview];
        }
    }
}


#pragma mark -----------------分-----------------类----------------线-----------------
#pragma mark - 属性设置

//正确密码
- (void)setCorrectPassword:(NSString *)correctPassword{
    _correctPassword = correctPassword;
}


#pragma mark -----------------分-----------------类----------------线-----------------
#pragma mark - 按 钮 响 应 事 件

/**
 *  确定按钮响应事件
 */
- (void)sureBtnAction{
    
    if ([self.correctPassword isEqualToString:self.passwordTextField.text]) {
        [self dismiss];
        if (self.delegate || [self.delegate respondsToSelector:@selector(inputPassword:password:)]) {
            [self.delegate inputPassword:self password:self.passwordTextField.text];
        }
    }else{
        [self animateIncorrectPassword];
    }
    
    
}

/**
 *  取消按钮响应事件
 */
- (void)cancleBtnAction{
    
    [self dismiss];
}

/**
 *  View 左右晃动
 */
- (void)animateIncorrectPassword {
    // Clear the password field
    self.passwordTextField.text = nil;
    
    // Animate the alert to show that the entered string was wrong
    // "Shakes" similar to OS X login screen
    CGAffineTransform moveRight = CGAffineTransformTranslate(CGAffineTransformIdentity, 10, 0);
    CGAffineTransform moveLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -10, 0);
    CGAffineTransform resetTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
    
    [UIView animateWithDuration:0.01 animations:^{
        // Translate left
        self.transform = moveLeft;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.01 animations:^{
            
            // Translate right
            self.transform = moveRight;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.01 animations:^{
                
                // Translate left
                self.transform = moveLeft;
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.01 animations:^{
                    
                    // Translate to origin
                    self.transform = resetTransform;
                }];
            }];
            
        }];
    }];
}

@end
