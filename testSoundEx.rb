require 'test/unit'
require 'Soundex.rb'

module TestSoundex
  
  class TestSoundexUnitTest < Test::Unit::TestCase
    
    def testUnitTestTrue
      result = Soundex::Soundex.new("road",true).soundexCode
      assert_equal result, nil
    end
    
    def testUnitTestOmitted
      result = Soundex::Soundex.new("road").soundexCode
      assert_equal result, "R300"
    end
    
    def testUnitTestFalse
      result = Soundex::Soundex.new("road",false).soundexCode
      assert_equal result, "R300"
    end
    
    def testUnitTestRupert
         result = Soundex::Soundex.new("Rupert",false).soundexCode
         assert_equal result, "R163"
    end
    
    def testUnitTestAshcroft
        result = Soundex::Soundex.new("Ashcroft").soundexCode
        assert_equal result, "A261"
    end
    
  end
  
  class TestSoundexFirstChar < Test::Unit::TestCase
    
    def testFirstCharFromLower
      result =  Soundex::Soundex.new("road",true).getFirstChar()
      assert_equal result, "R"
    end
    
    def testFirstCharFromUpper
      result =  Soundex::Soundex.new("Road",true).getFirstChar()
      assert_equal result, "R"
    end
    
    def testFirstCharOnlyOne
      result =  Soundex::Soundex.new("Q",true).getFirstChar()
      assert_equal result, "Q"
    end
    
    def testFirstCharEmpty
      result =  Soundex::Soundex.new("",true).getFirstChar()
      assert_equal result, ""      
    end
    
  end
  
  class TestSoundexVowelRemoval < Test::Unit::TestCase
    def testVowelRemovalLowerCase
      result =  Soundex::Soundex.new("road",true).stripVowels()
      assert_equal result, "rd"
    end
    
    def testVowelRemovalUpperCase
      result =  Soundex::Soundex.new("Road",true).stripVowels()
      assert_equal result, "rd"
    end
    
    def testVowelRemovalNone
      result =  Soundex::Soundex.new("byk",true).stripVowels()
      assert_equal result, "bk"
    end
    
    def testVowelRemovalLast
      result =  Soundex::Soundex.new("thi",true).stripVowels()
      assert_equal result, "t"
    end    
    
    def testVowelRemovalFirst
      se = Soundex::Soundex.new("Wednesday",true)
      result =  se.stripVowels()
      assert_equal result, "dnsd"
    end
    
    def testVowelRemovalAll
      se = Soundex::Soundex.new("Whey",true)
      result =  se.stripVowels()
      assert_equal result, ""
    end
    
  end
  
  class TestTransformLetter < Test::Unit::TestCase
    
    def testTransformb
      se = Soundex::Soundex.new("b",true)
      result = se.transformLetter("b")
      assert_equal result, "1"
    end
    def testTransformf
      se = Soundex::Soundex.new("f",true)
      result = se.transformLetter("f")
      assert_equal result, "1"
    end
    def testTransformp
      se = Soundex::Soundex.new("p",true)
      result = se.transformLetter("p")
      assert_equal result, "1"
    end
    def testTransformb
      se = Soundex::Soundex.new("v",true)
      result = se.transformLetter("v")
      assert_equal result, "1"
    end
    
    # Return 2 
    def testTransformc
         se = Soundex::Soundex.new("c",true)
         result = se.transformLetter("c")
         assert_equal result, "2"
    end
    def testTransformg
      se = Soundex::Soundex.new("g",true)
      result = se.transformLetter("g")
      assert_equal result, "2"
    end
    def testTransformj
      se = Soundex::Soundex.new("j",true)
      result = se.transformLetter("j")
      assert_equal result, "2"
    end
    def testTransformk
      se = Soundex::Soundex.new("k",true)
      result = se.transformLetter("k")
      assert_equal result, "2"
    end
    def testTransformq
      se = Soundex::Soundex.new("q",true)
      result = se.transformLetter("q")
      assert_equal result, "2"
    end
    def testTransforms
      se = Soundex::Soundex.new("s",true)
      result = se.transformLetter("s")
      assert_equal result, "2"
    end
    def testTransformx
      se = Soundex::Soundex.new("x",true)
      result = se.transformLetter("x")
      assert_equal result, "2"
    end
    def testTransformz
      se = Soundex::Soundex.new("z",true)
      result = se.transformLetter("z")
      assert_equal result, "2"
    end
           
    #Return 3
    def testTransformd
      se = Soundex::Soundex.new("d",true)
      result = se.transformLetter("d")
      assert_equal result, "3"
    end
    def testTransformd
      se = Soundex::Soundex.new("t",true)
      result = se.transformLetter("t")
      assert_equal result, "3"
    end
    
    #Return 4
    def testTransforml
      se = Soundex::Soundex.new("l",true)
      result = se.transformLetter("l")
      assert_equal result, "4"
    end
    
    # Return 5
    def testTransformm
      se = Soundex::Soundex.new("m",true)
      result = se.transformLetter("m")
      assert_equal result, "5"
    end
    def testTransformm
      se = Soundex::Soundex.new("n",true)
      result = se.transformLetter("n")
      assert_equal result, "5"
    end
    
    # Return 6
    def testTransformr
      se = Soundex::Soundex.new("r",true)
      result = se.transformLetter("r")
      assert_equal result, "6"
    end
  end
  
  class TestFixLength < Test::Unit::TestCase
    
    def testRightLength
      se =  Soundex::Soundex.new("road",true)
      result = se.fixLength(["1","2","3"])
      assert_equal result, ["1","2","3"]
    end
    
    def testShortLength
      se =  Soundex::Soundex.new("road",true)
      result = se.fixLength(["1"])
      assert_equal result, ["1","0","0"]
    end
    
    def testTooLongLength
      se =  Soundex::Soundex.new("road",true)
      result = se.fixLength(["5","6","1","3"])
      assert_equal result, ["5","6","1"]
    end

  end

  class TestTransform < Test::Unit::TestCase
    def testTransform
      se = Soundex::Soundex.new("road",true)
      result = se.replaceConsonants("rd")
      assert_equal result, "630"
    end
  end

end