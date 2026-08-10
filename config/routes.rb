Rails.application.routes.draw do
  root to: redirect("#{ApplicationResource.endpoint_namespace}/vandal")

  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    mount VandalUi::Engine, at: '/vandal'

    resources :milestones
    resources :tasks
    resources :notes
    resources :teams
    resources :departments
    resources :positions
    resources :employees
  end
end
