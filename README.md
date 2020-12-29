# RemoteImageTextAttachment
NSTextAttachment with remote image URL

# Usage

```swift

let attachment = RemoteImageTextAttachment(imageURL: url, displaySize: CGSize(width: 100, height: 100))
let attributedText = NSMutableAttributedString()
attributedText.append(NSAttributedString(attachment: attachment))

// For UITextView/NSTextView
textView.attributedText = attributedText

// For UILabel
attachment.label = label
label.attributedText = attributedText
```
