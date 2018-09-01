
  Pod::Spec.new do |s|
    s.name = 'CapacitorPdfViewerPlugin'
    s.version = '0.0.1'
    s.summary = 'Capacitor PDF viewer plugin'
    s.license = 'MIT'
    s.homepage = 'https://github.com/Dellos7/pdf-viewer.git'
    s.author = 'David López'
    s.source = { :git => 'https://github.com/Dellos7/capacitor-pdf-viewer-plugin.git', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.resources = 'ios/Plugin/Plugin/**/*.{storyboard,png,xib,jpg,jpeg}'
    s.ios.deployment_target  = '10.0'
    s.dependency 'Capacitor'
  end