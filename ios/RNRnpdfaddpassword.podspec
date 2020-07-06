
Pod::Spec.new do |s|
  s.name         = "RNRnpdfaddpassword"
  s.version      = "1.1.1"
  s.summary      = "RNRnpdfaddpassword"
  s.description  = <<-DESC
                  RNRnpdfaddpassword
                   DESC
  s.homepage     = "https://github.com/cxj/RNRnpdfaddpassword"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/cxj/RNRnpdfaddpassword.git", :tag => "master" }
  s.source_files  = "RNRnpdfaddpassword/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  