module ControlPanel
  
  module ControllerMethods
    
    def self.included(base) #:nodoc:
      base.extend(ClassMethods)
    end

    module ClassMethods 
      def runs_like_control_panel(options={})
        
				# plugin controller mixins
				(runs_like_crud :admin => true) if self.respond_to?('runs_like_crud')
				runs_like_simple_list if self.respond_to?('runs_like_simple_list')
				runs_like_config if self.respond_to?('runs_like_config')
				
        include ControlPanel::ControllerMethods::InstanceMethods
        
      end
    end

    module InstanceMethods
    end
 	
 	end
 	
end
