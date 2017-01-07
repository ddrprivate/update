#encoding: UTF-8
require 'sinatra'
require 'pony'
require 'sendgrid-ruby'
require 'sinatra/base'

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

def assonance mot 
	def voyelle v
	 if v=="a" || v=="e" || v=="i" || v=="o" || v=="u" || v=="y" || v=="é" || v=="è" || v=="ê"
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
				if (consonne line[x].to_s) && (voyelle line[x+1].to_s)
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
		if (consonne mot[i].to_s) && (voyelle mot[i+1].to_s)
			combi = mot[i].to_s + mot[i+1].to_s
			puts combi
			count = count+1
			rimeasso("dico_final.txt", combi) 
		end 
		i =i+1
		
	end 
end

def phonetique mot
	def voyelle v
	 if v=="a" || v=="e" || v=="i" || v=="o" || v=="u" || v=="y" || v=="é" || v=="è" || v=="ê"
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
		if x=="ai" || x=="er" || x=="ez" || x=="é" || x=="è" || x=="ê" 
			return true
		end
	end
	def i x
		if x=="i"
			return true 
		end
	end
	def eu x
		if x=="eu" || x=="oeu"
			return true
		end
	end
	def au x
		if x=="au" || x=="o"
			return true 
		end
	end
	def u x
		if x=="u"
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
		if x=="in" || x=="ien" || x=="ain" || x=="ein" || x=="un"
			return true
		end
	end
	def on x
		if x=="on"
			return true
		end
	end
	
	def rimephono(dico, mot)
		output = "rime2.txt"
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
						File.open output, 'a' do |f| 
							f.puts line.capitalize unless ((ai line[x]) && (ex3 == "eur" )) || ((an line2) && (voyelle line[x+2].to_s))
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
									f.puts line.capitalize unless ((u line[x]) && (ex2 == "ou" || ex2 == "au" || ex2 == "eu" || ex2 == "qu")) || ((ai line[x]) && (ex3 == "eur" )) || ((au line[x]) && (ex3 == "omb" || ex3 == "omp" || ex1 == "ou" || ex1 == "oi" || ey2 == "on")) || ((a line[x]) && ( ((ex1 == "ai") && (ex5 != "aille")) || (ex1 == "an" && (consonne line[x+2])) || ex1 == "au")) || ((i line[x]) && ((ex2 == "oi") || (ex2 == "ai") || (ey2 == "in") || (ey3 == "ion") || (ey4 == "ions"))
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
				if (an mot3) || (un mot3) || (eu mot3)
					combi = mot3
					
					puts combi unless exist.include?(combi)
					rimephono("rime.txt", combi) unless exist.include?(combi)
					exist.push(combi) unless exist.include?(combi)
					i =i+3
				else
					if (an mot2) || (un mot2) || (on mot2) || (ou mot2) || (eu mot2) || (au mot2) || (ai mot2) || (a mot2)
						combi = mot2 unless (mot2 == "an" && (voyelle mot[i+2]))
						puts combi unless exist.include?(combi)
						rimephono("rime.txt", combi) unless exist.include?(combi)
						exist.push(combi) unless exist.include?(combi)
						i =i+2
					else 
						if (a mot[i]) || (ai mot[i]) || (i mot[i]) || (au mot[i]) || (u mot[i])
							combi = mot[i]
							puts combi unless exist.include?(combi)
							rimephono("rime.txt", combi) unless exist.include?(combi)
							exist.push(combi) unless exist.include?(combi)
							i =i+1
						else
							i =i+1
						end
					end 
				end
	end 

end

def nodouble(source, target)
	double = Set.new 
	File.open(target, 'a') do |solo|
		File.open(source, "r").each_line do |line|
			if double.add?(line)
			solo << line
			end
		end
	end
end

def classage mot 
	def voyelle v
	 if v=="a" || v=="e" || v=="i" || v=="o" || v=="u" || v=="y" || v=="é"
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
	@rimedoc = File.open("rime_final.txt", "w+")
	@rimedoc1 = File.open("rime.txt", "w+")
	@rimedoc2 = File.open("rime2.txt", "w+")
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
	
	erb :index
	
	
end

post '/' do
	@rimedoc = File.open("rime_final.txt", "w+")
	@rimedoc1 = File.open("rime.txt", "w+")
	@rimedoc2 = File.open("rime2.txt", "w+")
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
	assonance params[:mot].downcase
	phonetique params[:mot].downcase
	nodouble("rime2.txt", "rime_final.txt")
	@rimedoc = File.open("rime_final.txt", "r:UTF-8").to_a
	classage params[:mot].downcase 
	erb :index 
end

get '/dictionnaire/:rime' do
	@rimedoc = File.open("rime_final.txt", "w+")
	@rimedoc1 = File.open("rime.txt", "w+")
	@rimedoc2 = File.open("rime2.txt", "w+")
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
	assonance params['rime'].downcase
	phonetique params['rime'].downcase
	nodouble("rime2.txt", "rime_final.txt")
	@rimedoc = File.open("rime_final.txt", "r:UTF-8").to_a
	classage params['rime'].downcase 
	erb :dictionnaire
end 

get '/a-propos' do
	erb :about
end 

get '/inscription' do
	erb :erreur
end 

get '/contact' do
	erb :contact 
end 

post '/contact' do
	Pony.mail(
      from: params[:nom] + "<" + params[:email] + ">",
      to: 'P.lucas021@gmail.com',
      subject: "Vous avez un message de " + params[:nom],
      body: params[:message],
      )
    redirect '/envoye' 
end

get '/envoye' do
	erb :envoye
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


