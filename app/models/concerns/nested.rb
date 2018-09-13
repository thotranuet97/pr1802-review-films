module Nested
  def all_comments
    results = Array.new
    results += self.comments.to_a
    self.comments.each do |comment|
      results += comment.all_comments
    end
    results
  end
end
