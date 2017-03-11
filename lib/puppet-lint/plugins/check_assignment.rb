# Public: Test the manifest tokens for variables that contain a dash and
# record a warning for each instance found.
#
# No style guide reference
PuppetLint.new_check(:variable_assignment) do
  ASSIGNMENT = Set[:EQUALS]

  def check
    tokens.select { |r| ASSIGNMENT.include? r.type }.each do |token|
      if token.prev_token.type != :WHITESPACE
        notify :warning, {
          :message => "space missing to the left of #{token.value}",
          :line    => token.line,
          :column  => token.column,
        }
      end

      if token.next_token.type != :WHITESPACE
        notify :warning, {
          :message => "space missing to the right of #{token.value}",
          :line    => token.line,
          :column  => token.column,
        }
      end
    end
  end
end
