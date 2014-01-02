###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

with_layout :blog do
  page "/blog/*"
end

set :markdown, {:coderay_line_numbers => nil}

require "active_support/core_ext/array"

helpers do
	def blog_posts
		sitemap.resources.select {|p| p.path =~ /^blog\// }.map do |post|
			{
				page: post,
				date: post.data[:date],
				title: post.data[:blog_title]
			}
		end.select { |post| post[:date] }.sort_by { |post| post[:date] }.reverse
	end

end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :livereload

configure :build do
  activate :minify_css
  activate :minify_javascript
  require "middleman-smusher"
  activate :smusher
end
