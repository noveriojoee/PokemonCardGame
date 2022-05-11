# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '12.1'

def dev_frameworks
#  pod 'uicomponents', :git => 'https://github.com/noveriojoee/UIComponents.git'
  pod 'ObjectMapper', '~> 3.5'
  pod 'AFNetworking', '~> 3.0'
  pod 'NVActivityIndicatorView'
end


target 'PokemonGames' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  dev_frameworks

  # Pods for PokemonGames

  target 'PokemonGamesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PokemonGamesUITests' do
    # Pods for testing
  end

end
