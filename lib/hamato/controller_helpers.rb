module Hamato
	module ControllerHelpers
		def set_glossary(string, glossary, *args, &block)
			return if glossary.nil? or string.nil? 
			
			if show_glossary?
				use_glossary(glossary)
				string.glossarize!(*args.dup, &block)
			end
		end
		
		def show_glossary?
			session[:glossary] = params[:glossary] || session[:glossary]
			return (!session[:glossary].nil? and session[:glossary] == '1')
		end
	private
		
		def use_glossary(glossary)
			Hamato::Glossarize.glossary = glossary
    end
  end
end