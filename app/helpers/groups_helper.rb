module GroupsHelper
  # Returns the class to apply to the attention needed
  # block of a status table.
  def attention_needed_class group
    return "attention-needed" if group.needs_attention?
    return "no-attention-needed"
  end
end
