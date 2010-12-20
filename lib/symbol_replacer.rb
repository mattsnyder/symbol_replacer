class SymbolReplacer
  
    def initialize(s) 
      @string_to_replace = s
      @already_replaced = []
    end

    def replace
      @string_to_replace.scan(/\$([a-zA-Z]\w*)/).each do |match|
        global_name = match[0] 
        
        if !eval("$" + global_name).nil? && !@already_replaced.include?(global_name) then
          @already_replaced << global_name
          @string_to_replace = @string_to_replace.gsub("$" + global_name, translate(global_name));
        end
      end
      @string_to_replace
    end
    
    def translate(global_name)
      eval("$" + global_name)
    end
        
end
