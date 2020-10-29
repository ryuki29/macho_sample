class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # devise_controller?はdeviseのヘルパーメソッドで、もしdeviseに関するコントローラーの処理であれば、その時だけ実行する

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
