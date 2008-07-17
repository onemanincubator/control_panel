class InitControlPanelGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      puts ""
      
      # create control panel controller
      m.directory File.join('app','controllers')
      m.file 'controller.rb', 
      	File.join('app','controllers','control_panel_controller.rb')
      
      # create control panel view
      m.directory File.join('app','views')
      m.directory File.join('app','views','control_panel')
      m.file 'view.rhtml', 
      	File.join('app','views','control_panel','switch.rhtml')
      	
      # create control panel layout
      m.directory File.join('app','views')
      m.directory File.join('app','views','layouts')
      m.file 'layout.rhtml', 
      	File.join('app','views','layouts','control_panel.rhtml')    
      
      # create control panel test
      m.directory File.join('test','functional')
      m.file 'test.rb', 
      	File.join('test','functional','layouts','control_panel_test.rb')    
      
      # print out README
      puts ""      
      puts IO.read(File.join(File.dirname(__FILE__),'..', '..', 'README'))    
    end  
  end
  
end

