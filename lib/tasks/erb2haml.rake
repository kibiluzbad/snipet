class ToHaml
  def initialize(path)
    @path = path
  end
    
  def convert!
    Dir["#{@path}/**/*.erb"].each do |file|
      `html2haml -rx #{file} #{file.gsub(/\.erb$/, '.haml')}`
    end
  end
end

namespace :erb do
	desc "Converts all erb files inside app/views into haml files."	
	task :to_haml => :environment do	
        path = File.join(File.dirname(__FILE__), '../../app', 'views')
        ToHaml.new(path).convert!
  end
  
  desc "Removes all erb files inside app/views."	
	task :destroy do	
        path = File.join(File.dirname(__FILE__), '../../app', 'views')
        Dir["#{path}/**/*.erb"].each do |file|
          File.delete(file)
        end
  end
end
