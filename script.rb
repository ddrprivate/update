#encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'nokogiri' 
require 'open-uri'
require 'pony'
require 'sendgrid-ruby'
require 'sinatra/base'
require 'set'
require 'sinatra/activerecord'
require './config/environments' #database configuration

class Album < ActiveRecord::Base
end

class Application < Sinatra::Base
  configure do
  
    Pony.options = {
      :via => :smtp,
      :via_options => {
        :address => 'smtp.sendgrid.net',
        :port => '587',
        :domain => ENV['SENDGRID_DOMAIN'],
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => :plain,
        :enable_starttls_auto => true
      }
    }
  end

 
end

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

def assonance mot 
	def voyelle v
	 if v=="a" || v=="e" || v=="i" || v=="o" || v=="u" || v=="y" || v=="é" || v=="è" || v=="ê" || v=="î" || v=="û" || v=="ô"
			return true 
		else
			return false 
		end 
	end 

	def consonne c 
	 if c=="b" || c=="c" || c=="d" || c=="f" || c=="g" || c=="h" || c=="j" || c=="k" || c=="l" || c=="m" || c=="n" || c=="p" || c=="q" || c=="r" || c=="s" || c=="t" || c=="v"|| c=="w" || c=="x" || c=="z"
			return true
		else
			return false 
		end 
	end 

	def rimeasso(dico, mot)
		output = "rime.txt"
		File.open(dico, "r:UTF-8").each_line do |line|
			x=0 
			while x < line.length
				if (consonne line[x].to_s) && (voyelle line[x+1].to_s) && (voyelle line[x+2].to_s)
					match = line[x].to_s + line[x+1].to_s + line[x+2].to_s
					if match == mot
						File.open output, 'a' do |f| 
							f.puts line.capitalize 
						end 
					end 
				elsif (consonne line[x].to_s) && (voyelle line[x+1].to_s) 
					match = line[x].to_s + line[x+1].to_s 
					if match == mot
						File.open output, 'a' do |f| 
							f.puts line.capitalize 
						end 
					end 
				end 
				x =x+1
			end 	
		end
	end

	 
	i=0
	count=0
	mot = mot.downcase 
	while (i < mot.length) && (count < 5)
			y = mot.length
		if (consonne mot[i].to_s) && (voyelle mot[i+1].to_s) && (voyelle mot[i+2].to_s)
			combi = mot[i].to_s + mot[i+1].to_s + mot[i+2].to_s
			puts combi
			count = count+1
			rimeasso("dico_final.txt", combi)
		elsif (consonne mot[i].to_s) && (voyelle mot[i+1].to_s)
			combi = mot[i].to_s + mot[i+1].to_s
			puts combi
			count = count+1
			rimeasso("dico_final.txt", combi) 
		end 
		i =i+1
		
	end 
