Pod::Spec.new do |s|

s.name = 'AEViewModel'
s.version = '0.9.2'
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.summary = 'Swift minion for convenient creation of table and collection views'

s.source = { :git => 'https://github.com/tadija/AEViewModel.git', :tag => s.version }
s.source_files = 'Sources/AEViewModel/*.swift'

s.swift_versions = ['4.2', '5.0', '5.1']

s.ios.deployment_target = '9.0'

s.homepage = 'https://github.com/tadija/AEViewModel'
s.author = { 'tadija' => 'tadija@me.com' }
s.social_media_url = 'http://twitter.com/tadija'

end
