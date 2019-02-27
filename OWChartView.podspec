#
# Be sure to run `pod lib lint OWChartView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OWChartView'
  s.version          = '0.1.0'
  s.summary          = 'A Easy to use chart control of OWChartView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Easy to use chart control.
                       DESC

  s.homepage         = 'https://github.com/OneWang/OWChartView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OneWang' => 'jackwangqingfei@gmail.com' }
  s.source           = { :git => 'https://github.com/OneWang/OWChartView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'OWChartView/**/*'
  
  s.subspec 'Category' do |ss|
      ss.source_files = 'OWChartView/Category/*.{h,m}'
  end
  
  s.subspec 'OWModel' do |ss|
      ss.source_files = 'OWChartView/OWModel/*.{h,m}'
  end
  
  s.subspec 'OWView' do |ss|
      ss.source_files = 'OWChartView/OWView/*.{h,m}'
  end
  
  # s.resource_bundles = {
  #   'OWChartView' => ['OWChartView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
