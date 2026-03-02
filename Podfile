# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Vs_GradItCollege' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Vs_GradItCollege


pod "KRProgressHUD"
pod 'ObjectMapper'
pod 'Alamofire'

pod 'HCVimeoVideoExtractor'
pod 'DropDown'
pod 'SDWebImage'
pod 'AlamofireImage'
pod "BSImagePicker"
pod 'AWSS3'
pod 'AWSCognito'
pod 'AWSCore'
pod 'FSCalendar'
pod 'VimeoNetworking'
pod 'ExpyTableView'
pod 'SwiftyJSON'
pod 'iOSDropDown'
pod 'FirebaseMessaging'
pod 'Fabric'
pod 'FirebaseCrashlytics'

pod 'GoogleUtilities'

pod 'ALCameraViewController'

 

  target 'Vs_GradItCollegeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Vs_GradItCollegeUITests' do
    # Pods for testing
  end


post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
         end
    end
end
 
  end

end
