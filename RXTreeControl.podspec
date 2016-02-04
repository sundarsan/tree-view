Pod::Spec.new do |s|
  s.name         = 'RXTreeControl'
  s.version      = '0.0.2'
  s.summary      = 'Amazing reactive custom reorder menu'
  s.homepage     = 'https://github.com/Ramotion/tree-view'
  s.license      = 'MIT'
  s.authors = { 'Juri Vasylenko' => 'juri.v@ramotion.com' }
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/Ramotion/tree-view.git', :tag => s.version.to_s }
  s.source_files  = 'RXTreeControl/RXTreeControl/**/*.swift'
  s.requires_arc = true

  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'RxBlocking'
end
