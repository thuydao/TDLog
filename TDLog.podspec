#
# Be sure to run `pod lib lint TDCore.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "TDLog"
s.version          = "1.0.4"
s.summary          = "TDLog is a iOS framework. You have beauty project and stable. It will easy to explain log for developer"
s.description      = "TDLog is a iOS framework. You have beauty project and stable. It will easy to explain log for developer, so they are quick detect error & resolved it"
s.homepage         = "https://github.com/thuydao/TDLog"
s.license          = 'MIT'
s.author           = { "Thuỷ Đào" => "daoduythuy@gmail.com" }
s.source           = { :git => "https://github.com/thuydao/TDLog.git", :tag => s.version.to_s }
# s.social_media_url = 'https://www.facebook.com/daoduythuy'

#s.ios.vendored_frameworks = 'Frameworks/TDLog.framework'

s.platform     = :ios, '7.0'
s.requires_arc = true
s.frameworks   = ['Foundation', 'UIKit', 'CoreGraphics', 'QuartzCore', 'CoreFoundation']

#s.source_files = 'TDLog/*'

s.resource_bundles = {
'TDLog' => ['TDLog/*.png','TDLog/**/*.{xib,png,html,css}']
}

s.subspec 'TDLog' do |ss|
ss.source_files = 'TDLog/*.h'
end

s.subspec 'TDEngineLog' do |ss|
ss.source_files = 'TDLog/TDEngineLog/*'
end

s.subspec 'TDFloatIcon' do |ss|
ss.source_files = 'TDLog/TDFloatIcon/*.{h,m}'
end

s.subspec 'TDLogManagement' do |ss|
ss.source_files = 'TDLog/TDLogManagement/*.{h,m}'
end

s.subspec 'TDLogView' do |ss|
ss.source_files = 'TDLog/TDLogView/*.{h,m}'
end

s.public_header_files = 'TDLog/**/*.h','TDLog/*.h'

# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
