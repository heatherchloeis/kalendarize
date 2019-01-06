class StaticController < ApplicationController
  def about
    @title = "About"
  end

  def developer
    @title = "Developer"
  end

  def home
    if logged_in?
      @title = "Home"
      @stream = current_user.streams.build
      @schedule_items = current_user.schedule
      @following_schedule_items = current_user.following_schedule
    end
  end

  def help
    @title = "Help"
  end

  def tutorial
    @title = "Tutorial"
  end
end
