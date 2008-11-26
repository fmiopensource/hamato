module Hamato

	module Glossarize
		mattr_accessor :glossary
	
    def glossarize(string, *args, &block)
      glossarize_string(string, *args.dup, &block)
    end
		
	private
		# traverse elements passed in ('p', 'table') or none for all
		def glossarize_string(text, *args, &block)
			doc = Hpricot(text)
			doc.traverse_element(*args[0].dup) do |e|
				if !glossary.nil? and [Hpricot::Doc, Hpricot::Elem,Hpricot::Text].include?(e.class)
          #glossary.sort{|a, b| a[0].length <=> b[0].length}.each do |k,v|
					glossary.each do |k, v|
						e.text_sub!(Regexp.new("([^-<>])(\\b#{k.to_s}\\b)([^-<>])(?![^<]*>|[^<]*<\/(span|a|b|em|strong)>|[^<]*<br\/>|[^<]*<(sup|em|strong)>)"), '\1<a class="info" href="javascript:void(0);">\2<span>' + word_wrap(v) + '</span></a>\3')
					end
				end
			end
			doc.to_s
		end

		def word_wrap(value)
			#inserts a breakable HTML character every 25 characters
			#this allows all browsers to properly word wrap
			words = value.split(/\s/)
			result = ''
			words.each do |word|
				length = 25
        start_tag = ''
        end_tag =''
        if !word.match(/(<.*>)(.+)(<\/.*>)/)
          to_process = word
        elsif word.match(/^[^<>]/)
          start_tag = word
          to_process = ''
        else
          word.match(/(<.*>)(.+)(<\/.*>)/)
          start_tag = $1
          to_process = $2
          end_tag = $3
        end
          while (length < to_process.length)
            to_process = to_process.insert(length, '&#8203')
            length += 25
          end

					result += " #{start_tag}#{to_process}#{end_tag}" 
			end

			return result
		end
  end
end
