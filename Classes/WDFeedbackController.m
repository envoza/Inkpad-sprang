//
//  WDFeedbackController.m
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Created by Derek Pollard on 16/11/2015.
//  Copyright © 2015 Envoza.
//

#import "WDFeedbackController.h"
#import "WDFeedbackDelegate.h"

@interface WDFeedbackController ()
@property (strong, nonatomic) WDFeedbackDelegate *feedbackDelegate;
@property (weak, nonatomic) IBOutlet UILabel *sendFeedbackLabel;
@end

@implementation WDFeedbackController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Self sizing cells
	self.tableView.estimatedRowHeight = 44;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.sendFeedbackLabel.text = NSLocalizedString(@"Send feedback", @"Send feedback");
}

#pragma mark - Properties

- (WDFeedbackDelegate *)feedbackDelegate
{
	if (!_feedbackDelegate)
	{
		_feedbackDelegate = [[WDFeedbackDelegate alloc] init];
		_feedbackDelegate.subjectLine = @"Inkpad feedback";
	}
	
	return _feedbackDelegate;
}

#pragma mark - Table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (section == 0)
	{
		return 0.0000001f;
	}
	
	return [super tableView:tableView heightForHeaderInSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1 &&
		indexPath.row == 0)
	{
		[self.feedbackDelegate displayFeedbackEmailInViewController:self];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewAutomaticDimension;
}

@end
