# frozen_string_literal: true
class Account < ApplicationRecord
  belongs_to :user
  has_one :marketplace, dependent: :destroy

  accepts_nested_attributes_for :marketplace

  validates_presence_of :user,
                        :seller_id

  validates_uniqueness_of :seller_id

  validate :check_connection

  private

  def check_connection
    errors.add(:base, message: 'invalid credentials') unless MWS::ImportService.check_connection(self, marketplace)
  end
end
