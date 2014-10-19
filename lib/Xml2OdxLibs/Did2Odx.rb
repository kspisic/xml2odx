# Converts internal DID representation to ODX xml file
#
# Copyright (C) 2014 Kresimir Spisic <keko@spisic.de>
# See COPYING for the License of this software

class Did2Odx
	
	attr_reader	:odx_output
	
	def initialize(did_array, odx_template, ecu_name="Cool_ECU", func_class="Engineering Parameters", service_id_read="22", service_id_write="2E")
		@did_array = did_array
		@odx_template = odx_template
		@ecu_name = ecu_name
		@func_class = func_class
		@service_id_read = service_id_read
		@service_id_write = service_id_write
		
		transform
	end
	
	private
	
	def transform
		xml_in2 = Nokogiri::XML(@odx_template)
		@odx_output = putDataToOdx(xml_in2)
	end
	
	def putDataToOdx(xml_in2)
		# Find nodes in xml template file
		request_node = xml_in2.at('//REQUESTS')
		posresp_node = xml_in2.at('//POS-RESPONSES')
		negresp_node = xml_in2.at('//NEG-RESPONSES')
		diagcomms_node = xml_in2.at('//DIAG-COMMS')
		structures_node = xml_in2.at('//STRUCTURES')
		dop_node = xml_in2.at('//DATA-OBJECT-PROPS')
		funct_class_node = xml_in2.at('//FUNCT-CLASSS')
				
		funct_class_node.add_child(getTemplate_FunctClass(@func_class, @func_class))
		id_ref_functionalclass = RefId.id
		RefId.id += 1;
		
		@did_array.each{ |did|
						
			dop_node.add_child(getTemplate_Dops(did))
			
			structures_node.add_child(getTemplate_Structure(did))
			did.struct_ref_id = RefId.id
			RefId.id = RefId.id + 1;
			
			s_id = @service_id_read[0..1]
			sub_id = @service_id_read[2..3]
			
			if did.rw.include? "Read"	
				request_node.add_child(getTemplate_Read_Request(s_id, sub_id, did))
				did.rq_id = RefId.id;
				RefId.id = RefId.id + 1;
				
				posresp_node.add_child(getTemplate_Read_PosResp(s_id, sub_id, did))
				did.posresp_id = RefId.id;
				RefId.id = RefId.id + 1;

				negresp_node.add_child(getTemplate_Read_NegResp(s_id, sub_id, did))
				did.negresp_id = RefId.id;
				RefId.id = RefId.id + 1;	
				
				diagcomms_node.add_child(getTemplate_DiagComms(did, "Read", id_ref_functionalclass))
				RefId.id = RefId.id + 3;
			end
			
			s_id = @service_id_write[0..1]
			sub_id = @service_id_write[2..3]
			
			if did.rw.include? "Write"
				request_node.add_child(getTemplate_Write_Request(s_id, sub_id, did))
				did.rq_id = RefId.id;
				RefId.id = RefId.id + 1;
				
				posresp_node.add_child(getTemplate_Write_PosResp(s_id, sub_id, did))
				did.posresp_id = RefId.id;
				RefId.id = RefId.id + 1;

				negresp_node.add_child(getTemplate_Write_NegResp(s_id, sub_id, did))
				did.negresp_id = RefId.id;
				RefId.id = RefId.id + 1;	
				
				diagcomms_node.add_child(getTemplate_DiagComms(did, "Write", id_ref_functionalclass))
				RefId.id = RefId.id + 3;
			end
			
			#puts "Found following DID: #{did} \n" if options[:verbose]
		}

		setODXEcuName(xml_in2, @ecu_name)
		
		return xml_in2.to_xml
	end

	
	
end
