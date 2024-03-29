class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_items

  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true, length: {minimum: 10}
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png|)|(http://placehold.it/100x100)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG.'
  }

  def self.latest
    Product.order(:updated_at).last
  end

  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_items
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
