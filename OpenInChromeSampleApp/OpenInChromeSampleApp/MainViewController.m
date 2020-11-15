// Copyright 2012, Google Inc.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//     * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "MainViewController.h"
#import "OpenInChromeController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)update {
  _openInButton.enabled = [[OpenInChromeController sharedInstance] isChromeInstalled];
  [self appendToInfoView:[NSString stringWithFormat:@"Chrome installed: %@",
                          _openInButton.enabled ? @"YES" : @"NO"]];

}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self update];
}

- (IBAction)openInChrome:(id)sender {
  NSURL *url = [NSURL URLWithString:_addressField.text];
  [self appendToInfoView:[NSString stringWithFormat:@"Opening %@ in Chrome", url]];

  BOOL success = [[OpenInChromeController sharedInstance] openInChrome:url];
  [self appendToInfoView:[NSString stringWithFormat:@"Open in Chrome was %@",
      success ? @"successful" : @"unsuccessful"]];
}

- (void)appendToInfoView:(NSString *)message {
  NSMutableString *infoText =
      [NSMutableString stringWithString:self.infoView.text];
  [infoText appendString:message];
  [infoText appendString:@"\n"];
  self.infoView.text = infoText;
  [self.infoView scrollRangeToVisible:NSMakeRange(infoText.length - 1, 1)];
}

@end