end
def phonetique mot, dic
	def voyelle v
	 if v=="a" || v=="e" || v=="i" || v=="o" || v=="u" || v=="y" || v=="é" || v=="è" || v=="ê" || v=="î" || v=="û" || v=="ô"
			return true 
		else
			return false 
		end 
	end 

	def consonne c 
	 if c=="b" || c=="c" || c=="d" || c=="f" || c=="g" || c=="h" || c=="j" || c=="k" || c=="l" || c=="m" || c=="n" || c=="p" || c=="q" || c=="r" || c=="s" || c=="t" || c=="v"|| c=="w" || c=="x" || c=="z"
			return true
		else
			return false 
		end 
	end 
	def a x
		if x=="a" || x=="oi"
			return true 
		end
	end
	def ai x
		if x=="ai" || x=="er" || x=="ez" || x=="é" || x=="è" || x=="ê" || x=="e"
			return true
		end
	end
	def i x
		if x=="i" || x=="î"
			return true 
		end
	end
	def eu x
		if x=="eu" || x=="oeu"
			return true
		end
	end
	def au x
		if x=="au" || x=="o" || x=="ô"
			return true 
		end
	end
	def u x
		if x=="u" || x=="û"
			return true 
		end
	end
	def ou x
		if x=="ou" || x=="oo"
			return true
		end
	end
	def an x
		if x=="an" || x=="en" || x=="aon"
			return true
		end
	end
	def un x
		if x=="in" || x=="ien" || x=="ain" || x=="ein" 
			return true
		end
	end
	def on x
		if x=="on"
			return true
		end
	end
	
	def rimephono(dico, mot)
		output = "rime3.txt"
		File.open(dico, "r:UTF-8").each_line do |line|
			x=0 
			while x < line.length 
				line2= line[x].to_s + line[x+1].to_s
				line3= line[x].to_s + line[x+1].to_s + line[x+2].to_s
				if ((an line3) && (an mot)) || ((un line3) && (un mot)) || ((eu line3) && (eu mot))
						File.open output, 'a' do |f| 
							f.puts line.capitalize unless ((an line3) && (voyelle line[x+2].to_s))
						end
						x=x+3
				else
					if ((an line2) && (an mot)) || ((un line2) && (un mot)) || ((on line2) && (on mot)) || ((ou line2) && (ou mot)) || ((eu line2) && (eu mot)) || ((au line2) && (au mot)) || ((ai line2) && (ai mot)) || ((a line2) && (a mot))
						ex1 = line[x].to_s.downcase + line[x+1].to_s.downcase
						ex3 = line[x].to_s.downcase + line[x+1].to_s.downcase + line[x+2].to_s.downcase
						y = line.length
						ey1 = line[y-1]
						File.open output, 'a' do |f| 
							f.puts line.capitalize unless ((ai line[x]) && ((ex3 == "eur" ) || (ey1 == "e") || (ex1 == "ea") || (ex1 == "eu") || (ex1 == "eo") || (ex1 == "en"))) || ((an line2) && (voyelle line[x+2].to_s))
						end 
						x=x+2
					else 
						if ((a line[x]) && (a mot)) || ((i line[x]) && (i mot)) || ((au line[x]) && (au mot)) || ((u line[x]) && (u mot)) || ((ai line[x]) && (ai mot)) 
								File.open output, 'a' do |f| 
									ex2 = line[x-1].to_s.downcase + line[x].to_s.downcase
									ex3 = line[x].to_s.downcase + line[x+1].to_s.downcase + line[x+2].to_s.downcase
									ex1 = line[x].to_s.downcase + line[x+1].to_s.downcase
									ex4 = line[x].to_s.downcase + line[x+1].to_s.downcase + line[x+2].to_s.downcase + line[x+3].to_s.downcase
									ex5 = line[x].to_s.downcase + line[x+1].to_s.downcase + line[x+2].to_s.downcase + line[x+3].to_s.downcase + line[x+4].to_s.downcase
									y = line.length
									ey1 = line[y-1]
									ey2 = line[y-2] + line[y-1]
									ey3 = line[y-3] + line[y-2] + line[y-1]
									ey4 = line[y-4] + line[y-3] + line[y-2] + line[y-1]
									f.puts line.capitalize unless ((u line[x]) && (ex2 == "ou" || ex2 == "au" || ex2 == "eu" || ex2 == "qu")) || ((ai line[x]) && ((ex3 == "eur" ) || (ey1 == "e") || (ex1 == "ea") || (ex1 == "eu") || (ex1 == "eo") || (ex1 == "en"))) || ((au line[x]) && (ex3 == "omb" || ex3 == "omp" || ex1 == "ou" || ex1 == "oi" || ey2 == "on")) || ((a line[x]) && ( ((ex1 == "ai") && (ex5 != "aille")) || (ex1 == "an") || (ex1 == "au"))) || ((i line[x]) && ((ex2 == "oi") || (ex2 == "ai") || (ey2 == "in") || (ey3 == "ion") || (ey4 == "ions")))
								end  
								x=x+1
						else
							x=x+1
							
						end
					end
				end
			end 	
		end
	end
	
	i=0
	exist = Array.new
	exist = []
	puts mot.length
	while i < mot.length
				mot2= mot[i].to_s + mot[i+1].to_s
				mot3= mot[i].to_s + mot[i+1].to_s + mot[i+2].to_s
				y = mot.length
				ey1 = mot[y-1]
				if (an mot3) || (un mot3) || (eu mot3)
					combi = mot3
					
					puts combi unless exist.include?(combi)
					rimephono(dic, combi) unless exist.include?(combi)
					exist.push(combi) unless exist.include?(combi)
					i =i+3
				else
					if (an mot2) || (un mot2) || (on mot2) || (ou mot2) || (eu mot2) || (au mot2) || (ai mot2) || (a mot2)
						combi = mot2 unless ((mot2 == "an" && (voyelle mot[i+2])) || ((ai mot2) && (ey1=="e")))
						puts combi unless exist.include?(combi)
						rimephono(dic, combi) unless exist.include?(combi)
						exist.push(combi) unless exist.include?(combi)
						i =i+2
					else 
						if (a mot[i]) || (ai mot[i]) || (i mot[i]) || (au mot[i]) || (u mot[i])
							combi = mot[i] unless (mot[i] == "e") && (ey1=="e")
							puts combi unless exist.include?(combi)
							rimephono(dic, combi) unless exist.include?(combi)
							exist.push(combi) unless exist.include?(combi)
							i =i+1
						else
							i =i+1
						end
					end 
				end
	end 

