
Pod::Spec.new do |s|
  s.name         = "RNDolphinServer"
  s.version      = "1.0.1"
  s.summary      = "RNDolphinServer"
  s.description  = <<-DESC
                  RNDolphinServer
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNDolphinServer.git", :tag => "master" }
  s.source_files  = "RNDolphinServer/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  