class StaticController < ApplicationController
  def about
    @title = "About"
  end

  def developer
    @title = "Developer"
  end

  def home
    @title = "Home"
  end

  def help
    @title = "Help"
  end

  def tutorial
    @title = "Tutorial"
  end
end
