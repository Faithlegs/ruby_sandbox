class OrangeTree
	def initialize
		@height = 0.0
		@age = 0
		@alive = true
		@orangeCount = 0
		puts "A new tree sprouts."
	end

	def alive?
		@alive
	end

	def height
		@height 
	end

	def oneYearPasses
		puts "You see the seasons change, and before you know it, a year has passed."
		if @alive
			@height += 0.5
			@age += 1
			if @age > 35
				killTree
			elsif @age >= 5
				@orangeCount += @age / 5
			end
		end
		
	end

	def countTheOranges
		@orangeCount
	end

	def pickAnOrange
		if @orangeCount > 0
			@orangeCount -= 1
			puts "You pick a delicious orange, leaving" + 
			 " #{@orangeCount} left on the tree."
		else
			puts "There are no oranges on the tree to pick."
		end
	end

	def killTree
		@alive = false
		puts "The tree is dead."
	end

	def chopTree
		puts "You chop the tree to the ground."
		killTree
	end		
end

options = [["Count","--Counts the oranges on the tree"],
		   ["Pick","--Picks an orange"],
		   ["Time","--Let time pass and come back in a year."],
		   ["Height","--Shows how high the tree is."],
		   ["Exit","--Quits the Programme"]]

ourTree = OrangeTree.new

while ourTree.alive?
	puts "What would you like to do?"
	puts options
	choice = gets.chomp.downcase
	case choice
		when options[0][0].downcase
			puts "There are #{ourTree.countTheOranges} oranges on the tree"
		when options[1][0].downcase
			ourTree.pickAnOrange
		when options[2][0].downcase
			ourTree.oneYearPasses
		when options[3][0].downcase
			puts "The tree is #{ourTree.height}m tall."
		when "exit"
			exit
		else
			puts "Not a valid input, please try again."
	end
	puts ' '
end


