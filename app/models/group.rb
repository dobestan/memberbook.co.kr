class Group < ActiveRecord::Base
	has_and_belongs_to_many :users

	has_many :children, :class_name => "Group", :foreign_key => "parent_id"
	belongs_to :parent, :class_name => "Group"
	
	scope :top_level, where(:parent_id => nil)

  def ancestor
    if self.level == 0
      return self
    else
      self.parent.ancestor
    end
  end

	def descendents
    children.map do |child|
      [child] + child.descendents
    end.flatten
  end

  def self_and_descendents
    [self] + descendents
  end

  def descendents_users
    children.map do |child|
      [child.users] + child.descendents_users
    end.flatten
  end
end