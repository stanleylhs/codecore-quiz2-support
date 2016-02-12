class Request < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true

  DEPT_SALES = "Sales"
  DEPT_MARKETING = "Marketing"
  DEPT_TECHNICAL = "Technical"

  after_initialize :set_defaults

  private

  def set_defaults
    self.done ||= false
    self.department ||= DEPT_SALES
  end


  # Pt 4 Search
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("name ILIKE :search OR email ILIKE :search OR department ILIKE :search OR message ILIKE :search", search: "%#{query}%") 
  end
end
