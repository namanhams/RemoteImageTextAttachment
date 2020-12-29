//
//  RemoteImageTextAttachment.swift
//  RemoteImageTextAttachment
//
//  Created by Hoang Le Pham on 26/11/2020.
//  Copyright © 2020 Pham Le. All rights reserved.
//

import UIKit

public class RemoteImageTextAttachment: NSTextAttachment {
  
  // The label that this attachment is being added to
  public weak var label: UILabel?
  
  // The size to display the image. If nil, the image's size will be used
  public var displaySize: CGSize?
  
  public var downloadQueue: DispatchQueue?
  public let imageUrl: URL
  
  private weak var textContainer: NSTextContainer?
  private var isDownloading = false
  
  public init(imageURL: URL, displaySize: CGSize? = nil, downloadQueue: DispatchQueue? = nil) {
    self.imageUrl = imageURL
    self.displaySize = displaySize
    self.downloadQueue = downloadQueue
    super.init(data: nil, ofType: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override public func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
    
    if let displaySize = displaySize {
      return CGRect(origin: .zero, size: displaySize)
    }
    
    if let originalImageSize = image?.size {
      return CGRect(origin: .zero, size: originalImageSize)
    }
    
    // If we return .zero, the image(forBounds:textContainer:characterIndex:) function won't be called
    let placeholderSize = CGSize(width: 1, height: 1)
    return CGRect(origin: .zero, size: placeholderSize)
  }
  
  override public func image(forBounds imageBounds: CGRect, textContainer: NSTextContainer?, characterIndex charIndex: Int) -> UIImage? {
    
    if let image = image {
      return image
    }
    
    self.textContainer = textContainer
    
    guard !isDownloading else {
      return nil
    }
    
    isDownloading = true
    
    let imageUrl = self.imageUrl
    let downloadQueue = self.downloadQueue ?? DispatchQueue.global()
    downloadQueue.async { [weak self] in
      let data = try? Data(contentsOf: imageUrl)
      DispatchQueue.main.async { [weak textContainer] in
        guard let strongSelf = self else {
          return
        }
        
        defer {
          strongSelf.isDownloading = false
        }
        
        guard let data = data else {
          return
        }
        
        strongSelf.image = UIImage(data: data)
        strongSelf.label?.setNeedsDisplay()
        
        // For UITextView/NSTextView
        if let layoutManager = self?.textContainer?.layoutManager,
          let ranges = layoutManager.rangesForAttachment(strongSelf) {
          ranges.forEach { range in
            layoutManager.invalidateLayout(forCharacterRange: range, actualCharacterRange: nil)
          }
        }
      }
    }
    
    return nil
  }
}

public extension NSLayoutManager {
  func rangesForAttachment(_ attachment: NSTextAttachment) -> [NSRange]? {
    guard let textStorage = textStorage else {
      return nil
    }
    var ranges: [NSRange] = []
    textStorage.enumerateAttribute(.attachment, in: NSRange(location: 0, length: textStorage.length), options: [], using: { (attribute, range, _) in
      
      if let foundAttribute = attribute as? NSTextAttachment, foundAttribute === attachment {
        ranges.append(range)
      }
    })
    
    return ranges
  }
}

