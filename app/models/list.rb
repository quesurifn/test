class List < ApplicationRecord
    belongs_to :user
    validates_presence_of :title
    has_many :tasks, dependent: :destroy
    audited
end
