class Request < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  # Pt 4 Search
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("name ILIKE ? OR email ILIKE ? OR department ILIKE ? OR message ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%") 
  end
end
