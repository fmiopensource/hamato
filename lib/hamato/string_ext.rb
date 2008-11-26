module Hamato
	module StringExt
		def glossarize(*args, &block)
      Hamato.glossarize(self, *args, &block)
    end
		def glossarize!(*args, &block)
      self[0..-1] = Hamato.glossarize(self, *args, &block)
    end
	end
end