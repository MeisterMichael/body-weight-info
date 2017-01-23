Rails.application.routes.draw do

	mount SwellEcom::Engine, :at => '/'
	mount SwellFitness::Engine, :at => '/'
	mount SwellMedia::Engine, :at => '/'

end
