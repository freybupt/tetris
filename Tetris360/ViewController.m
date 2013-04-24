//
//  ViewController.m
//  Tetris360
//
//  Created by Liang Shi on 2013-04-21.
//  Copyright (c) 2013 Gree. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import "StackView.h"

@interface ViewController () <CLLocationManagerDelegate>

@property AVCaptureSession *captureSession;
@property AVCaptureVideoPreviewLayer *previewLayer;
@property IBOutlet UIView *cameraView;

@property CLLocationManager *locationManager;
@property (nonatomic, retain) PieceView *movingPieceView; //current dropping piece
@property (nonatomic, retain) StackView *pieceStackView; //60*15 grid view for pieces already dropped

@end

@implementation ViewController
@synthesize movingPieceView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupCameraView];
    [self setupCompass];
    [self setupStackView];
}

- (void)setupCompass
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.headingFilter = 10;
    [self.locationManager startUpdatingHeading];
}

- (void)setupCameraView
{
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession setSessionPreset:AVCaptureSessionPresetPhoto];
    
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    [self.captureSession addInput:input];
    [self.captureSession setSessionPreset:@"AVCaptureSessionPresetPhoto"];
    [self.captureSession startRunning];
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.view.frame;
    
    [self.cameraView.layer addSublayer:self.previewLayer];
}


- (void)setupStackView
{
    self.pieceStackView  = [[StackView alloc] initWithFrame:CGRectMake(0, 0, kGridSize * kNUMBER_OF_COLUMN, kGridSize * kNUMBER_OF_ROW)];
    [self.view addSubview:self.pieceStackView];
    [self.view bringSubviewToFront:self.startButton];
    [self.view bringSubviewToFront:self.leftButton];
    [self.view bringSubviewToFront:self.rightButton];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startGameClickeed:(id)sender{
    if ([[GameController shareManager] gameStatus] == GameRunning) { //pause game
        [[GameController shareManager] pauseGame];
        [[GameController shareManager] setGameStatus:GamePaused];
        [self.startButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    else if([[GameController shareManager] gameStatus] == GameStopped) { //start game
        [[GameController shareManager] startGame];
        [[GameController shareManager] setGameStatus:GameRunning];
        [[GameController shareManager] setDelegate:self];
        [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
        movingPieceView = [[GameController shareManager] generatePiece];
        [self.view addSubview:movingPieceView];
    }
    else if([[GameController shareManager] gameStatus] == GamePaused) { //resume game
        [[GameController shareManager] setGameStatus:GameRunning];
        [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
        [[GameController shareManager] resumeGame];
    }
}

- (void)updateStackView{
    //TODO - add offset from compass to draw only one section
    [self.pieceStackView setNeedsDisplayInRect:self.pieceStackView.bounds];
}

- (void)dropNewPiece{
    movingPieceView = [[GameController shareManager] generatePiece];
    [self.view addSubview:movingPieceView];
}


- (void)removeCurrentPiece{
    [movingPieceView removeFromSuperview];
    movingPieceView = nil;
}

- (IBAction)leftClicked:(id)sender{
    [[GameController shareManager] movePieceLeft];
}


- (IBAction)rightClicked:(id)sender{
    [[GameController shareManager] movePieceRight];
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    [[GameController shareManager] didChangeHeading:newHeading.magneticHeading];
}

@end
