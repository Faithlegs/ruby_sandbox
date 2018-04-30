require 'rubygems'
require 'nokogiri'
require 'open-uri'

TESTMODE = false
command_args = ARGV

if command_args.length > 0
	page_name = command_args[0].split('_').each{|x| x.capitalize!}.join('_')#.capitalize
else
	page_name = STDIN.gets.chomp.split('_').each{|x| x.capitalize! }.join('_')
	page_name = page_name.split(' ').each{|x| x.capitalize! }.join('_')
end

loop do
	wiki_url = "https://en.wikipedia.org/wiki/" + page_name.to_s 

	puts ' '
	puts '-'*wiki_url.length
	puts wiki_url
	puts '-'*wiki_url.length
	puts ' '

	wiki_page = Nokogiri::HTML(open(wiki_url))
	if !wiki_page
		puts "No page found."
		exit
	end


	paragraphs = wiki_page.xpath("//p")
	raw_text = paragraphs.map{|x| x.to_s.gsub(/\<[^\>]+\>/,'').gsub(/\[[^\]]+\]/,'')}.reject{|c| c.empty?}
	#link_array = paragraphs.xpath("//link:a", 'link' => /\/wiki\/.+/) #DO LATER


	p_number = 0

	if TESTMODE == true
		puts "BEGIN TEST MODE"
		puts link_array
		puts "END TEST MODE"
	end

#=begin
	paragraph_loop = true
	while paragraph_loop do 
		
		puts raw_text[p_number]
		puts ' '
		input = STDIN.gets.chomp.downcase
		input = input.downcase
		case input
			when 'back', 'b' then p_number -= 1
			when 'exit', 'end' then exit
			when 'disambiguation','disambig', 'disamb', 'dis' then
				page_name = page_name + '_(disambiguation)'
				paragraph_loop = false
			else p_number += 1
		end
		if p_number > raw_text.length
			puts 'End of Article.'
			exit
		end
	end
#=end
end