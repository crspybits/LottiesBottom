#
# Be sure to run `pod lib lint LottiesBottom.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LottiesBottom'
  s.version          = '0.4.0'
  s.summary          = 'Uses animations from Lottie (airbnb) for a pull up from the bottom control for a UIScrollView.'

  s.description      = <<-DESC
Uses https://github.com/airbnb/lottie-ios animations for a pull up from the bottom control for a UIScrollView. E.g., this is useful for a pull-up-from the bottom refresh control for a UITableView. And could just be a fun easter egg too! The Lottie animation .json file you use needs to be in the main bundle of your app.
                       DESC

  s.homepage         = 'https://github.com/crspybits/LottiesBottom'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'crspybits' => 'chris@SpasticMuffin.biz' }
  s.source           = { :git => 'https://github.com/crspybits/LottiesBottom.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'LottiesBottom/Classes/**/*'
  
  s.requires_arc = true

  s.dependency 'lottie-ios', '~> 2.1'
end
