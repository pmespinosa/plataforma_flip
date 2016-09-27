Rails.application.routes.draw do

  resources :registers
  resources :home
  devise_for :users
  resources :users

#--- Pensamiento Crítico y Evaluación Formativa (Pablo) ---
  resources :content_choices
  resources :ct_choices
  #resources :trees
  resources :ct_subhabilities

  post '/courses/:course_id/trees/:id' => 'trees#edx_view'

  resources :courses do
    resources :trees do
      resources :ct_questions do
        resources :ct_habilities
      end
      resources :content_questions
      resources :feedbacks
      resources :contents
    end
  end
#---  Actividades Colaborativas ---
  get 'homeworks/:id/studentanswer', to:"homeworks#answers"

  post 'courses/new' => 'courses#agregate'
  post 'courses/:id/edit' => 'courses#edit'
  patch 'courses/:id/edit'=> 'courses#edit'
  get 'courses/:id/users'=> 'courses#students'
  post 'courses/:id/eval_form', to:'courses#eval_form', as: "eval_form"
  get 'courses/:id/eval_form', to:'courses#eval_form'

  get 'homework/:id/asistencia', to:'homeworks#asistencia', as:"homework_asistencia"
  post 'homework/:id/asistencia',to:'homeworks#asistencia'
  post 'homework/:id/edit',to:'homeworks#edit'
  get 'homework/:id/edit',to:'homeworks#edit'
  resources :courses do
    resources :users do
      resources :homeworks
    end
  end

  post  'homeworks/:id' => 'homeworks#change_phase'
  resources :homeworks do
    resources :answers
  end

  root 'home#home'

end
