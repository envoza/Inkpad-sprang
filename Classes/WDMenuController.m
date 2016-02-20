//
//  WDMenuController.m
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Created by Derek Pollard on 14/11/2015.
//  Copyright © 2015 Envoza.
//

#import "WDMenuController.h"
#import "WDHelpController.h"

@interface WDMenuController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (weak, nonatomic) IBOutlet UILabel *helpLabel;
@end

@implementation WDMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	
	// Self sizing cells
	self.tableView.estimatedRowHeight = 44;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.versionLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Version %@", @"Application version numbers"),
							  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
	
	self.feedbackLabel.text = NSLocalizedString(@"Feedback", @"Feedback");
	self.helpLabel.text = NSLocalizedString(@"Help", @"Help");
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	self.visible = false;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.visible = true;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"showFeedback"])
	{
		
		self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
	}
}

#pragma mark - Table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (section == 0 ||
		section == 1)
	{
		return 0.0000001f;
	}
	
	return [super tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	if (section == 0)
	{
		return 0.0000001f;
	}
	
	return [super tableView:tableView heightForFooterInSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1 &&
		indexPath.row == 1)
	{
		WDHelpController *helpController = [[WDHelpController alloc] initWithNibName:nil bundle:nil];
		
		// Create a Navigation controller
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:helpController];
		navController.modalPresentationStyle = UIModalPresentationPageSheet;
		
		// show the navigation controller modally
		[self presentViewController:navController animated:YES completion:nil];
		
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

#pragma mark - Table view data source

@end
