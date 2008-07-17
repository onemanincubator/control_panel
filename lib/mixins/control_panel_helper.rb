module ControlPanel
  
  module HelperMethods
  
  	#
  	# control_panel_breadcrumbs, control_panel_menu
  	#			- called by views/layouts/control_panel.rhtml
  	#
  	
  	def control_panel_breadcrumbs
  		tag = link_to("Home", :controller => 'control_panel', :action => 'index')
  		return tag if current_main_action == 'index'
  		tag << " > "
  		tag << link_to_action(current_main_action.titleize)
  		return tag unless params[:m]
  		tag << " > "
  		tag << params[:m].titleize
  	end
  	
  	def control_panel_menu
  		row_tags = ""
  		control_panel_main_actions.each do |action|
   			row_tags << content_tag(:tr, 
   										content_tag(:td, link_to_action(action.titleize)))
   		end
  		content_tag(:table, row_tags)
  	end
  	
  	###################################################################
  	#
  	# Home
  	#
  	###################################################################  	
  	
  	def index_cp_index(params = {})
  		columns = 2
  		row_tags, cell_tags = "", ""
  		columns.times do
  			row_tags << tag(:col, :width => "1*")
  		end 
  		control_panel_main_actions.each_with_index do |action, i|
  			cell_tags << content_tag(:td,
  									content_tag(:h3, link_to(action.titleize,
  										:action => action)) +
  									self.send("#{action}_cp_intro".to_sym))
  			if i.modulo(columns) == 1
  				row_tags << content_tag(:tr, cell_tags, :valign => 'top')
  				cell_tags = ""
  			end
  		end
  		unless cell_tags.blank?
  			row_tags << content_tag(:tr, cell_tags, :valign => 'top')
  		end
  		content_tag(:table, row_tags, 
  								:width => "100%", :cellpadding => "5")
  	end
	
  	###################################################################
  	#
  	# Data
  	#
  	###################################################################  	
  	
  	# called by control_panel_index
  	def data_cp_intro
  		"#{request.domain} reads and writes data stored in a 
			#{link_to 'mysql', 'http://en.wikipedia.org/wiki/MySQL',
			:popup => true} database. #{link_to('Data')} enables 
			admins to access and modify this data."
  	end
  	
		#
		# actions invoked as... :action => 'data', {params}
		#
		
  	def data_cp_index(params = {})
  	  row_tags = ""
  		Crud.app_tables_list.each do |table|
  			row_tags << content_tag(:tr, content_tag(:td, 
  				link_to(table.titleize, :action => 'list', :table => table)))
  		end
  		intro = content_tag(:p, "Listed below are the database tables 
  		defined specifically for #{request.domain}. The remaining tables 
  		in the database are used by rails and/or certain 
  		plugins. See #{link_to_action 'Plugins'} to inspect the latter.
  		(#{link_to 'See all tables', :action => 'data', 
  		:m => 'see_all_tables'}.)")
  		intro + content_tag(:table, row_tags)
  	end
  	
  	def see_all_tables(params = {})
  		intro = "Below are all of the non-system tables in the 
  		#{request.domain} database."
  	  row_tags = ""
  		Crud.tables_list.each do |table|
  			row_tags << content_tag(:tr, content_tag(:td, 
  				link_to(table.titleize, :action => 'list', :table => table)))
  		end
  		intro + content_tag(:table, row_tags)
  	end
  	
  	###################################################################
  	#
  	# Config
  	#
  	###################################################################  
  	
  	# methods in crud plugin	
  	
  	###################################################################
  	#
  	# Users
  	#
  	###################################################################  	
  	
  	# called by control_panel_index
  	def users_cp_intro
  		"#{request.domain} is accessed by certain logged in
			users (like yourself). #{link_to_action 'Users'} 
			enables admins to manage the accounts of these users."
		end

		#
		# actions invoked as... :action => 'users', {params}
		#
		
  	def users_cp_index(params = {})
  		"TBD"
  	end
  	
  	###################################################################
  	#
  	# Site
  	#
  	###################################################################  	
  	
  	# called by control_panel_index
  	def site_cp_intro
  		"#{request.domain} is a website. This means it is a group of
			programs that are always running. #{link_to_action 'Site'}
			enables admins to	monitor the operation of #{request.domain}
			and view configuration files as well as site logs."
		end

		#
		# actions invoked as... :action => 'site', {params}
		#
		
  	def site_cp_index(params = {})
  		"TBD"
  	end
  	
  	###################################################################
  	#
  	# Code
  	#
  	###################################################################  	
  	
  	# called by control_panel_index
  	def code_cp_intro
  		"The programs that collectively run the #{request.domain}
			website include certain code, based upon 
			#{link_to 'Ruby on Rails', 
			'http://en.wikipedia.org/wiki/Ruby_on_rails',
			:popup => true}, that is specific to #{request.domain}, 
			as well as other public domain or open source code. 
			#{link_to_action 'Code'} enables admins to view development 
			logs of the #{request.domain}-specific code, plus the 
			open source code itself."
		end

		#
		# actions invoked as... :action => 'code', {params}
		#
		
  	def code_cp_index(params = {})
  		"TBD"
  	end
  	
  	###################################################################
  	#
  	# Plugins
  	#
  	###################################################################  	
  	
  	# called by control_panel_index
  	def plugins_cp_intro
  		"#{request.domain} uses open source code packages known as 
			#{link_to 'plugins', 
			'http://wiki.rubyonrails.org/rails/pages/Plugins',
			:popup => true} that provide certain functionality. 
			#{link_to_action 'Plugins'} enables admins to configure 
			the operation of plugins that work with this control panel."
		end

		#
		# actions invoked as... :action => 'plugins', {params}
		#
		
  	def plugins_cp_index(params = {})
  		"TBD"
  	end
  	
  	private
  	
  	def control_panel_main_actions
  		controller.main_actions - ['index']
  	end
  	
  	def link_to_action(anchor, params = {})
  		link_to anchor, {:controller => 'control_panel',
  											:action => anchor.to_s.underscore}.merge(params)
  	end
  	
  	def current_main_action
  		session[:control_panel_action]
  	end
  	
  	def temp
<<EOT
<table cellspacing="10">
	<tr>
		<th>Database Management</th>
		<th>Drop-Down List Management</th>
		<th>Multi-Checkbox Management</th>
	</tr>
	<tr valign="top">
		<td>
			<% @tables.each do |table| %>
				<%= link_to table.camelize, :action => 'list', :table => table %>
				&nbsp;
				(<%= table.classify.constantize.count %> records)
				<br><br>
			<% end %>
		</td>
		<td>
			<% @selection_lists.each do |list| %>
				<%= selection_list_tag(list) %>
				<br>
			<% end %>
		</td>
		<td>
			<% @selection_multi_lists.each do |multi_list| %>
				<%= selection_list_tag(multi_list) %>
				<br>
			<% end %>
		</td>
	</tr>
</table>
<p><%= link_to "run commands", :action => 'run_command' %></p>
EOT
			end
  	
	end
  
end
