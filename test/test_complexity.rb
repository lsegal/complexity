$:.unshift(File.dirname(__FILE__) + '/../lib')

require "test/unit"
require "complexity"

def meth(src = nil)
  YARD.parse_string("class Test; def meth; #{src} end end") if src
  YARD::Registry.at('Test#meth').complexity
end

class TestComplexity < Test::Unit::TestCase
  def test_empty_method
    assert_equal 1, meth("")
  end
  
  def test_if
    meth("if x == 2 then do_something end")
    assert_equal 2, meth
  end
  
  def test_if_elsif
    meth("if x == 2; A elsif x == 3; B end")
    assert_equal 3, meth
  end
end