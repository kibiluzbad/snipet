class Snippet < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :user  
  
  validates :title, :presence => true
  validates :language, :presence => true
  validates :source, :presence => true
  
  accepts_nested_attributes_for :tags, :allow_destroy => :true

  # Construtor da classe para normalizar o parametro
  # tags que é passado como uma string sendo as tags separadas por espaco.  
  def initialize(attributes=nil)
    normalize_tags_attribute(attributes) unless attributes.nil?
    super(attributes) 
  end
    
  # Sobreescreve o metodo update_attributes para normalizar o parametro
  # tags que é passado como uma string sendo as tags separadas por espaco.
  def update_attributes(attributes)
    normalize_tags_attribute(attributes)
    super(attributes) 
  end  
  
  # Junta a descricao das tags em um string separando por espaco.
  def join_tags
    tags.map {|tag| tag.description}.join(" ") unless tags.nil? || tags.empty?
  end
  
  def owned_by_current_user(current_user)
    user.id == current_user.id unless user.nil? || current_user.nil?
  end
  
  private
  
  # Normaliza o atributo tags passada no hash como uma string contendo as tags
  # separadas por espaco.
  def normalize_tags_attribute(attributes)
    ts =  attributes[:tags].split(" ").map {|m| Tag.find_or_create_by_description(m)}
    attributes[:tags] = ts  
  end
end
