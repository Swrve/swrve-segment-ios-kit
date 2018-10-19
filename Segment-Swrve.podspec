Pod::Spec.new do |s|
  s.name             = "Segment-Swrve"
  s.version          = "2.0.3"
  s.summary          = "Swrve SDK integration for the Segment iOS"
  s.description      = "Swrve is an integrated mobile marketing automation platform supporting every aspect of mobile engagement, retention and monetization, including in-app messages, push notifications, email, mobile A/B testing, and mobile analytics"
  s.homepage         = 'https://www.swrve.com/'

  s.license          = { :type => 'Commercial', :text => 'See https://www.swrve.com/company/terms' }
  s.author           = { 'Swrve' => 'support@swrve.com' }
  s.platform         = :ios, '8.0'
  s.requires_arc     = true

  s.source           = { :git => "https://github.com/swrve-services/analytics-ios-integration-swrve.git", :tag => s.version.to_s }

  s.source_files     = 'Pod/Classes/**/*'

  s.dependency 'Analytics', '~> 3'
  s.dependency 'SwrveSDK', '~> 5'
end