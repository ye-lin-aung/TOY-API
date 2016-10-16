require 'open-uri'
require 'json'
require 'sinatra'
require 'Nokogiri'

get '/' do

	content_type :json, 'charset' => 'utf-8'
	Struct.new("Toy", :id, :regon_number,:offence_date,:offence_time,:offence_place,:offence_type)
# REGEX
# @regular_exp = '<tr><td class="idnumber">(.*)<\/td><td class="regonumber">(.*)<\/td><td class="offencedate">(.*)<\/td><td class="offencetime">(.*)<\/td><td class="offenceplace">(.*)<\/td><td class="offencetype">(.*)<\/td><\/tr>'

toys = Array.new
file_contents = Nokogiri::HTML(open("http://winlwinmoe.com/toy/"))


count = 0
file_contents.css('tr').each { 
	|data| 
	if(count>1) then
		toy = Struct::Toy.new(data.css(".idnumber").text.force_encoding("utf-8"),data.css(".regonumber").text.force_encoding("utf-8"),data.css(".offencedate").text.force_encoding("utf-8"),data.css(".offencetime").text.force_encoding("utf-8"),data.css(".offenceplace").text.force_encoding("utf-8"),data.css(".offencetype").text.force_encoding("utf-8"))
		toys << toy	
	end
	count = count + 1	
}
toys.map { |o| Hash[o.each_pair.to_a] }.to_json


end
