# Hamato
require 'hamato/glossarize'
require 'hamato/string_ext'
require 'hamato/hpricot_text_transform'

ActionView::Base.class_eval   { include Hamato::ViewHelpers }
ActionController::Base.class_eval { include Hamato::ControllerHelpers }

String.send :include, Hamato::StringExt

module Hamato
	extend Glossarize
end