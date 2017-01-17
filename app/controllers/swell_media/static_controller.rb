module SwellMedia
	class StaticController < ApplicationController

		def home
			# the homepage

			@articles = SwellMedia::Media.none.page(params[:page]).per(10)

			render layout: 'swell_media/homepage'
		end

	end
end
