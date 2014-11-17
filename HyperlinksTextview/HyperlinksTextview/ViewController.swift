//
//  ViewController.swift
//  HyperlinksTestview
//
//  Created by JNYJ on 14-11-17.
//  Copyright (c) 2014年 JNYJ. All rights reserved.
//


/*

IMPT
From  http://stackoverflow.com/questions/26962530/hyperlinks-in-a-uitextview
By  "stackoverflow"
Note: 
Original: 


up vote
0
down vote
favorite
I am trying to create a UITextView with a hyperlink so that when the user clicks on the link, they are taken to safari to open the webpage. I have read on link detectors for a textview but those samples always show link detection working if an actual url is present in the text (ie. www.google.com). I want it to be regular text that, when clicked, opens an associated URL. (ie. Google is the text and when clicked, opens up a url www.google.com). How can I accomplish this in iOS7/8?

ios objective-c ios8 uitextview
share|edit|flag
asked 9 hours ago

John Baum
3381931


Use NSAttributedString and NSLinkgAttributeName. –  Larme 9 hours ago
add a comment
1 Answer
activeoldestvotes
up vote
1
down vote
accepted
Use NSAttributedString

NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Google"
attributes:@{ NSLinkAttributeName: [NSURL URLWithString:@"http://www.google.com"] }];
self.textView.attributedText = attributedString;
Sure, you can set just a portion of the text to be the link. Please read more about the NSAttributedString here.

If you want to have more control and do something before opening the link. You can set the delegate to the UITextView.

- (void)viewDidLoad {
...
self.textView.delegate = self; // self must conform to UITextViewDelegate protocol
}

...

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
// Do whatever you want here
NSLog(@"%@", URL); // URL is an instance of NSURL of the tapped link
return YES; // Return NO if you don't want iOS to open the link
}
share|edit|flag
edited 5 hours ago

answered 9 hours ago

Sikhapol Saijit
713


Just a quick followup: How can I get the ability that, when tapped, I get back the url that was tapped so I can send a web request? For ex. tapping Google would activate some selector which will pass the NSURL www.google.com)? –  John Baum 8 hours ago


Set self (or whatever you want) to the UITextView's delegate. Then implement textView:shouldInteractWithURL:inRange:. I'll update my answer to reflect this question. –  Sikhapol Saijit 8 hours ago


What if i want to handle the link opening myself or want to do something else with the link (such as passing it to another object to initiate a network request). Ideally, I would want to get back the url of the text i just clicked on. How can i do that? –  John Baum 8 hours ago


In - textView:shouldInteractWithURL:inRange: you get the URL (an instance of NSURL) that was tapped. You can do anything with it. Just return NO in that delegate method to prevent iOS from opening the link. –  Sikhapol Saijit 5 hours ago
add a comment

*/
import UIKit

class ViewController: UIViewController,UITextViewDelegate {

	@IBOutlet var textView : UITextView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		//
		if let item = self.textView {
			var dic_ : NSDictionary! = NSDictionary(object: NSURL(string: "http://www.stackoverflow.com")!, forKey: NSLinkAttributeName)
			var attributedString_ : NSAttributedString! = NSAttributedString(string: "Stackoverflow", attributes: dic_)
			self.textView.attributedText = attributedString_
			self.textView.font = UIFont.boldSystemFontOfSize(40)
			//
			self.textView.editable = false
			self.textView.delegate =  self
		}
//		self.textView.attributedText = attributedString;
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {

		println("----\(URL)-----")// URL is an instance of NSURL of the tapped link

		return true; // Return NO if you don't want iOS to open the link

//		UIAlertView(title: "Open URL ...", message: "TO OPEN", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK").show()
//		return false; // Return NO if you don't want iOS to open the link
	}

}

