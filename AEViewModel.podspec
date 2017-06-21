Pod::Spec.new do |s|

s.name = 'AEViewModel'
s.version = '0.3.3'
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.summary = 'Swift minion for convenient creation of table and collection views'

s.homepage = 'https://github.com/tadija/AEViewModel'
s.author = { 'tadija' => 'tadija@me.com' }
s.social_media_url = 'http://twitter.com/tadija'

s.source = { :git => 'https://github.com/tadija/AEViewModel.git', :tag => s.version }
s.source_files = 'Sources/*.swift'

s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

s.ios.deployment_target = '9.0'

end
