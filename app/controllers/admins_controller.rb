class AdminsController < ApplicationController
  load_resource :find_by => :slug
  authorize_resource
end
