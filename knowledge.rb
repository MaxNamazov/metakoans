class Module
  def attribute(variable, &block)
    if variable.is_a?(Hash)
      name = variable.keys.first
      def_value = variable.values.first
    else
      name = variable
      def_value = nil
      # def_value = (block_given?) ? instance_eval(&block) : nil   #???????????????
    end

    define_method(:"#{name}?") { send(:"#{name}") }

    define_method(:"#{name}=") { |value| instance_variable_set(:"@#{name}", value) }

    define_method(:"#{name}") do
      if instance_variable_defined?(:"@#{name}")
        instance_variable_get(:"@#{name}")
      else
        (block_given?) ? instance_eval(&block) : def_value
      end
    end
  end
end