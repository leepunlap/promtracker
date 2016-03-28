class Organization < ActiveRecord::Base
    has_many :webapps
    accepts_nested_attributes_for :webapps #, :reject_if => :all_blank, :allow_destroy => true
end
