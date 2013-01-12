module Oecompiler
 class Compiler
  def initialize(cont)
# tokens
   @Stable = Hash.new
   @Stable["zone"] 		= 1
   @Stable["string"] 		= 2
   @Stable["do"] 		= 3
   @Stable["end"] 		= 4
   @Stable["firewall"] 		= 5
   @Stable["volume"] 		= 6
   @Stable["server"] 		= 7
   @Stable["source"] 		= 8
   @Stable["sport"] 		= 9	
   @Stable["dport"] 		= 10
   @Stable["size"] 		= 11
   @Stable["count"] 		= 12
   @Stable["offer"] 		= 13
   @Stable["image"] 		= 14
   @Stable["role"] 		= 15
   @Stable["deployment"] 	= 16
   @Stable["integer"] 		= 17
   @Stable["protocol"]		= 18
   @Stable["subzone"]		= 19
   @Stable["escalar"]		= 20
   @Stable["keypair"]		= 21
   @Stable["publickey"]         = 22
   @Stable["privatekey"]        = 23
   @Stable["rule"]              = 24
   @Stable["groupvolume"]       = 25
#State Table  
   @StateTable = Hash.new
   @StateTable["$"] 		= 0
   @StateTable["A"] 		= 1
   @StateTable["B"] 		= 2
   @StateTable["B1"] 		= 3
   @StateTable["C"] 		= 4
   @StateTable["C1"] 		= 5
   @StateTable["D"] 		= 6
   @StateTable["D1"] 		= 7
   @StateTable["E"]             = 8
   @StateTable["E1"]            = 9
# DSL rules
   @Rtable=[]
   @Rtable[0]="zone A "
   @Rtable[1]="string do D end $"
   @Rtable[2]="firewall B1"
   @Rtable[3]="volume B1"
   @Rtable[4]="server B1"
   @Rtable[5]="string do C end B"
   @Rtable[6]="source string C1"
   @Rtable[7]="sport integer C1"
   @Rtable[8]="dport integer C1"
   @Rtable[9]="size integer C1"
   @Rtable[10]="count integer C1"
   @Rtable[11]="offer string C1"
   @Rtable[12]="image string C1"
   @Rtable[13]="role string C1"
   @Rtable[14]="deployment string C1"
   @Rtable[15]=nil
   @Rtable[16]="protocol string C1"
   @Rtable[17]="subzone D1"
   @Rtable[18]="string do B end D"
   @Rtable[19]="firewall string C1"
   @Rtable[20]="escalar string C1"
   #@Rtable[21]="keypair E"
   @Rtable[21]="keypair B1"
   #@Rtable[22]="publickey string E1"
   #@Rtable[23]="privatekey string E1"
   @Rtable[22]="publickey string C1"
   @Rtable[23]="privatekey string C1"
   @Rtable[24]="rule do C end C1"
   @Rtable[25]="keypair string E1"
   @Rtable[26]="string do E end D"
   @Rtable[27]="groupvolume B1"
   @Rtable[28]="keypair string C1"
   @Rtable[29]="groupvolume string C1"
#Stack
   @Stack = []
   @Stack.push "$$"
   @Stack.push "$"
   @Ttable = Array.new(10) {Array.new(30)}
#               $$, zone, string,  do, end, firewall, volume, server, source, sport, dport, size, count, offer, image, rol, deploy, integer, protocol, subzone, escalar, keypair, publickey, privatekey, rule, groupvolume
   @Ttable[0]= [nil,   0,    nil, nil, nil,      nil,    nil,    nil,    nil,   nil,   nil,  nil,   nil,   nil,   nil, nil,    nil,     nil,      nil,     nil,     nil, nil,     nil,       nil,        nil,  nil] # $
   @Ttable[1]= [nil, nil,      1, nil, nil,      nil,    nil,    nil,    nil,   nil,   nil,  nil,   nil,   nil,   nil, nil,    nil,     nil,      nil,     nil,     nil, nil,     nil,       nil,        nil,  nil] # A
   @Ttable[2]= [nil, nil,    nil, nil,  15,        2,      3,      4,    nil,   nil,   nil,  nil,   nil,   nil,   nil, nil,    nil,     nil,      nil,     nil,     nil, 21,     nil,       nil,        24,   27] # B
   @Ttable[3]= [nil, nil,      5, nil, nil,      nil,    nil,    nil,    nil,   nil,   nil,  nil,   nil,   nil,   nil, nil,    nil,     nil,      nil,     nil,     nil, nil,     nil,       nil,        nil,  nil] # B1
   @Ttable[4]= [nil, nil,    nil, nil, nil,       19,    nil,    nil,      6,     7,     8,    9,    10,    11,    12,  13,     14,     nil,       16,     nil,      20, 28,     22,        23,        24,    29] # C
   @Ttable[5]= [nil, nil,    nil, nil,  15,       19,    nil,    nil,      6,     7,     8,    9,    10,    11,    12,  13,     14,     nil,       16,     nil,      20, 28,     22,        23,        24,    29] # C1
   @Ttable[6]= [nil, nil,    nil, nil,  15,      nil,    nil,    nil,    nil,   nil,   nil,  nil,   nil,   nil,   nil, nil,    nil,     nil,      nil,      17,     nil, nil,     nil,       nil,        nil,  nil] # D
   @Ttable[7]= [nil, nil,     18, nil, nil,      nil,    nil,    nil,    nil,   nil,   nil,  nil,   nil,   nil,   nil, nil,    nil,     nil,      nil,     nil,     nil, nil,     nil,       nil,        nil,  nil] # D1
   @Ttable[8]= [nil, nil,     26, nil,  nil,      nil,    nil,    nil,    nil,   nil,   nil,  nil,   nil,   nil,   nil, nil,    nil,     nil,      nil,     nil,     nil, 21,      22,        23,        nil,  nil] # E
   @Ttable[9]= [nil, nil,     nil, nil,  15,      nil,    nil,    nil,    nil,   nil,   nil,  nil,   nil,   nil,   nil, nil,    nil,     nil,      nil,     nil,     nil,  21,      22,        23,       nil,  nil] # E1
   @content = cont
  end

  def checkGrammar
    c = @content.split
    while c.size > 0
      nextWord = c.first
      if nextWord =~ /\"[a-zA-Z0-9.:\\\/\-]+\"/
        nextWord = "string"
      elsif nextWord =~ /[0-9]+/
	nextWord = "integer"
      end
      topStack = @Stack.last
      if nextWord == topStack
         c.shift
         @Stack.pop
      else
	if not @StateTable.has_key? topStack
	  raise "Error Expecting ... #{topStack} ... got instead #{nextWord}"
        end
        if not @Stable.has_key? nextWord
	  raise "Error word ... #{nextWord} not valid"
	end
        if @Ttable[@StateTable[topStack]][@Stable[nextWord]] != nil
	  if @Ttable[@StateTable[topStack]][@Stable[nextWord]] == 15
            @Stack.pop
          else
            @Stack.pop
	    @Rtable[@Ttable[@StateTable[topStack]][@Stable[nextWord]]].split.reverse.each do |nt|
	      @Stack.push nt
	    end
          end 
        else
	  raise "Error unexpected word #{nextWord}"
        end
      end
    end
  end
#Class end
 end
#MOdule end
end
