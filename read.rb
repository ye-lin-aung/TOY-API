require 'open-uri'
require 'json'

@regular_exp = '<tr><td class="idnumber">(.*)<\/td><td class="regonumber">(.*)<\/td><td class="offencedate">(.*)<\/td><td class="offencetime">(.*)<\/td><td class="offenceplace">(.*)<\/td><td class="offencetype">(.*)<\/td><\/tr>'
Struct.new("Toy", :id, :regon_number,:offence_date,:offence_time,:offence_place,:offence_type)
toys = Array.new
file_contents = open("http://winlwinmoe.com/toy/"){
	|f| 
	lines = f.readlines
	lines.each do |line|
	 match =  line.match(@regular_exp)	
	 if(match != nil)then
	
		 toy = Struct::Toy.new(match[1].force_encoding("utf-8"),match[2].force_encoding("utf-8"),match[3].force_encoding("utf-8"),match[4].force_encoding("utf-8"),match[5].force_encoding("utf-8"),match[6].force_encoding("utf-8"))

		toys << toy	
		
	 end	 
	 
end
}
puts toys.map { |o| Hash[o.each_pair.to_a] }.to_json