end
def rimesr mot
	l = mot.length
	
	out8 = mot[l-8].to_s + mot[l-7].to_s + mot[l-6].to_s + mot[l-5].to_s + mot[l-4].to_s + mot[l-3].to_s + mot[l-2].to_s + mot[l-1].to_s unless l < 8
	out7 = mot[l-7].to_s + mot[l-6].to_s + mot[l-5].to_s + mot[l-4].to_s + mot[l-3].to_s + mot[l-2].to_s + mot[l-1].to_s unless l < 7
	out6 = mot[l-6].to_s + mot[l-5].to_s + mot[l-4].to_s + mot[l-3].to_s + mot[l-2].to_s + mot[l-1].to_s unless l < 6
	out5 = mot[l-5].to_s + mot[l-4].to_s + mot[l-3].to_s + mot[l-2].to_s + mot[l-1].to_s unless l < 5
	out4 = mot[l-4].to_s + mot[l-3].to_s + mot[l-2].to_s + mot[l-1].to_s unless l < 4
	out3 = mot[l-3].to_s + mot[l-2].to_s + mot[l-1].to_s unless l < 3
	output = "rime2.txt"
	File.open("dico_final.txt", "r:UTF-8").each_line do |line|
		l = line.length
		line8 = line[l-9].to_s + line[l-8].to_s + line[l-7].to_s + line[l-6].to_s + line[l-5].to_s + line[l-4].to_s + line[l-3].to_s + line[l-2].to_s + line[l-1].to_s unless l < 8
		line7 = line[l-8].to_s + line[l-7].to_s + line[l-6].to_s + line[l-5].to_s + line[l-4].to_s + line[l-3].to_s + line[l-2].to_s + line[l-1].to_s unless l < 7
		line6 = line[l-7].to_s + line[l-6].to_s + line[l-5].to_s + line[l-4].to_s + line[l-3].to_s + line[l-2].to_s + line[l-1].to_s unless l < 6
		line5 = line[l-6].to_s + line[l-5].to_s + line[l-4].to_s + line[l-3].to_s + line[l-2].to_s + line[l-1].to_s unless l < 5
		line4 = line[l-5].to_s + line[l-4].to_s + line[l-3].to_s + line[l-2].to_s unless l < 4
		
		if (line8 == out8) && (line8 != nil )
			File.open output, 'a' do |f|
								f.puts line.capitalize 
							end
		elsif line7 == out7 && (line7 != nil )
			File.open output, 'a' do |f| 
								f.puts line.capitalize 
							end
		elsif line6 == out6 && (line6 != nil )
			File.open output, 'a' do |f| 
								f.puts line.capitalize 
							end
		elsif line5 == out5 && (line5 != nil )
			File.open output, 'a' do |f| 
								f.puts line.capitalize 
							end
		elsif line4 == out4 && (line4 != nil )
			File.open output, 'a' do |f| 
								f.puts line.capitalize 
							end
		end
		
	end 
	File.open("dico_final.txt", "r:UTF-8").each_line do |line|
		l = line.length
		line3 = line[l-4].to_s + line[l-3].to_s + line[l-2].to_s unless l < 3
		if line3 == out3 && (line3 != nil )
			File.open output, 'a' do |f| 
								f.puts line.capitalize 
							end
		end
	end
