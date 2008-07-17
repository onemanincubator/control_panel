class ControlPanelController < AdminController
	
	# main actions of the control_panel
	# To customize the control panel, remove and/or add actions
	# to/from this list (and provide the necessary action methods/views).
	cattr_accessor :main_actions
	self.main_actions = %w(index data config users site code plugins)
	
	# methods added by the control_panel plugin
	# these are mixed mixed in methods from the various plugins
	# which with the control_panel interfaces
	# *** this command MUST come after self.main_actions is set ***
	runs_like_control_panel
	
	# sets a session variable whenever one of the main actions is called
	# so that control_panel_breadcrumbs reflects the correct context
	before_filter :set_action, :only => self.main_actions

	# defines the main actions of the control_panel
	self.main_actions.each do |action|
    define_method(action) do
    	control_panel_switch
    end
  end
  
  private
  
  # control_panel_switch simply listens for a control_panel
  # method being called and routes processing to that
  # helper method (by default, in 
  # vendor/plugins/control_panel/lib/control_panel_view).
  def control_panel_switch
  	@control_panel_action = params[:m] || "#{action_name}_cp_index"
  	@control_panel_params = params
    render :template => 'control_panel/switch'
	end  	
  
  def set_action
  	session[:control_panel_action] = action_name
  end

end

