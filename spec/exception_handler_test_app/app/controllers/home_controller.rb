class HomeController < ApplicationController
  def controller_error
    nil.foo
    render(:text => 'did not fail')
  end

  def model_error
    s = StoredException.new
    s.failure
    render(:text => 'did not fail')
  end

  def view_error
  end

  def syntax_error
    eval("arr = [")
    render(:text => 'did not fail')
  end
end
