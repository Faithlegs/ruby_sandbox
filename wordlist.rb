finished = false
all_words = []
until finished
  puts "Enter a word."
  word = gets.chomp
  if word == ''
    finished = true
  else
  	all_words << word
  end
end

all_words.each {|n| puts n}
