$:.unshift(File.dirname(__FILE__) + '/../lib')

require "test/unit"
require "complexity"

METH_NAME = 'Test#meth'

def meth(src = nil)
  YARD.parse_string("class Test; def meth; #{src} end end") if src
  YARD::Registry.at(METH_NAME).complexity
end

class TestComplexity < Test::Unit::TestCase
  def test_empty_method
    assert_equal 1, meth("")
  end
  
  def test_if
    assert_equal 2, meth("if x == 2 then do_something end")
  end
  
  def test_if_elsif
    assert_equal 3, meth("if x == 2; A elsif x == 3; B end")
  end
  
  def test_if_elsif_else
    assert_equal 4, meth("if x == 2; A elsif x == 3; B; else C end")
  end
  
  def test_case
    assert_equal 5, meth("case X; when 1; A; when 2; B; when 3; C; when 4; D end")
  end
  
  def test_ifop
    assert_equal 5, meth("1 ? 2 : 3 ? 4 : 5")
  end
  
  def test_block
    assert_equal 2, meth("loop do X end")
    assert_equal 4, meth("loop { 1 ? 2 : 1 }")
  end
end