end

def rimesp mot, dic
	def voyelle v
	 if v=="a" || v=="e" || v=="i" || v=="o" || v=="u" || v=="y" || v=="é" || v=="è" || v=="ê" || v=="î" || v=="û" || v=="ô"
			return true 
		else
			return false 
		end 
	end 

	def consonne c 
	 if c=="b" || c=="c" || c=="d" || c=="f" || c=="g" || c=="h" || c=="j" || c=="k" || c=="l" || c=="m" || c=="n" || c=="p" || c=="q" || c=="r" || c=="s" || c=="t" || c=="v"|| c=="w" || c=="x" || c=="z"
			return true
		else
			return false 
		end 
	end 
	def a x
		if x=="a" || x=="oi"
			return true 
		end
	end
	def ai x
		if x=="ai" || x=="er" || x=="ez" || x=="é" || x=="è" || x=="ê" || x=="e"
			return true
		end
	end
	def i x
		if x=="i" || x=="î"
			return true 
		end
	end
	def eu x
		if x=="eu" || x=="oeu"
			return true
		end
	end
	def au x
		if x=="au" || x=="o" || x=="ô"
			return true 
		end
	end
	def u x
		if x=="u" || x=="û"
			return true 
		end
	end
	def ou x
		if x=="ou" || x=="oo"
			return true
		end
	end
	def an x
		if x=="an" || x=="en" || x=="aon"
			return true
		end
	end
	def un x
		if x=="in" || x=="ien" || x=="ain" || x=="ein" 
			return true
		end
	end
	def on x
		if x=="on"
			return true
		end
	end
	
	def rimephono(dico, mot)
		output = "rime3.txt"
		File.open(dico, "r:UTF-8").each_line do |line|
			x=0 
			longueur = line.length
			x = (longueur/2).round
			while x < longueur 
				line2= line[x].to_s + line[x+1].to_s
				line3= line[x].to_s + line[x+1].to_s + line[x+2].to_s
				if ((an line3) && (an mot)) || ((un line3) && (un mot)) || ((eu line3) && (eu mot))
						File.open output, 'a' do |f| 
							f.puts line.capitalize unless ((an line3) && (voyelle line[x+2].to_s))
						end
						x=x+3
				else
					if ((an line2) && (an mot)) || ((un line2) && (un mot)) || ((on line2) && (on mot)) || ((ou line2) && (ou mot)) || ((eu line2) && (eu mot)) || ((au line2) && (au mot)) || ((ai line2) && (ai mot)) || ((a line2) && (a mot))
						ex1 = line[x].to_s.downcase + line[x+1].to_s.downcase
						ex3 = line[x].to_s.downcase + line[x+1].to_s.downcase + line[x+2].to_s.downcase
						y = line.length
						ey1 = line[y-1]
						File.open output, 'a' do |f| 
							f.puts line.capitalize unless ((ai line[x]) && ((ex3 == "eur" ) || (ey1 == "e") || (ex1 == "ea") || (ex1 == "eu") || (ex1 == "eo") || (ex1 == "en"))) || ((an line2) && (voyelle line[x+2].to_s))
						end 
						x=x+2
					else 
						if ((a line[x]) && (a mot)) || ((i line[x]) && (i mot)) || ((au line[x]) && (au mot)) || ((u line[x]) && (u mot)) || ((ai line[x]) && (ai mot)) 
								File.open output, 'a' do |f| 
									ex2 = line[x-1].to_s.downcase + line[x].to_s.downcase
									ex3 = line[x].to_s.downcase + line[x+1].to_s.downcase + line[x+2].to_s.downcase
									ex1 = line[x].to_s.downcase + line[x+1].to_s.downcase
									ex4 = line[x].to_s.downcase + line[x+1].to_s.downcase + line[x+2].to_s.downcase + line[x+3].to_s.downcase
									ex5 = line[x].to_s.downcase + line[x+1].to_s.downcase + line[x+2].to_s.downcase + line[x+3].to_s.downcase + line[x+4].to_s.downcase
									y = line.length
									ey1 = line[y-1]
									ey2 = line[y-2] + line[y-1]
									ey3 = line[y-3] + line[y-2] + line[y-1]
									ey4 = line[y-4] + line[y-3] + line[y-2] + line[y-1]
									f.puts line.capitalize unless ((u line[x]) && (ex2 == "ou" || ex2 == "au" || ex2 == "eu" || ex2 == "qu")) || ((ai line[x]) && ((ex3 == "eur" ) || (ey1 == "e") || (ex1 == "ea") || (ex1 == "eu") || (ex1 == "eo") || (ex1 == "en"))) || ((au line[x]) && (ex3 == "omb" || ex3 == "omp" || ex1 == "ou" || ex1 == "oi" || ey2 == "on")) || ((a line[x]) && ( ((ex1 == "ai") && (ex5 != "aille")) || (ex1 == "an") || (ex1 == "au"))) || ((i line[x]) && ((ex2 == "oi") || (ex2 == "ai") || (ey2 == "in") || (ey3 == "ion") || (ey4 == "ions")))
								end  
								x=x+1
						else
							x=x+1
							
						end
					end
				end
			end 	
		end
	end
	
	i=0
	exist = Array.new
	exist = []
	lenght = mot.length
	puts lenght
	i = (lenght/2).round
	puts i
	while i < lenght
				mot2= mot[i].to_s + mot[i+1].to_s
				mot3= mot[i].to_s + mot[i+1].to_s + mot[i+2].to_s
				y = mot.length
				ey1 = mot[y-1]
				if (an mot3) || (un mot3) || (eu mot3)
					combi = mot3
					puts combi unless exist.include?(combi)
					rimephono(dic, combi) unless exist.include?(combi)
					exist.push(combi) unless exist.include?(combi)
					i =i+3
				else
					if (an mot2) || (un mot2) || (on mot2) || (ou mot2) || (eu mot2) || (au mot2) || (ai mot2) || (a mot2)
						combi = mot2 unless ((mot2 == "an" && (voyelle mot[i+2])) || ((ai mot2) && (ey1=="e")))
						puts combi unless exist.include?(combi)
						rimephono(dic, combi) unless exist.include?(combi)
						exist.push(combi) unless exist.include?(combi)
						i =i+2
					else 
						if (a mot[i]) || (ai mot[i]) || (i mot[i]) || (au mot[i]) || (u mot[i])
							combi = mot[i] unless (ai mot[i]) && (ey1=="e")
							puts combi unless exist.include?(combi)
							rimephono(dic, combi) unless exist.include?(combi)
							exist.push(combi) unless exist.include?(combi)
							i =i+1
						else
							i =i+1
						end
					end 
				end
	end 

