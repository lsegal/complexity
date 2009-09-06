require 'rubygems'
require 'yard'

class ComplexityHandler < YARD::Handlers::Ruby::Base
  handles %r{.*}
  
  BRANCH_TYPES = [:if, :if_mod, :unless, :unless_mod, :when, :elsif, :ifop,
    :while, :while_mod, :until, :until_mod, :for, :do_block, :brace_block, :rescue]
  
  def process
    return unless YARD::CodeObjects::MethodObject === owner
    return unless [:def, :defs].include? statement.parent.parent.type
    
    owner[:complexity] = 1
    statement.parent.last.traverse do |node|
      owner[:complexity] += 1 if BRANCH_TYPES.include?(node.type)
    end
  end
end

class LegacyComplexityHandler < YARD::Handlers::Ruby::Legacy::Base
  handles TkDEF
  
  BRANCH_TYPES = [TkRESCUE, TkENSURE, TkIF, TkIF_MOD, TkELSIF, TkUNLESS,
    TkWHEN, TkWHILE, TkWHILE_MOD, TkUNTIL, TkUNTIL_MOD, TkFOR, TkQUESTION,
    TkLBRACE, TkDO]
  
  def process
    nobj, mscope = namespace, scope
    if statement.tokens.to_s =~ /^def\s+(#{METHODMATCH})/m
      meth = $1.gsub(/\s+/,'')
      if meth =~ /(?:#{NSEPQ}|#{CSEPQ})([^#{NSEP}#{CSEPQ}]+)$/
        mscope, meth = :class, $1
        nobj = P(namespace, $`) unless $` == "self"
      end
      
      obj = MethodObject.new(nobj, meth, mscope)
      obj[:complexity] = 1
      statement.block.each do |token|
        obj[:complexity] += 1 if BRANCH_TYPES.include?(token.class)
      end
    end
  end
end
