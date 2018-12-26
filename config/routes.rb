Rails.application.routes.draw do
	root	'static#home'
  get 	'/about',								to: "static#about"
  get 	'/developer',						to: "static#developer"
  get 	'/help',								to: "static#help"
  get 	'/tutorial',						to: "static#tutorial"
end
