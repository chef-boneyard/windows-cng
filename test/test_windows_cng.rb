require 'test-unit'
require 'windows/cng'

class TC_Windows_CNG < Test::Unit::TestCase
  def setup
    @cng = Windows::CNG.new
  end

  test "version number is set to correct value" do
    assert_equal("0.0.1", Windows::CNG::VERSION)
  end

  def teardown
    @cng.close
  end
end
