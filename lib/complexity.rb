require 'yard'

class ComplexityHandler < YARD::Handlers::Ruby::Base
  handles %r{.*}
  
  BRANCH_TYPES = [:if, :elsif, :if_mod, :unless, :unless_mod, :else, :when,
    :while, :while_mod, :until, :until_mod, :for, :do_block, :brace_block]
  
  def process
    return unless YARD::CodeObjects::MethodObject === owner
    
    owner[:complexity] ||= 1
    statement.traverse do |node|
      owner[:complexity] += 1 if BRANCH_TYPES.include?(node.type)
    end
  end
end

YARD.parse(ARGV[0] || 'lib/**/*.rb')

YARD::Registry.all(:method).each do |meth|
  meth[:complexity] ||= 1
end

if ARGV.index("--csv")
  puts YARD::Registry.all(:method).map {|m| [m.path, m.complexity].join(',') }
else
  max = 40
  YARD::Registry.all(:method).each {|m| max = m.path.length if m.path.length > max }
  YARD::Registry.all(:method).each do |meth|
    puts "#{meth.path}#{' ' * (max - meth.path.size)}#{meth.complexity}"
  end
end
