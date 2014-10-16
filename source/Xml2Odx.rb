require 'nokogiri'
require 'fileutils'
require 'methadone'
require_relative 'OdxTemplates'
require_relative 'Xml2Vxt.rb'

include Methadone::Main
include Methadone::CLILogging

$id = 10000
ID_REF_FunctionalClass = '_161' # 161 --> Stored data


def getDidParams(subdata_nodes)

	paramArray = []
	subdata_nodes.map do |subdata|
		hash = getDidParam(subdata)
		paramArray.push(hash)
	end
	
	return paramArray
end

def getDidParam(subdata)
	hash = {	:PRM_shortname => subdata.xpath('Name').text.gsub(/[^0-9A-Za-z]/, '_'),
				:PRM_longname  => subdata.xpath('GroupName').text + "." + subdata.xpath('Name').text.gsub(/[^0-9A-Za-z]/, '_'),
				:PRM_startbyte => subdata.xpath('BitStruct/StartByte').text.to_i,
				:PRM_startbit  => subdata.xpath('BitStruct/StartBit').text.to_i,
				:PRM_lengthinbits => subdata.xpath('BitStruct/LengthInBits').text.to_i,
				:PRM_isArray   => "#{subdata.xpath('BitStruct')}".include?('BitStructs'),
				:PRM_ArrayLengthInByte => if "#{subdata.xpath('BitStruct')}".include?('BitStructs') then subdata.xpath('BitStruct/BitStructs/RepeatCount').text.to_i else 0 end,
				:PRM_ArrayElementLengthInBits => if "#{subdata.xpath('BitStruct')}".include?('BitStructs') then subdata.xpath('BitStruct/BitStructs/LengthInBits').text.to_i else 0 end,
				:PRM_dop	   => "_#{$id}"
	}
	
	$id = $id + 1;
	
	return hash
end

def getDidArray(xml_in)
	dataArray = []
	xml_in.xpath("//Data").map do |node|
		
		did_st = node.xpath('ID').text
		did = if did_st.include? "0x" then did_st.gsub('0x','').to_i(16).to_s else did_st end
		
		hash = {	:DID_name 			=> node.xpath('Name').text.gsub(/[^0-9A-Za-z]/, '_'),
					:DID_desc 			=> "Supported Variants: #{node.xpath('SupportedVariants').text}",
					:DID_id 			=> did,
					:DID_rw				=> node.xpath('ReadWriteMode').text,
					:DID_byte_size		=> node.xpath('Length').text,
					:DID_struct_ref_id 	=> 0, 
					:RQ_id				=> 0,
					:POSRESP_id			=> 0,
					:NEGRESP_id			=> 0,
					:DID_params			=> getDidParams(node.xpath('SubData'))
				}
				
		dataArray.push(hash)
			  
	end # xml_in1
	
	return dataArray
end

def putDataToOdx(dataArray, xml_in2, funct_class)
	# Find nodes in xml template file
	request_node = xml_in2 %('//REQUESTS')
	posresp_node = xml_in2 %('//POS-RESPONSES')
	negresp_node = xml_in2 %('//NEG-RESPONSES')
	diagcomms_node = xml_in2 %('//DIAG-COMMS')
	structures_node = xml_in2 %('//STRUCTURES')
	dop_node = xml_in2 %('//DATA-OBJECT-PROPS')
	funct_class_node = xml_in2 %('//FUNCT-CLASSS')
	
	funct_class_node.add_child(getTemplate_FunctClass(funct_class, funct_class))
	id_ref_functionalclass = $id
	$id = $id + 1;
	
	dataArray.each{ |did|
		
		dop_node.add_child(getTemplate_Dops(did))
		
		structures_node.add_child(getTemplate_Structure(did))
		did[:DID_struct_ref_id] = $id
		$id = $id + 1;
		
		s_id = options['service-id-read'][0..1]
		sub_id = options['service-id-read'][2..3]
		
		if did[:DID_rw].include? "Read"	
			request_node.add_child(getTemplate_Read_Request(s_id, sub_id, did))
			did[:RQ_id] = $id;
			$id = $id + 1;
			
			posresp_node.add_child(getTemplate_Read_PosResp(s_id, sub_id, did))
			did[:POSRESP_id] = $id;
			$id = $id + 1;

			negresp_node.add_child(getTemplate_Read_NegResp(s_id, sub_id, did))
			did[:NEGRESP_id] = $id;
			$id = $id + 1;	
			
			diagcomms_node.add_child(getTemplate_DiagComms(did, "Read", id_ref_functionalclass))
			$id = $id + 3;
		end
		
		s_id = options['service-id-write'][0..1]
		sub_id = options['service-id-write'][2..3]
		
		if did[:DID_rw].include? "Write"
			request_node.add_child(getTemplate_Write_Request(s_id, sub_id, did))
			did[:RQ_id] = $id;
			$id = $id + 1;
			
			posresp_node.add_child(getTemplate_Write_PosResp(s_id, sub_id, did))
			did[:POSRESP_id] = $id;
			$id = $id + 1;

			negresp_node.add_child(getTemplate_Write_NegResp(s_id, sub_id, did))
			did[:NEGRESP_id] = $id;
			$id = $id + 1;	
			
			diagcomms_node.add_child(getTemplate_DiagComms(did, "Write", id_ref_functionalclass))
			$id = $id + 3;
		end
		
		puts "Found following DID: #{did} \n" if options[:verbose]
	}

	return xml_in2
