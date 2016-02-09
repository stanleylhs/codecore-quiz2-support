class Request < ActiveRecord::Base
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("name ILIKE ? OR email ILIKE ? OR department ILIKE ? OR message ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%") 
  end
end
