source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Artsy/Specs.git'

platform :ios, '9.0'
inhibit_all_warnings!

target 'Resizer' do
  use_frameworks!

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
