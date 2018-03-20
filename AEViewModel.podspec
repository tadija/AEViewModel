Pod::Spec.new do |s|

s.name = 'AEViewModel'
s.summary = 'Swift minion for convenient creation of table and collection views'
s.version = '0.5.1'
s.license = { :type => 'MIT', :file => 'LICENSE' }

s.source = { :git => 'https://github.com/tadija/AEViewModel.git', :tag => s.version }
s.source_files = 'Sources/*.swift'

s.swift_version = '4.0'
s.ios.deployment_target = '9.0'

s.homepage = 'https://github.com/tadija/AEViewModel'
s.author = { 'tadija' => 'tadija@me.com' }
s.social_media_url = 'http://twitter.com/tadija'

end
