# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  description  :text             not null
#  price        :integer          not null
#  quantity     :integer          not null
#  manufacturer :string           not null
#  category     :integer          not null
#  is_featured  :boolean          default(FALSE)
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Product < ApplicationRecord
  has_paper_trail

  enum :category, {
    "Music players": 0,
    "Phones": 1,
    "Computers": 2,
    "Wearables": 3,
  }

  belongs_to :user, optional: true

  validates_presence_of :quantity
  validates_presence_of :price
end
