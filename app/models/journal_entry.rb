class JournalEntry < ActiveRecord::Base
  has_many :exercises
end
