Pod::Spec.new do |s|
  s.name         = "CPFramework"
  s.version      = "0.0.1"
  s.summary      = "Just a test framework for cocoapods."
  s.description  = "In the framework of self made test framework, cocoapods."
  s.homepage     = "https://github.com/oltv00"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "oltv00" => "oltv00@gmail.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/oltv00/CPFramework.git", :tag => s.version }
  s.source_files = "CPFrameworkTest/**/*.{h,m}"
end
