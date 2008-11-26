# By Henrik Nyh <http://henrik.nyh.se> 2007-03-28.
# Based on http://vemod.net/code/hpricot_goodies/hpricot_text_gsub.rb.
# Licensed under the same terms as Ruby.

require 'rubygems'
require 'hpricot'

module HpricotTextTransform
  module NodeWithChildrenExtension
    def text_gsub!(*args, &block)
      children.each {|x| x.text_gsub!(*args, &block) if [Hpricot::Doc, Hpricot::Elem,Hpricot::Text].include?(x.class)}
    end
    
    def text_sub!(*args, &block)
      children.each {|x| x.text_sub!(*args, &block) if [Hpricot::Doc, Hpricot::Elem,Hpricot::Text].include?(x.class) and ((x.class == Hpricot::Elem and x.stag.name != 'a') or Hpricot::Text == x.class)} 
    end
  end
  
  module TextNodeExtension
    def text_gsub!(*args, &block)
      content.gsub!(*args, &block)
    end
    
    def text_sub!(*args, &block)
      content.sub!(*args, &block)
    end
  end
end

Hpricot::Doc.send(:include,  HpricotTextTransform::NodeWithChildrenExtension)
Hpricot::Elem.send(:include, HpricotTextTransform::NodeWithChildrenExtension)
Hpricot::Text.send(:include, HpricotTextTransform::TextNodeExtension)