end


def nodouble(source, target) #comparing with dico_final
	double = Set.new 
	File.open(target, 'a') do |solo|
		File.open(source, "r").each_line do |line|
			if double.add?(line)
			solo << line
			end
		end
	end
end

def nodouble2(source, target)  #for rankings
	double = Set.new 
	File.open(target, 'w+') do |solo|
		File.open(source, 'r').each_line do |line|
			if double.add?(line)
			solo << line
			end
		end
	end
end

def classage mot 
	def voyelle v
	 if v=="a" || v=="e" || v=="i" || v=="o" || v=="u" || v=="y" || v=="é" || v=="è" || v=="ê" || v=="î" || v=="û" || v=="ô"
			return true 
		else
			return false 
		end 
	end 

	def consonne c 
	 if c=="b" || c=="c" || c=="d" || c=="f" || c=="g" || c=="h" || c=="j" || c=="k" || c=="l" || c=="m" || c=="n" || c=="p" || c=="q" || c=="r" || c=="s" || c=="t" || c=="v"|| c=="w" || c=="x" || c=="z"
			return true
		else
			return false 
		end 
	end 

	def rimeasso(dico, mot)
		if @count == 1
				@asso1 = ["Allitération en \'#{mot}:\'"]
				dico.each do |line|
				x=0 
				while x < line.length
					if (consonne line[x].to_s) && (voyelle line[x+1].to_s)
						match = line[x].to_s + line[x+1].to_s
						if match == mot
							@asso1.push(line.capitalize) 
						end 
					end 
					x =x+1
				end 
				end 	
		end
		if @count == 2
				@asso2 = ["Allitération en \'#{mot}:\'"]
				dico.each do |line|
				x=0 
				while x < line.length
					if (consonne line[x].to_s.force_encoding("UTF-8")) && (voyelle line[x+1].to_s.force_encoding("UTF-8"))
						match = line[x].to_s.force_encoding("UTF-8") + line[x+1].to_s.force_encoding("UTF-8")
						if match == mot
							@asso2.push(line.capitalize)
						end 
						
					end 
					x =x+1
				end 	
				end
		end 
		if @count == 3
				@asso3 = ["Allitération en \'#{mot}:\'"]
				dico.each do |line|
				x=0 
				while x < line.length
					if (consonne line[x].to_s.force_encoding("UTF-8")) && (voyelle line[x+1].to_s.force_encoding("UTF-8"))
						match = line[x].to_s.force_encoding("UTF-8") + line[x+1].to_s.force_encoding("UTF-8")
						if match == mot
							@asso3.push(line.capitalize) 
						end 
					end 
					x =x+1
				end 	
				end
		end 
		if @count == 4
				@asso4 = ["Allitération en \'#{mot}:\'"]
				dico.each do |line|
				x=0 
				while x < line.length
					if (consonne line[x].to_s.force_encoding("UTF-8")) && (voyelle line[x+1].to_s.force_encoding("UTF-8"))
						match = line[x].to_s.force_encoding("UTF-8") + line[x+1].to_s.force_encoding("UTF-8")
						if match == mot
							@asso4.push(line.capitalize) 
						end 
					end 
					x =x+1
				end 	
				end
		end 
		if @count == 5
				@asso5 = ["Allitération en \'#{mot}:\'"]
				dico.each do |line|
				x=0 
				while x < line.length
					if (consonne line[x].to_s.force_encoding("UTF-8")) && (voyelle line[x+1].to_s.force_encoding("UTF-8"))
						match = line[x].to_s.force_encoding("UTF-8") + line[x+1].to_s.force_encoding("UTF-8")
						if match == mot
							@asso5.push(line.capitalize) 
						end  
					end 
					x =x+1
				end 	
				end
		end 
	end

	@count = 0
	i=0
	while i < mot.length
		if (consonne mot[i].to_s) && (voyelle mot[i+1].to_s)
			combi = mot[i].to_s + mot[i+1].to_s
			@count = @count + 1
			rimeasso(@rimedoc, combi)
		end 
		i =i+1
	end 
