# Converts input XML to internal ruby DID representation
#
# Copyright (C) 2014 Kresimir Spisic <keko@spisic.de>
# See COPYING for the License of this software

class Xml2Did
	
	attr_reader	:did_array
	
	
	def initialize(xml_string, did_array = [])
		@xml_string = xml_string
		@did_array = did_array
		transform
	end
	
	private
	
	def transform
		xml_in = Nokogiri::XML(@xml_string)
		calcDidArray(xml_in)
	end
	
	
	def getDidParams(subdata_nodes)

		paramArray = []
		subdata_nodes.map do |subdata|
			hash = getDidParam(subdata)
			
			if hash.isArray == true then
				hash.arrayLengthInByte.times { |i|
					subsubdata = Param.new
					subsubdata.shortname 		= hash.shortname + "_" + i.to_s
					subsubdata.longname 		= hash.longname  + "_" + i.to_s
					subsubdata.startbyte 		= hash.startbyte + ((i*hash.arrayElementLengthInBits)/8)
					subsubdata.startbit 		= hash.startbit + (i*hash.arrayElementLengthInBits)
					subsubdata.lengthinbits 	= hash.arrayElementLengthInBits
					subsubdata.isArray 			= false
					subsubdata.dop				= "_#{RefId.id}"
					RefId.id += 1
					paramArray.push(subsubdata)
				}
			else
				paramArray.push(hash)
			end
			
		end
		
		return paramArray
	end

	def getDidParam(subdata)
	
		param = Param.new
	
		param.shortname						= subdata.xpath('Name').text.gsub(/[^0-9A-Za-z]/, '_')
		param.longname						= subdata.xpath('GroupName').text + "." + subdata.xpath('Name').text.gsub(/[^0-9A-Za-z]/, '_')
		param.startbyte						= subdata.xpath('BitStruct/StartByte').text.to_i
		param.startbit						= subdata.xpath('BitStruct/StartBit').text.to_i
		param.lengthinbits					= subdata.xpath('BitStruct/LengthInBits').text.to_i
		
		if "#{subdata.xpath('BitStruct')}".include?('BitStructs') then
			param.isArray						= "#{subdata.xpath('BitStruct')}".include?('BitStructs')
			param.arrayLengthInByte				= if "#{subdata.xpath('BitStruct')}".include?('BitStructs') then subdata.xpath('BitStruct/BitStructs/RepeatCount').text.to_i else 0 end
			param.arrayElementLengthInBits		= if "#{subdata.xpath('BitStruct')}".include?('BitStructs') then subdata.xpath('BitStruct/BitStructs/LengthInBits').text.to_i else 0 end
		elsif param.lengthinbits > 32
			param.isArray 						= true
			param.arrayLengthInByte 			= param.lengthinbits / 8
			param.arrayElementLengthInBits		= 8
			
			puts param.inspect
		end
		
		param.dop							= "_#{RefId.id}"
		
		RefId.id += 1
		
		return param
	end

	def calcDidArray(xml_in)

		xml_in.xpath("//Data").map do |node|
			
			did_st = node.xpath('ID').text
			did_id = if did_st.include? "0x" then did_st.gsub('0x','').to_i(16).to_s else did_st end
			
			did = Did.new
			
			did.name 			= node.xpath('Name').text.gsub(/[^0-9A-Za-z]/, '_')
			did.desc 			= "Supported Variants: #{node.xpath('SupportedVariants').text}"
			did.id   			= did_id
			did.rw	 			= node.xpath('ReadWriteMode').text
			did.byte_size 		= node.xpath('Length').text
			did.struct_ref_id	= 0
			did.rq_id			= 0
			did.posresp_id		= 0
			did.negresp_id		= 0
			did.params			= getDidParams(node.xpath('SubData'))
					
			@did_array.push(did)
				  
		end # xml_in
	end
	
end
