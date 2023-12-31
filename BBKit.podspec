#
# Be sure to run `pod lib lint BBKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BBKit'
  s.version          = '0.1.2'
  s.summary          = 'A short description of BBKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.swift_version = '5.0'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'git@github.com:675088349/BBKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BBKit' => '67508834@qq.com' }
  s.source           = { :git => 'git@github.com:675088349/BBKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'BBKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BBKit' => ['BBKit/Assets/*.png']
  # }
  
#  s.resource_bundles = {
#    'BBKit' => ['BBKit/Classes/*.{xcassets,bundle}', 'BBKit/Classes/Tripartite/ZLPhotoBrowser/*.{bundle}']
#  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.static_framework = true

  s.frameworks = 'UIKit', "Foundation"

end
