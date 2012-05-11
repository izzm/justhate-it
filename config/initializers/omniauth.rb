Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '3F3SXSzEVhCvuj740E26YQ', 'xrhPzrn5V9M3XI1pNY1lTmVpzUSuMXdFAeaxzOO9g'
  provider :facebook, '345318732182131', '1338a17e15918016265ff1c9c55c9268',
           :scope => 'email,offline_access,read_stream', :display => 'popup'
end
=begin
Devise.setup do |config|
  config.omniauth :twitter, '3F3SXSzEVhCvuj740E26YQ', 'xrhPzrn5V9M3XI1pNY1lTmVpzUSuMXdFAeaxzOO9g'
  config.omniauth :facebook, '345318732182131', '1338a17e15918016265ff1c9c55c9268',
                  :scope => 'email,offline_access,read_stream', :display => 'popup'
end
=end