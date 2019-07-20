# Uncomment the next line to define a global platform for your project
platform :ios, '12.2'

target 'Translations Demo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  pod 'CountdownLabel'
  pod 'JRMFloatingAnimation'

  target 'Translations DemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['CountdownLabel'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end
