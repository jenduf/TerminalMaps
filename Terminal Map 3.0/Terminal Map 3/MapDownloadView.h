//
//  MapDownloadView.h
//  TerminalMaps
//
//  Created by Jennifer Duffey on 6/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MapDownloadView : UIView 
{

}

@property (nonatomic, strong) IBOutlet UILabel *topLabel, *bottomLabel;
@property (nonatomic, strong) IBOutlet UILabel *progressLabel;
@property (nonatomic, strong) UIButton *updateButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) IBOutlet UIView *progressContainerView, *updateContainerView;
@property (nonatomic, assign) BOOL showProgress;

- (IBAction)cancel:(id)sender;
- (void)showUpdateView;

@end
