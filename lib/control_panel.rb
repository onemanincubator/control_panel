# requirements for mixins
require 'action_controller'
require 'action_view'

# mixins
require 'mixins/control_panel_helper'
ActionView::Base.module_eval {include ControlPanel::HelperMethods}
require 'mixins/control_panel_controller'
ActionController::Base.class_eval {include ControlPanel::ControllerMethods}

module ControlPanel
end
