
Pod::Spec.new do |s|

  s.name         = "SXCycleView"
  s.version      = "1.1.1"
  s.summary      = "you can create a cycleview for you app"
  #s.description  = <<-DESC
  #                  DESC

  s.homepage     = "https://github.com/poos/SXCycleView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = 'MIT'
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "iShown" => "1254612373@qq.com" }
  # Or just: s.author    = "iShown"
  # s.authors            = { "iShown" => "1254612373@qq.com" }
  # s.social_media_url   = "http://twitter.com/iShown"

  s.platform     = :ios, "7.1"

  s.source       = { :git => "https://github.com/poos/SXCycleView.git", :tag => s.version.to_s }

  s.source_files  = "SXCycleView/**/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "SDWebImage", "~> 3.8"

end