end 


get '/' do
	@mot = 0
	@rimedoc = File.open("rime_final.txt", "w+")
	@rimedoc1 = File.open("rime.txt", "w+")
	@rimedoc2 = File.open("rime2.txt", "w+")
	@rimedoc3 = File.open("rime3.txt", "w+")
	@asso1 = Array.new
	@asso1 = []
	@asso2 = Array.new
	@asso2 = []
	@asso3 = Array.new
	@asso3 = []
	@asso4 = Array.new
	@asso4 = []
	@asso5 = Array.new 
	@asso5 = []
	@radio = 1
	
	erb :index
	
	
end

post '/' do
	@rimedoc = File.open("rime_final.txt", "w+")
	@rimedoc1 = File.open("rime.txt", "w+")
	@rimedoc2 = File.open("rime2.txt", "w+")
	@rimedoc3 = File.open("rime3.txt", "w+")
	@asso1 = Array.new
	@asso1 = []
	@asso2 = Array.new
	@asso2 = []
	@asso3 = Array.new
	@asso3 = []
	@asso4 = Array.new
	@asso4 = []
	@asso5 = Array.new 
	@asso5 = []	
	@mot = params[:mot].capitalize
	
	if params[:rimeo] == "1"
		rimesr params[:mot].downcase
		phonetique(params[:mot].downcase, "rime2.txt")
		@radio = 1
		
	else
		assonance params[:mot].downcase
		rimesp(params[:mot].downcase, "rime.txt")
		@radio = 0
	end
	nodouble("rime3.txt", "rime_final.txt")
	
	@rimedoc = File.open("rime_final.txt", "r:UTF-8").to_a
	if @rimedoc.empty? && @radio == 0
		phonetique(params[:mot].downcase, "rime.txt")
		nodouble("rime3.txt", "rime_final.txt")
	    @rimedoc = File.open("rime_final.txt", "r:UTF-8").to_a
	end 
	
	classage params[:mot].downcase 
	erb :index 