end

main do |cvdt_xml|
	
	begin
	f1 = File.open(cvdt_xml, 'rb')
	f2 = File.open(options['template'], 'rb')
	f3 = File.open(options['output'], 'w')
	f4 = File.open(options['vxt_output'], 'w')
	
	rescue => e
		puts e
		f1.close unless f1.nil?
		f2.close unless f2.nil?
		f3.close unless f3.nil?
		f4.close unless f4.nil?
		exit 1
	end
		
	xml_in1 = Nokogiri::XML(f1)
	xml_in2 = Nokogiri::XML(f2)
	f1.close
	f2.close

	xml_file_array = []
	xml_in1.xpath("//PartialSet").map do |xml_file|
		f_hash = { :file_name			=> xml_file.xpath('Path').text.gsub('..\\', ''),
				   :file_type		 	=> xml_file.xpath('Type').text   }
		xml_file_array.push(f_hash)
		
		puts "Will use '#{f_hash[:file_name]}' as <<#{f_hash[:file_type]}>>"
	end
	
	if xml_file_array.empty? then 
		puts "Problem with #{cvdt_xml}: Could not detect <PartialSetList> Node in XML file. Seems not to be a vdtxml file. Will try to handle file as data xml file..."
		
		f_hash = { :file_name			=> cvdt_xml,
				   :file_type		 	=> "Data"   	}
		xml_file_array.push(f_hash)
	end
	
	xml_test = nil
	
	xml_file_array.map do |xml_file|

		if xml_file[:file_type] == "Data" then
			begin
				fh = File.open(xml_file[:file_name], "rb")
				puts "Parsing #{xml_file[:file_name]}..."
			rescue => e
				puts e.to_s + '---> Will ignore this file'
				next
			end
			
			xml_in = Nokogiri::XML(fh)
			fh.close
	
			dataArray = getDidArray(xml_in)
			
			puts "Warning: Could not find any useful data in parsed file" if dataArray.empty?
			puts dataArray if options[:verbose]
			
			xml_in2 = putDataToOdx(dataArray, xml_in2, xml_file[:file_name])
			
			xml_test = generateTestModule(dataArray)
		
		elsif xml_file[:file_type] == "DTC" then
			puts "Warning: DTCs not yet handled. " + xml_file[:file_name] + " ---> Will ignore this file"
		else
			puts "Warning: Type '#{xml_file[:file_type]}' not supported yet." + xml_file[:file_name] + " ---> Will ignore this file"
		end # if Data
	end # xml_file_array

	f3.write(xml_in2.to_xml)
	f3.close
	
	f4.write(xml_test)
	f4.close
	puts "Finished!"
end

version     '0.0.2'
description "Converts VDTXML files into ODX 2.2.0 by KS \nNo warranty. Use at own risk."
arg         :cvdt_xml, :required

on("--verbose","Be verbose")

options['template'] = "Templates/UDS_ODX_Template.odx-d"
on("-t <ODX_TEMPLATE>", "--template", "File will be used as ODX template for output")

options['output'] = "output.odx-proj"
on("-o <ODX_OUTPUT>", "--output", "ODX_OUTPUT = ODX_TEMPLATE + cvdt_xml")

options['service-id-read'] = '22'
on('--service-id-read "XX[YY]"', "XX = Main Service ID for Read Request. YY = optional Sub Service ID", /^[a-fA-F0-9]{2,4}/)

options['service-id-write'] = '2E'
on('--service-id-write "XX[YY]"', "XX = Main Service ID for Write Request. YY = optional Sub Service ID", /^[a-fA-F0-9]{2,4}/)

options['vxt_output'] = 'VXT_Output.vxt'
on('--vxt_output <FILE>', '<FILE> will be used for output VXT CANoe XML Testcases')
go!