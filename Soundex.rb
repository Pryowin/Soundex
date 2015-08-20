module Soundex
  class Soundex
    
    @editedString = String.new()
    MAX_LENGTH = 3
    FILL_CHAR = "0"
    
    def initialize(paramString,isUnitTest=false)
      @editedString = paramString.downcase
    
      if !isUnitTest
        @soundexCode = getFirstChar()
        @editedString = @editedString[1..-1]
        @editedString = stripVowels()
        @editedString = replaceConsonants(@editedString)
        @soundexCode.concat(@editedString)
       
      end
    end
    
    def soundexCode
      return @soundexCode
    end
    
    def getFirstChar()
      if @editedString != ""
        firstChar = @editedString[0]
        return firstChar.upcase
      else
        return ""
      end
    end
    
    def stripVowels()
      return @editedString.gsub(/[aeiouyhw]/,"")
    end
    
    def transformLetter(s1)
      case s1
      when "b","f","p","v"
        return "1"
      when "c","g","j","k","q","s","x","z"
        return "2"
      when "d","t"
        return "3"
      when "l"
        return "4"
      when "m","n"
        return "5"
      when "r"
        return "6"
      else
        return ""
      end
    end
    
    def replaceConsonants(s1)
      
      lastTransform = ""
      transformedLetter = ""
      transformedChars = Array.new
      
      s1.split("").each do |char|
        transformedLetter = transformLetter(char)
        if transformLetter(char) != lastTransform
          transformedChars.push(transformedLetter)
        end
        lastTransform = transformedLetter
      end
      
      fixedLength = fixLength(transformedChars)
      return fixedLength.join()
      
    end
    
    def fixLength(a1)

      len = a1.length
      if len > MAX_LENGTH
        return a1[0..MAX_LENGTH - 1]
      end
      if len < 3
        return a1.fill(FILL_CHAR,len, MAX_LENGTH-len)
      end
      return a1
      
    end
        
    
  end
  
end