end

get '/dictionnaire-de-rimes/:rime' do
	@radio = 1
	@rimedoc = File.open("rime_final.txt", "w+")
	@rimedoc1 = File.open("rime.txt", "w+")
	@rimedoc2 = File.open("rime2.txt", "w+")
	@rimedoc3 = File.open("rime3.txt", "w+")
	@asso1 = Array.new
	@asso1 = []
	@asso2 = Array.new
	@asso2 = []
	@asso3 = Array.new
	@asso3 = []
	@asso4 = Array.new
	@asso4 = []
	@asso5 = Array.new 
	@asso5 = []
	@mot = params['rime'].capitalize
	
	if @radio == 1
		rimesr params['rime'].downcase
		phonetique(params['rime'].downcase, "rime2.txt")
		@radio = 1
		
	else
		assonance params['rime'].downcase
		rimesp(params['rime'].downcase, "rime.txt")
		@radio = 0
	end
	nodouble("rime3.txt", "rime_final.txt")
	@rimedoc = File.open("rime_final.txt", "r:UTF-8").to_a
	if @rimedoc.empty? && @radio == 0
		phonetique(params['rime'].downcase, "rime.txt")
		nodouble("rime3.txt", "rime_final.txt")
	    @rimedoc = File.open("rime_final.txt", "r:UTF-8").to_a
	end 
	classage params['rime'].downcase 
	erb :dictionnaire
end 

get '/a-propos-dictionnaire-de-rimes' do
	erb :about
end 

get '/inscription' do
	erb :erreur
end 

get '/contact' do
	@mail = 0
	erb :contact 
end 

post '/contact' do
	@mail = 1
	Pony.mail(
      from: params[:nom] + "<" + params[:email] + ">",
      to: 'contact@dealerderimes.fr',
      subject: "Vous avez un message de " + params[:nom],
      body: params[:message],
      )
    erb :contact 
