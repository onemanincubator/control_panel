require File.dirname(__FILE__) + '/../test_helper'
require 'control_panel_controller'

# Re-raise errors caught by the controller.
class ControlPanelController; def rescue_action(e) raise e end; end

class ControlPanelControllerTest < Test::Unit::TestCase
  def setup
    @controller = ControlPanelController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
