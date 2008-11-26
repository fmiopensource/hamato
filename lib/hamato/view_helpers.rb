module Hamato
	module ViewHelpers
		def toggle_glossary_link(text='<b>Pop-up Glossary</b><span>Click here to turn on/off pop-up definitions for common terms used throughout this site</span>')
			show = params[:glossary] || session[:glossary]
			link_to text, {:params => params.merge(:glossary => (show.nil? or show == '0' ) ? 1 : 0)}, {:class => 'info'}
    end
	end
end
	