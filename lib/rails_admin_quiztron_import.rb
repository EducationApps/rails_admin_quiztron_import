require 'rails_admin_quiztron_import/engine'
require 'uri'

module RailsAdminQuiztronImport
end

require 'rails_admin/config/actions'

module RailsAdmin
	module Config
		module Actions
			class QuiztronImport < Base
				RailsAdmin::Config::Actions.register(self)

				register_instance_option :object_level do
					true
				end

				register_instance_option :link_icon do
					'icon-folder-open'
				end

				register_instance_option :visible? do
					authorized?
				end

				register_instance_option :collection? do
					true
				end

				register_instance_option :member? do
					false
				end

				register_instance_option :pjax? do
					true
				end

				register_instance_option :http_methods do
					[:get, :post]
				end

				register_instance_option :route_fragment do
					'quiztron_import'
				end

				register_instance_option :breadcrumb_parent do
					parent_model = bindings[:abstract_model].try(:config).try(:parent)
					am = parent_model
					if am && RailsAdmin.config(parent_model).try(:abstract_model)
						[:index, am]
					else
						[:dashboard]
					end
				end

				register_instance_option :controller do
					proc do
						respond_to do |format|
							format.html do
								quiztron_server_upload_url = ENV['QUIZTRON_SERVER_UPLOAD_URL']
								if quiztron_server_upload_url
									quiztron_uri = URI(quiztron_server_upload_url)
									quiztron_host = "#{quiztron_uri.scheme}://#{quiztron_uri.host}:#{quiztron_uri.port}"

									render template: @action.template_name,
												 locals: {quiztron_server_upload_url: quiztron_server_upload_url, quiztron_host: quiztron_host},
												 status: (flash[:error].present? ? :not_found : 200)
								else
									render template: 'quiztron_no_environment'
								end
							end
						end
					end
				end
			end
		end
	end
end