module ApplicationHelper

	def redcloth(text)
		return raw RedCloth.new(text).to_html
	end

	def label_for_param(param_controller)
		param_controller.gsub("admin/", "").gsub("_", " ").titleize
	end

end
