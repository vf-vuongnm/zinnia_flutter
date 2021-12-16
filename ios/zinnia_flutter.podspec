#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint zinnia_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'zinnia_flutter'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.private_header_files = 'Classes/zinnia/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  s.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'HAVE_CONFIG_H=1' }

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
