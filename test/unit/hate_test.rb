require 'test_helper'

class HateTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Hate.new.valid?
  end
end
