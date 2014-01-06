//
//  ViewController.m
//  UpDownTest
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>{
    int answer;
    int maximumTrial;
    int trial;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;

- (IBAction)checkInput:(id)sender;
- (IBAction)newGame:(id)sender;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.userInput becomeFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self newGame:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self checkInput:nil];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == alertView.firstOtherButtonIndex){
        [self newGame:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkInput:(id)sender {
    int inputVal = [self.userInput.text intValue];
    self.userInput.text = @"";
    
    if (answer == inputVal) {
        self.label.text = @"정답입니다";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"정답" message:@"다시 게임하겠습니까?" delegate:self cancelButtonTitle:@"취소"otherButtonTitles:@"확인", nil];
        alert.tag = 11;
        [alert show];
    }
    else{
        trial++;
        if(trial >= maximumTrial){
            NSString *msg = [NSString stringWithFormat:@"답은 %d입니다.", answer];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"실패" message:msg delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
            alert.tag = 12;
            [alert show];
        }else{
            if (answer > inputVal) {
                self.label.text = @"down";
            }else{
                self.label.text = @"up";
            }
            self.countLabel.text = [NSString stringWithFormat:@"%d/%d", trial, maximumTrial];
            self.progress.progress = trial/(float)maximumTrial;
        }
    }
    
}

- (IBAction)newGame:(id)sender {
    int selectedGame = self.gameSelector.selectedSegmentIndex;
    int maximumRandom = 0;
    if(0 == selectedGame){
        maximumTrial = 5;
        maximumRandom = 10;
    }
    else if (1 == selectedGame){
        maximumTrial = 10;
        maximumRandom = 50;
    }
    else{
        maximumTrial = 20;
        maximumRandom = 100;
    }
    answer = random() % maximumRandom +1;
    trial = 0;
    self.progress.progress = 0.0;
    self.countLabel.text = @"";
    self.label.text = @"";
    
    NSLog(@"New Game with answer : %d", answer);
}
@end
