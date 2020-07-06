
Pod::Spec.new do |s|
  s.name         = "RNRnpdfaddpassword"
  s.version      = "1.0.31"
  s.summary      = "RNRnpdfaddpassword"
  s.description  = <<-DESC
                  RNRnpdfaddpassword
                   DESC
  s.homepage     = "https://github.com/cxj/RNRnpdfaddpassword.git"
  s.license      = 'MIT'
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0' 
  s.license      = 'MIT'
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/cxj/RNRnpdfaddpassword.git", :tag => "master" }
  s.source_files  = "ios/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  