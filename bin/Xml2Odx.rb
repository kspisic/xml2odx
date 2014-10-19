# Main executable Xml2Odx module
#
# Copyright (C) 2014 Kresimir Spisic <keko@spisic.de>
# See COPYING for the License of this software


require_relative '../lib/Xml2OdxMainLib'

require 'nokogiri'
require 'fileutils'
require 'methadone'


include Methadone::Main
include Methadone::CLILogging

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
	f1.close


	xml_file_array = []
	xml_in1.xpath("//PartialSet").map do |xml_file|
		f_hash = { :file_name			=> File.join(File.dirname(cvdt_xml), xml_file.xpath('Path').text.gsub('..\\', '')),
				   :file_type		 	=> xml_file.xpath('Type').text   }
		xml_file_array.push(f_hash)		
		puts "Will use '#{f_hash[:file_name]}' as <<#{f_hash[:file_type]}>>"
	end
	
	if xml_file_array.empty? then 
		puts "Warning: #{cvdt_xml}: Could not detect <PartialSetList> Node in XML file. Seems not to be a vdtxml file. Will try to handle file as data xml file..."
		
		f_hash = { :file_name			=> cvdt_xml,
				   :file_type		 	=> "Data"   	}
		xml_file_array.push(f_hash)
	else	
		options['ecu_name'] = xml_in1.at('Project/Name').text.gsub(/[^0-9A-Za-z]/, '_')
	end
	
	xml_test = nil
	odx_output_string = ""
	
	xml_file_array.map do |xml_file|

		if xml_file[:file_type] == "Data" then
			begin
				fh = File.open(xml_file[:file_name], "rb")
				puts "Parsing #{xml_file[:file_name]}..."
			rescue => e
				puts e.to_s + '---> Will ignore this file'
				next
			end
						
			xml2did = Xml2Did.new(fh)		
			
			did2odx = Did2Odx.new(	xml2did.did_array, 						# array 
									if odx_output_string=="" then f2 else odx_output_string end, # ODX input / merge template
									options['ecu_name'],					# ecu name
									File.basename(xml_file[:file_name]), 	# class name
									options['service-id-read'], 			# read service and subfunction id
									options['service-id-write']		) 		# write service and subfunction id
									
			odx_output_string = did2odx.odx_output
			
			fh.close
	
			
			puts "Warning: Could not find any useful data in parsed file" if did2odx.odx_output.empty?
			puts did2odx.odx_output.to_s if options[:verbose]
			
			#Create Test Module
			xml_test = generateTestModule(xml2did.did_array, xml_test, File.basename(xml_file[:file_name]), options['ecu_name'])
		
		elsif xml_file[:file_type] == "DTC" then
			puts "Warning: DTCs not yet handled. " + xml_file[:file_name] + " ---> Will ignore this file"
		else
			puts "Warning: Type '#{xml_file[:file_type]}' not supported yet." + xml_file[:file_name] + " ---> Will ignore this file"
		end # if Data
	end # xml_file_array

	
	f2.close
	f3.write(odx_output_string)
	f3.close
	
	f4.write(xml_test)
	f4.close
	puts "Finished!"
end

version     '0.0.4'
description "Converts VDTXML files into ODX 2.2.0 by KS \nNo warranty. Use at own risk."
arg         :cvdt_xml, :required

on("--verbose","Be verbose")

options['template'] = File.join(File.dirname(__FILE__), "../lib/DiagTemplates/UDS_ODX_Template.odx-d")
on("-t <ODX_TEMPLATE>", "--template", "File will be used as ODX template for output")

options['output'] = "ODX_Output.odx"
on("-o <ODX_OUTPUT>", "--output", "ODX_OUTPUT = ODX_TEMPLATE + cvdt_xml")

options['service-id-read'] = '22'
on('--service-id-read "XX[YY]"', "XX = Main Service ID for Read Request. YY = optional Sub Service ID", /^[a-fA-F0-9]{2,4}/)

options['service-id-write'] = '2E'
on('--service-id-write "XX[YY]"', "XX = Main Service ID for Write Request. YY = optional Sub Service ID", /^[a-fA-F0-9]{2,4}/)

options['vxt_output'] = 'VXT_Output.vxt'
on('--vxt_output <FILE>', '<FILE> will be used for output VXT CANoe XML Testcases')

options['ecu_name'] = 'Cool_ECU'
on('--ecu_name <ECU_NAME>', 'This value is set automatically to value from cvdt xml file. If cvdt not used as input it can be set manually with this option. Will be used in ODX file and VXT file at several places')
go!