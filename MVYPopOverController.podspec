Pod::Spec.new do |s|

  s.name = "MVYPopOverController"
  s.version = "0.0.2"
  s.summary = "Universal iOS Pop Over Controller"
  s.description = <<-DESC
                   A longer description of MVYPopOverController in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
                   
  s.homepage = "https://github.com/mobivery/MVYPopOverController"
  # s.screenshots = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { "Álvaro Murillo" => "@alvaromurillop" }
  s.platform = :ios
  s.platform = :ios, '5.0'
  s.source = { :git => "https://github.com/mobivery/MVYPopOverController.git", :tag => "0.0.2" }
  s.source_files = 'MVYPopOverController/**/*.{h,m}'
  s.requires_arc = true

end
