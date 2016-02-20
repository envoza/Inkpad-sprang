//
//  WDFeedbackDelegate.h
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Created by Derek Pollard on 20/11/2015.
//  Copyright © 2015 Envoza.
//

#import <Foundation/Foundation.h>

@interface WDFeedbackDelegate : NSObject
@property (strong, nonatomic) NSString *subjectLine;

- (void)displayFeedbackEmailInViewController:(UIViewController *)viewController;

@end