end

get '/lucas_pedroza_fr' do
	@mail = 0
	erb :profil_fr
end

post '/lucas_pedroza_fr' do
	@mail = 1
	Pony.mail(
      from: params[:nom] + "<" + params[:email] + ">",
      to: 'P.lucas021@gmail.com',
      subject: "Vous avez un message de: " + params[:nom],
      body: params[:message],
      )
	erb :profil_fr
end

get '/lucas_pedroza_en' do
	@mail = 0
	erb :profil_en
end

post '/lucas_pedroza_en' do
	@mail = 1
	Pony.mail(
      from: params[:nom] + "<" + params[:email] + ">",
      to: 'P.lucas021@gmail.com',
      subject: "Vous avez un message de " + params[:nom],
      body: params[:message],
      )
	erb :profil_en
end



get '/classement_rap_français' do		
	@pos = 1		
	@ranking = {}
	File.open('rank.txt', 'r:UTF-8') do |fp|
		fp.each do |line|
		key, value = line.split(/,/)
		@ranking[key] = value.to_i
		
		end
	end
	@ranking = @ranking.sort_by { |key, value| -value }
	
	@affiliate = {}
	File.open('apple.txt', 'r:UTF-8') do |fp|
		fp.each do |line|
		key, value = line.split(/,/)
		@affiliate[key] = value.to_s
		puts @affiliate[key]
		end
	end
	
	
	erb :classement
	
end 

post '/classement_rap_français' do	
		File.open("dico.txt", "w+")
		dico = "dico.txt"
		page = Nokogiri::HTML(open(params[:lien]))   
		links = page.css('a.u-display_block') #links of song
		album = page.css('h1').text #name of the album
		artist = page.css('a')[6].text #name of the artist
		year = page.css('div.metadata_unit')[0].text.split # year of release 
		numb = page.css('span').text.split #get the number of songs


		c = 0
		File.open 'out.txt', 'w+'
		numb.each do |num|
			if num.is_integer? && num.to_i > c && num.to_i < 30
				f = File.open('out.txt', 'a')
				f.write(num)
				f.write("\n")
				f.close
				c += 1
			else
			end
		end

		number = File.readlines('out.txt').last.to_i #number of songs


		links.each do |song|
			page = Nokogiri::HTML(open(song["href"]))   
			lyrics = page.css('div.song_body-lyrics')
			lyrics = lyrics.text.downcase 
			
			mots = lyrics.split(/[^[[:word:]]]+/)
			
			mots.each do |mot|
			
			File.open dico, 'a' do |f| 
				f.puts mot.capitalize
				end
			end
			
			
		end

		mots = File.readlines(dico)
		mots = mots.sort

		File.open dico, 'w+'
			
		mots.each do |mot|
			
			File.open dico, 'a' do |f| 
				f.puts mot.capitalize
				end
			end


		nodouble2('dico.txt', 'dico_unique.txt')

		count = Hash.new 0

		File.open("dico_unique.txt", "r:UTF-8").each_line do |mot|
				count[mot] += 1
				end
			
		keyword = count.length / number

		name = album + " - " + artist + " (" + year.last + ")"
		
		

		f = File.open('rank.txt', 'a')
		f.write("\n")
		f.write(name)
		f.write(", ")
		f.write(keyword)
		f.close
		
		@pos = 1		
		@ranking = {}
		File.open('rank.txt', 'r:UTF-8') do |fp|
		fp.each do |line|
		key, value = line.split(/,/)
		@ranking[key] = value.to_i
		
		end
		end
		@ranking = @ranking.sort_by { |key, value| -value }
		
		@affiliate = {}
		File.open('apple.txt', 'r:UTF-8') do |fp|
		fp.each do |line|
		key, value = line.split(/,/)
		@affiliate[key] = value.to_s
		puts @affiliate[key]
		end
	end
		
	erb :classement
end
