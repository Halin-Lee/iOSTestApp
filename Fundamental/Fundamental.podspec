#
# Be sure to run `pod lib lint Fundamental.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Fundamental"
  s.version          = "0.1.0"
  s.summary          = "A short description of Fundamental."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/Fundamental"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "17track" => "17track.for.test@gmail.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/Fundamental.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Fundamental' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'








#声明需要用到的系统框架
s.frameworks = 'UIKit', 'CoreData' ,'SystemConfiguration'
#声明需要用到的系统库
s.libraries = 'z' ,'sqlite3','xml2'


#声明需要用到的依赖
s.dependency 'AFNetworking'
#s.dependency 'JSONModel'
s.dependency 'KissXML'

#声明需要用到第三方库
s.vendored_libraries = 'Pod/Frameworks/libGoogleAnalyticsServices.a'
s.vendored_frameworks ='Pod/Frameworks/TestinmAPM.framework'
#声明需要用到头文件
#s.public_header_files = "Pod/Classes/*.h","Pod/Classes/**/*.h"




#需要复制的库文件(若无此定义,则主工程无法使用此库)
#s.preserve_paths = 'Frameworks/libGoogleAnalyticsServices.a'

s.prefix_header_contents = '#import "CommonMarco.h"' ,'#import "NSError+Addition.h"'

#gdata-objectivec-client 需要'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' ,'OTHER_LDFLAGS' => '-lxml2'这两部分
s.xcconfig = { 'ENABLE_BITCODE' => 'NO','HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' ,'OTHER_LDFLAGS' => '-lxml2' }
end
