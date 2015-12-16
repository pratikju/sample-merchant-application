class WelcomeController < ApplicationController
  def index
  end

  def my_page
    @name = "Pratik Singh"
    @address = "Kolkata"
  end
end
