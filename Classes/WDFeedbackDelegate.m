//
//  WDFeedbackDelegate.m
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Created by Derek Pollard on 20/11/2015.
//  Copyright © 2015 Envoza.
//

#import "WDFeedbackDelegate.h"
#import <MessageUI/MessageUI.h>
#import <sys/utsname.h>

@interface WDFeedbackDelegate () <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) UIViewController *viewController;
@end


@implementation WDFeedbackDelegate


#pragma mark - API

- (void)displayFeedbackEmailInViewController:(UIViewController *)viewController
{
	self.viewController = viewController;
	
	NSString *messageBody = [NSString
							 stringWithFormat:@"\n\n--\nInkpad %@\n%@ (%@)\n",
							 [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
							 [self machineName],
							 [[UIDevice currentDevice] systemVersion]];
	
	MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
	[composer setSubject:self.subjectLine];
	[composer setToRecipients:@[@"xxxx@xxxx.xxxx"]];
	[composer setMessageBody:messageBody isHTML:NO];
	[composer setMailComposeDelegate:self];
	
	[self.viewController presentViewController:composer
									  animated:YES
									completion:NULL];
}

#pragma mark - Properties

- (NSString *)subjectLine
{
	if (!_subjectLine)
	{
		_subjectLine = @"Inkpad feedback";
	}
	
	return _subjectLine;
}

#pragma mark - Mail Compose View Controller Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self.viewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Internal

- (NSString *)machineName
{
	struct utsname systemInfo;
	uname(&systemInfo);
	
	return [NSString stringWithCString:systemInfo.machine
							  encoding:NSUTF8StringEncoding];
}

@end
