require 'matrix'
require 'natto'

class Cosine
    def self.split_words(content)
      natto = Natto::MeCab.new
      sep = natto.enum_parse(content)
      @res = Array.new
      
      loop do
        e = sep.next
        enext = sep.peek
        if e.feature =~ /^(?:名詞,固有名詞|名詞,一般)/ and enext.feature =~ /^(?:名詞,固有名詞|名詞,一般)/
          e.surface = e.surface + enext.surface
          enext.surface = nil
          enext.feature = nil
        end
        @res.push(e)
      end
      return @res
    end
    
    
    
    
    
    def self.count(res)
      @tf = Hash.new
      res.each do |word|
        if(@tf.key?(word))
          @tf[word] += 1
        else
          @tf[word] = 1
        end
      end
      return @tf
    end
    
    def self.calculate(content, subsets)
      a1 = split_words(content)
      a1 = count(a1)
      #v1 = Vector.elements(a1, copy=true)
      @similar = Array.new
      
      subsets.each do |subset|
      #subsets.each_with_index do |subset, index|
        a2 = split_words(subset.program)
        a2 = count(a2)
        puts a1.class
        #v2 = Vector.elements(a2, copy=true)
        a3 = a1.merge(a2)
        a3.each do |key,value|
          a1[key] = 0 if a1[key].blank?
          a2[key] = 0 if a2[key].blank?
        end
        v1 = a1.map{|key,val|val}
        v2 = a2.map{|key,val|val}
        vector1 = Vector.elements(v1, copy=true)
        vector2 = Vector.elements(v2, copy=true)
        cosine = vector2.inner_product(vector1) / (vector1.norm() * vector2.norm())
        @similar.push(cosine)
      end
      return @similar
    end
end