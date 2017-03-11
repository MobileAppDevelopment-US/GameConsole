//
//  ViewController.m
//  Game
//
//  Created by Serik Klement on 09.03.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSString *upButtonNamberLocation;
@property (strong, nonatomic) NSString *downButtonNamberLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:52.0/255 green:163.0/255 blue:70.0/255 alpha:1];
    [self createTextView];
    
    NSInteger count = 60;
    
    for (NSInteger i = 0; i < 2; i++) {
        
        UIButton *button = [self createButton];
        button.frame = CGRectMake(10, 300 + i * count, self.view.frame.size.width - 20, 50);
        button.tag = i + 2;
        [self.view addSubview:button];
        
        if (button.tag == 2) {
            
            [button addTarget:self
                       action:@selector(actionUpButtonTouchUpInside:) // верхняя кнопка отпускание
             forControlEvents:UIControlEventTouchUpInside];
            
            [button addTarget:self
                       action:@selector(actionUpButtonTouchDownInside:) // верхняя кнопка нажатие
             forControlEvents:UIControlEventTouchDown];
            
        } else {
            
            [button addTarget:self
                       action:@selector(actionDownButtonTouchUpInside:) // нижняя кнопка отпускание
             forControlEvents:UIControlEventTouchUpInside];
            
            [button addTarget:self
                       action:@selector(actionDownButtonTouchDownInside:) // нижняя кнопка нажатие
             forControlEvents:UIControlEventTouchDown];
            
        }
        
    }
    
    [self fromFileToString:@"1"];
    
}

- (UITextView*) createTextView {
    
    UITextView *textView = [[UITextView alloc] init];
textView.frame = CGRectMake(10, 20, self.view.frame.size.width - 20, 270);
    textView.backgroundColor = [UIColor orangeColor];
    textView.textColor = [UIColor whiteColor];
    textView.font = [UIFont systemFontOfSize:35];
    textView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textView];
    textView.layer.borderWidth = 3;
    textView.layer.borderColor = [[UIColor blackColor] CGColor];
    textView.tag = 1;
    
    return textView;
    
}

- (UIButton*) createButton {
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(10, 360, self.view.frame.size.width - 20, 50);
    button.layer.borderWidth = 2;
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:215.0/255 green:211.0/255 blue:213.0/255 alpha:1];
    button.titleLabel.font = [UIFont systemFontOfSize:40];

    return button;
}

#pragma mark - Action

- (void) actionUpButtonTouchUpInside:(UIButton*) upButton {

    [self fromFileToString:self.upButtonNamberLocation];
    upButton.backgroundColor = [UIColor colorWithRed:215.0/255 green:211.0/255 blue:213.0/255 alpha:1];

}

- (void) actionUpButtonTouchDownInside:(UIButton*) upButton {
    
    upButton.backgroundColor = [UIColor lightGrayColor];

    
    
}

- (void) actionDownButtonTouchUpInside:(UIButton*) downButton  {
 
    [self fromFileToString:self.downButtonNamberLocation];
    downButton.backgroundColor = [UIColor colorWithRed:215.0/255 green:211.0/255 blue:213.0/255 alpha:1];

}

- (void) actionDownButtonTouchDownInside:(UIButton*) downButton {
        
        downButton.backgroundColor = [UIColor lightGrayColor];
    
}

#pragma mark - Operation

- (void) fromFileToString:(NSString*) fileName {
    
    NSString *myPath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"txt"];
    NSString *myFile = [[NSString alloc]initWithContentsOfFile:myPath encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *array = [myFile componentsSeparatedByString:@"&"]; // делю строки по знаку
    
    UITextView *tempTextView = (UITextView*)[self.view viewWithTag:1];
    tempTextView.text = [array objectAtIndex:0]; // текст в окне
    
    NSArray *upArray = [[array objectAtIndex:1] componentsSeparatedByString:@"*"]; // делю 1. строку по знаку
    NSArray *downArray = [[array objectAtIndex:2] componentsSeparatedByString:@"*"]; // делю 2. строку по знаку
    
    UIButton *upButton = (UIButton*)[self.view viewWithTag:2];
    [upButton setTitle:[upArray objectAtIndex:0] forState:UIControlStateNormal]; // надпись на верхней кнопке
    
    UIButton *downButton = (UIButton*)[self.view viewWithTag:3];
    [downButton setTitle:[downArray objectAtIndex:0] forState:UIControlStateNormal]; // надпись на нижней кнопке
    
    self.upButtonNamberLocation = [upArray objectAtIndex:1]; // номер следующей страницы верхней кнопки
    self.downButtonNamberLocation = [downArray objectAtIndex:1]; // номер следующей страницы нижней кнопки
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
