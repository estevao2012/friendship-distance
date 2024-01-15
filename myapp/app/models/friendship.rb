class Friendship < ApplicationRecord
  belongs_to :user_source, class_name: 'User', foreign_key: 'user_source_id'
  belongs_to :user_destine, class_name: 'User', foreign_key: 'user_destine_id'
end
