#
#  Be sure to run `pod spec lint RemoteImageTextAttachment.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "RemoteImageTextAttachment"
  spec.version      = "1.0.0"
  spec.summary      = "NSTextAttachment with remote image URL"
  spec.description  = "Allows usage of remote image URL in NSTextAttachment"

  spec.homepage     = "https://github.com/namanhams/RemoteImageTextAttachment"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Pham Hoang Le" => "namanhams@yahoo.com" }
  
  spec.platform     = :ios, "9.0"
  spec.swift_versions = '5.0'

  spec.source       = { :git => "https://github.com/namanhams/RemoteImageTextAttachment.git", :tag => spec.version }
  spec.source_files  = "RemoteImageTextAttachment/RemoteImageTextAttachment.swift"

end
