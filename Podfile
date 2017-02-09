# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
#use_frameworks!
platform :ios, '8.0' 
def basePods
  pod 'Fundamental', :path => 'Fundamental/Fundamental.podspec'

#  pod 'DataBindingLib'
  pod 'PlaceHolderViewLib'

  pod 'JSPatch'

#使用最新版本会导致build失败(Result 2.0.0导致),原因未知
  pod 'ReactiveCocoa', '~> 2.5'

  pod 'KissXML'

#FB循环引用解析
  pod 'FBRetainCycleDetector'

  pod 'AFNetworking'
  
  pod 'FMDB'
  
  pod 'BEMCheckBox'

  pod ‘NUI’
end
target 'TestApp' do
  basePods
  target 'TestAppTests'  do
    pod 'Kiwi'
  end
end


