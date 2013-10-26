#NOTE THIS IS YOUR PERSONAL ACTIONS AREA
#NOT COMMITED TO GIT LESS THE EXAMPLE
class Pre_start
    include MAGEINSTALLER_Helper
    def initialize(params=nil)
        load_settings
        version = @bs_MAGEversion
        if version==nil
            uinput = agree("There was no config, would you like to use the 1.8.0 version of Magento <%= color('[y/n]', :bold) %>")
            if uinput
                version="1.8.0.0"
              else
                version = ask("version to use:")  do |q| 
                    q.validate = /.+/ 
                    q.responses[:not_valid]    = 'Must not be blank'
                    q.responses[:ask_on_error] = :question
                end
            end
        end
        
        #set_background("")
        #self.get_packages($version)
        #would push these download to the background
        file="_depo/magento-#{version}.tar.gz"
        if !File.exist?(file)
            download("http://www.magentocommerce.com/downloads/assets/#{version}/magento-#{version}.tar.gz",file)
        else
            puts "mage package exists"
        end
        if File.exist?(file)
            if !File.exist?("#{Dir.pwd}/www/magento/installed.txt") 
                puts "extracting mage package contents"
                untar_gz(file,"www")
                File.open("#{Dir.pwd}/www/magento/installed.txt", "w+") { |file| file.write("") }
            end
        end
        
        install_sample = @bs_install_sample
        file="_depo/magento-sample-data-1.6.1.0.tar.gz"
        if !File.exist?(file)
            download("http://www.magentocommerce.com/downloads/assets/1.6.1.0/magento-sample-data-1.6.1.0.tar.gz",file)
        else
            puts "mage sample data package exists"
        end
        if install_sample
            if File.exist?(file)
                if !File.exist?("#{Dir.pwd}/www/magento/sample_installed.txt") 
                    puts "extracting mage package contents"
                    untar_gz(file,"www/magento")
                    File.open("#{Dir.pwd}/www/magento/sample_installed.txt", "w+") { |file| file.write("") }
                end
            end
        end
    end
    
    def get_packages(version)
        
    end
    
    
    
end