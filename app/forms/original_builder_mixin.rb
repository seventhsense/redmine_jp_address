
::ActionView::Helpers::FormBuilder.class_eval do
  attr_reader :nested_child_index
  def nested_child_index
    "hello"
  end

   def nested_child_index(name)
          @nested_child_index[name] ||= -1
          @nested_child_index[name] += 1
   end
end
