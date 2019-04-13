#
# Be sure to run `pod lib lint TableViewCellConfiguration.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TableViewCellConfiguration'
  s.version          = '0.1.0'
  s.summary          = 'A no-time minimalistic one-section UITableView'

  s.homepage         = 'https://github.com/tanderus/TableViewCellConfiguration'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tanderus' => '6lackk@gmail.com' }
  s.source           = { :git => 'https://github.com/tanderus/TableViewCellConfiguration.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'
  s.source_files = 'TableViewCellConfiguration/Classes/**/*'
  s.frameworks = 'UIKit'
end
