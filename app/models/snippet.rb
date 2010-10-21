class Snippet
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title
  field :language
  field :source
  referenced_in :user
  field :tags, :type=>Array
  
  validates :title, :presence => true
  validates :language, :presence => true
  validates :source, :presence => true
  validates :user, :presence => true
  validates :tags, :presence => true
  
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
    tags.map {|tag| tag}.join(" ") unless tags.nil? || tags.empty?
  end 
  
  # Verifica se o usuário logado é o dono desse snippet.
  def owned_by_current_user(current_user)
    user.id == current_user.id unless user.nil? || current_user.nil?
  end
  
  #Recupera todas as tags usando Map/Reduce.
  def self.all_tags(description=nil)
     map = "function() {
        if (!this.tags) {
          return;
        }

        for (index in this.tags) {
          item = this.tags[index];
          if(item && item.match(/^#{description unless description.nil?}/))
            emit(item, 1);
        }
      }"

    reduce = "function(key, values) {
        return values.length;
      };"
      
    result = collection.mapreduce(map, reduce).find  
    result.map{|item| item["_id"]} unless result.nil?
  end
  
  #Recupera todas as languages usando Map/Reduce.
  def self.all_languages(language=nil)
     map = "function() {
         if(this.language.match(/^#{language unless language.nil?}/))
            emit(this.language, 1);
      }"

    reduce = "function(key, values) {
        return values.length;
      };"
      
    result = collection.mapreduce(map, reduce).find  
    result.map{|item| item["_id"]} unless result.nil?
  end
  
  private
  
  # Normaliza o atributo tags passada no hash como uma string contendo as tags
  # separadas por espaco.
  def normalize_tags_attribute(attributes)
    ts =  attributes[:tags].split(" ").map {|m| m}
    attributes[:tags] = ts  
  end
end
