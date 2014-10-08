def getTemplate_Read_Request_22(did, r_service="Read")
	return "
	  <REQUEST ID='_#{$id}'>
		<SHORT-NAME>RQ_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
		<LONG-NAME>RQ #{did[:DID_name]} #{r_service}</LONG-NAME>
		<PARAMS>
		  <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
			<SHORT-NAME>SID_RQ</SHORT-NAME>
			<LONG-NAME>SID-RQ</LONG-NAME>
			<BYTE-POSITION>0</BYTE-POSITION>
			<CODED-VALUE>34</CODED-VALUE>
			<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
			  <BIT-LENGTH>8</BIT-LENGTH>
			</DIAG-CODED-TYPE>
		  </PARAM>
		  <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
			<SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
			<LONG-NAME>RecordDataIdentifier</LONG-NAME>
			<BYTE-POSITION>1</BYTE-POSITION>
			<CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
			<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
			  <BIT-LENGTH>16</BIT-LENGTH>
			</DIAG-CODED-TYPE>
		  </PARAM>
		</PARAMS>
	  </REQUEST>
		"
end
def getTemplate_Read_PosResp_22(did, r_service="Read")
	return "
			  <POS-RESPONSE ID='_#{$id}'>
				<SHORT-NAME>PR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
				<LONG-NAME>PR #{did[:DID_name]} #{r_service}</LONG-NAME>
				<PARAMS>
				  <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
					<SHORT-NAME>SID_PR</SHORT-NAME>
					<LONG-NAME>SID-PR</LONG-NAME>
					<BYTE-POSITION>0</BYTE-POSITION>
					<CODED-VALUE>98</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
					<SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
					<LONG-NAME>RecordDataIdentifier</LONG-NAME>
					<BYTE-POSITION>1</BYTE-POSITION>
					<CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>16</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					<SHORT-NAME>#{did[:DID_name]}</SHORT-NAME>
					<LONG-NAME>#{did[:DID_name]}</LONG-NAME>
					<BYTE-POSITION>3</BYTE-POSITION>
					 <DOP-REF ID-REF='_#{did[:DID_struct_ref_id]}'/>
				  </PARAM>
				</PARAMS>
			  </POS-RESPONSE>
		"
end
def getTemplate_Read_NegResp_22(did, r_service="Read")
	return "
			  <NEG-RESPONSE ID='_#{$id}'>
				<SHORT-NAME>NR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
				<LONG-NAME>NR #{did[:DID_name]} #{r_service}</LONG-NAME>
				<PARAMS>
				  <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
					<SHORT-NAME>SID_NR</SHORT-NAME>
					<LONG-NAME>SID-NR</LONG-NAME>
					<BYTE-POSITION>0</BYTE-POSITION>
					<CODED-VALUE>127</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='SERVICEIDRQ' xsi:type='CODED-CONST'>
					<SHORT-NAME>SIDRQ_NR</SHORT-NAME>
					<LONG-NAME>SIDRQ-NR</LONG-NAME>
					<BYTE-POSITION>1</BYTE-POSITION>
					<CODED-VALUE>34</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					<SHORT-NAME>#{r_service}_NR</SHORT-NAME>
					<LONG-NAME>#{r_service} NR</LONG-NAME>
					<BYTE-POSITION>2</BYTE-POSITION>
					<DOP-REF ID-REF='#{ID_REF_Nrc}'/>
				  </PARAM>
				  <PARAM SEMANTIC='DATA' xsi:type='NRC-CONST'>
					<SHORT-NAME>NRCConst_#{r_service}_NR</SHORT-NAME>
					<LONG-NAME>#{r_service} NR</LONG-NAME>
					<BYTE-POSITION>2</BYTE-POSITION>
					<CODED-VALUES>
					  <CODED-VALUE>17</CODED-VALUE>
					  <CODED-VALUE>19</CODED-VALUE>
					  <CODED-VALUE>33</CODED-VALUE>
					  <CODED-VALUE>49</CODED-VALUE>
					  <CODED-VALUE>120</CODED-VALUE>
					  <CODED-VALUE>127</CODED-VALUE>
					</CODED-VALUES>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				</PARAMS>
			  </NEG-RESPONSE>
		"
end

def getTemplate_Write_Request_2E(did, r_service="Write")
	return "
		<REQUEST ID='_#{$id}'>
		<SHORT-NAME>RQ_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
		<LONG-NAME>RQ #{did[:DID_name]} #{r_service}</LONG-NAME>
            <PARAMS>
              <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>SID_RQ</SHORT-NAME>
                <LONG-NAME>SID-RQ</LONG-NAME>
                <BYTE-POSITION>0</BYTE-POSITION>
                <CODED-VALUE>46</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
                <LONG-NAME>RecordDataIdentifier</LONG-NAME>
                <BYTE-POSITION>1</BYTE-POSITION>
                <CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>16</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
			  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					<SHORT-NAME>#{did[:DID_name]}</SHORT-NAME>
					<LONG-NAME>#{did[:DID_name]}</LONG-NAME>
					<BYTE-POSITION>3</BYTE-POSITION>
					 <DOP-REF ID-REF='_#{did[:DID_struct_ref_id]}'/>
			  </PARAM>
            </PARAMS>
        </REQUEST>
		"
end
def getTemplate_Write_PosResp_2E(did, r_service="Write")
	return "
		<POS-RESPONSE ID='_#{$id}'>
			<SHORT-NAME>PR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
			<LONG-NAME>PR #{did[:DID_name]} #{r_service}</LONG-NAME>
            <PARAMS>
              <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>SID_PR</SHORT-NAME>
                <LONG-NAME>SID-PR</LONG-NAME>
                <BYTE-POSITION>0</BYTE-POSITION>
                <CODED-VALUE>110</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
                <LONG-NAME>RecordDataIdentifier</LONG-NAME>
                <BYTE-POSITION>1</BYTE-POSITION>
                <CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>16</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
            </PARAMS>
          </POS-RESPONSE>
		"
end
def getTemplate_Write_NegResp_2E(did, r_service="Write")
	return "
		<NEG-RESPONSE ID='_#{$id}'>
			<SHORT-NAME>NR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
			<LONG-NAME>NR #{did[:DID_name]} #{r_service}</LONG-NAME>
            <PARAMS>
              <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>SID_NR</SHORT-NAME>
                <LONG-NAME>SID-NR</LONG-NAME>
                <BYTE-POSITION>0</BYTE-POSITION>
                <CODED-VALUE>127</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='SERVICEIDRQ' xsi:type='CODED-CONST'>
                <SHORT-NAME>SIDRQ_NR</SHORT-NAME>
                <LONG-NAME>SIDRQ-NR</LONG-NAME>
                <BYTE-POSITION>1</BYTE-POSITION>
                <CODED-VALUE>46</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
				<SHORT-NAME>#{r_service}_NR</SHORT-NAME>
				<LONG-NAME>#{r_service} NR</LONG-NAME>
                <BYTE-POSITION>2</BYTE-POSITION>
                <DOP-REF ID-REF='#{ID_REF_Nrc}'/>
              </PARAM>
              <PARAM SEMANTIC='DATA' xsi:type='NRC-CONST'>
				<SHORT-NAME>NRCConst_#{r_service}_NR</SHORT-NAME>
				<LONG-NAME>#{r_service} NR</LONG-NAME>
                <BYTE-POSITION>2</BYTE-POSITION>
                <CODED-VALUES>
                  <CODED-VALUE>17</CODED-VALUE>
                  <CODED-VALUE>19</CODED-VALUE>
                  <CODED-VALUE>33</CODED-VALUE>
                  <CODED-VALUE>34</CODED-VALUE>
                  <CODED-VALUE>49</CODED-VALUE>
                  <CODED-VALUE>120</CODED-VALUE>
                  <CODED-VALUE>127</CODED-VALUE>
                </CODED-VALUES>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
            </PARAMS>
          </NEG-RESPONSE>
		"
end

def getTemplate_Read_Request_Toyota(did, r_service="Read")
	return "
	  <REQUEST ID='_#{$id}'>
		<SHORT-NAME>RQ_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
		<LONG-NAME>RQ #{did[:DID_name]} #{r_service}</LONG-NAME>
		<PARAMS>
		  <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
			<SHORT-NAME>SID_RQ</SHORT-NAME>
			<LONG-NAME>SID-RQ</LONG-NAME>
			<BYTE-POSITION>0</BYTE-POSITION>
			<CODED-VALUE>186</CODED-VALUE>
			<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
			  <BIT-LENGTH>8</BIT-LENGTH>
			</DIAG-CODED-TYPE>
		  </PARAM>
		  <PARAM SEMANTIC='SUBFUNCTION' xsi:type='CODED-CONST'>
			<SHORT-NAME>Read_Data</SHORT-NAME>
			<LONG-NAME>Read Data</LONG-NAME>
			<BYTE-POSITION>1</BYTE-POSITION>
			<CODED-VALUE>0</CODED-VALUE>
			<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
			  <BIT-LENGTH>8</BIT-LENGTH>
			</DIAG-CODED-TYPE>
		  </PARAM>
		  <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
			<SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
			<LONG-NAME>RecordDataIdentifier</LONG-NAME>
			<BYTE-POSITION>2</BYTE-POSITION>
			<CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
			<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
			  <BIT-LENGTH>16</BIT-LENGTH>
			</DIAG-CODED-TYPE>
		  </PARAM>
		</PARAMS>
	  </REQUEST>
		"
end
def getTemplate_Read_PosResp_Toyota(did, r_service="Read")
	return "
			  <POS-RESPONSE ID='_#{$id}'>
				<SHORT-NAME>PR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
				<LONG-NAME>PR #{did[:DID_name]} #{r_service}</LONG-NAME>
				<PARAMS>
				  <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
					<SHORT-NAME>SID_PR</SHORT-NAME>
					<LONG-NAME>SID-PR</LONG-NAME>
					<BYTE-POSITION>0</BYTE-POSITION>
					<CODED-VALUE>250</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='SUBFUNCTION' xsi:type='CODED-CONST'>
					<SHORT-NAME>Read_Data</SHORT-NAME>
					<LONG-NAME>Read Data</LONG-NAME>
					<BYTE-POSITION>1</BYTE-POSITION>
					<CODED-VALUE>0</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
					<SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
					<LONG-NAME>RecordDataIdentifier</LONG-NAME>
					<BYTE-POSITION>2</BYTE-POSITION>
					<CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>16</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					<SHORT-NAME>#{did[:DID_name]}</SHORT-NAME>
					<LONG-NAME>#{did[:DID_name]}</LONG-NAME>
					<BYTE-POSITION>4</BYTE-POSITION>
					 <DOP-REF ID-REF='_#{did[:DID_struct_ref_id]}'/>
				  </PARAM>
				</PARAMS>
			  </POS-RESPONSE>
		"
end
def getTemplate_Read_NegResp_Toyota(did, r_service="Read")
	return "
			  <NEG-RESPONSE ID='_#{$id}'>
				<SHORT-NAME>NR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
				<LONG-NAME>NR #{did[:DID_name]} #{r_service}</LONG-NAME>
				<PARAMS>
				  <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
					<SHORT-NAME>SID_NR</SHORT-NAME>
					<LONG-NAME>SID-NR</LONG-NAME>
					<BYTE-POSITION>0</BYTE-POSITION>
					<CODED-VALUE>127</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='SERVICEIDRQ' xsi:type='CODED-CONST'>
					<SHORT-NAME>SID_RQ_NR</SHORT-NAME>
					<LONG-NAME>SID-RQ-NR</LONG-NAME>
					<BYTE-POSITION>1</BYTE-POSITION>
					<CODED-VALUE>186</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM xsi:type='RESERVED'>
					<SHORT-NAME>#{r_service}_NR</SHORT-NAME>
					<LONG-NAME>#{r_service} NR</LONG-NAME>
					<BYTE-POSITION>2</BYTE-POSITION>
					<BIT-LENGTH>8</BIT-LENGTH>
				  </PARAM>
				</PARAMS>
			  </NEG-RESPONSE>
		"
end

def getTemplate_Write_Request_Toyota(did, r_service="Write")
	return "
		<REQUEST ID='_#{$id}'>
		<SHORT-NAME>RQ_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
		<LONG-NAME>RQ #{did[:DID_name]} #{r_service}</LONG-NAME>
			<PARAMS>
               <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>SID_RQ</SHORT-NAME>
                <LONG-NAME>SID-RQ</LONG-NAME>
                <BYTE-POSITION>0</BYTE-POSITION>
                <CODED-VALUE>186</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='SUBFUNCTION' xsi:type='CODED-CONST'>
                <SHORT-NAME>Write_Data</SHORT-NAME>
                <LONG-NAME>Write Data</LONG-NAME>
                <BYTE-POSITION>1</BYTE-POSITION>
                <CODED-VALUE>1</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>              
			  <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
                <LONG-NAME>RecordDataIdentifier</LONG-NAME>
                <BYTE-POSITION>2</BYTE-POSITION>
                <CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>16</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
			  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					<SHORT-NAME>#{did[:DID_name]}</SHORT-NAME>
					<LONG-NAME>#{did[:DID_name]}</LONG-NAME>
					<BYTE-POSITION>4</BYTE-POSITION>
					 <DOP-REF ID-REF='_#{did[:DID_struct_ref_id]}'/>
			  </PARAM>
            </PARAMS>
        </REQUEST>
		"
end
def getTemplate_Write_PosResp_Toyota(did, r_service="Write")
	return "
		<POS-RESPONSE ID='_#{$id}'>
			<SHORT-NAME>PR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
			<LONG-NAME>PR #{did[:DID_name]} #{r_service}</LONG-NAME>
            <PARAMS>
             <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>SID_PR</SHORT-NAME>
                <LONG-NAME>SID-PR</LONG-NAME>
                <BYTE-POSITION>0</BYTE-POSITION>
                <CODED-VALUE>250</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='SUBFUNCTION' xsi:type='CODED-CONST'>
                <SHORT-NAME>Write_Data</SHORT-NAME>
                <LONG-NAME>Write Data</LONG-NAME>
                <BYTE-POSITION>1</BYTE-POSITION>
                <CODED-VALUE>1</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
                <LONG-NAME>RecordDataIdentifier</LONG-NAME>
                <BYTE-POSITION>2</BYTE-POSITION>
                <CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>16</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
            </PARAMS>
          </POS-RESPONSE>
		"
end
def getTemplate_Write_NegResp_Toyota(did, r_service="Write")
	return "
		<NEG-RESPONSE ID='_#{$id}'>
			<SHORT-NAME>NR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
			<LONG-NAME>NR #{did[:DID_name]} #{r_service}</LONG-NAME>
            <PARAMS>
              <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>SID_NR</SHORT-NAME>
                <LONG-NAME>SID-NR</LONG-NAME>
                <BYTE-POSITION>0</BYTE-POSITION>
                <CODED-VALUE>127</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='SERVICEIDRQ' xsi:type='CODED-CONST'>
                <SHORT-NAME>SID_RQ_NR</SHORT-NAME>
                <LONG-NAME>SID-RQ-NR</LONG-NAME>
                <BYTE-POSITION>1</BYTE-POSITION>
                <CODED-VALUE>186</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
			  <PARAM xsi:type='RESERVED'>
                <SHORT-NAME>#{r_service}_NR</SHORT-NAME>
                <LONG-NAME>#{r_service}_NR</LONG-NAME>
                <BYTE-POSITION>2</BYTE-POSITION>
                <BIT-LENGTH>8</BIT-LENGTH>
              </PARAM>
			</PARAMS>
          </NEG-RESPONSE>
		"
end


def getTemplate_Dops(did)

	prm_string = ""
	
	did[:DID_params].each{ |prm|
	
		bit_length = if prm[:PRM_isArray] then (prm[:PRM_ArrayLengthInByte]*prm[:PRM_ArrayElementLengthInBits]) else prm[:PRM_lengthinbits] end
	
		prm_string += "
			<DATA-OBJECT-PROP ID='_#{prm[:PRM_dop]}'>
              <SHORT-NAME>#{prm[:PRM_shortname]}</SHORT-NAME>
              <LONG-NAME>#{prm[:PRM_longname]}</LONG-NAME>
              <COMPU-METHOD>
                <CATEGORY>IDENTICAL</CATEGORY>
              </COMPU-METHOD>
              <DIAG-CODED-TYPE BASE-TYPE-ENCODING='NONE' BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                <BIT-LENGTH>#{bit_length}</BIT-LENGTH>
              </DIAG-CODED-TYPE>
              <PHYSICAL-TYPE BASE-DATA-TYPE='A_UINT32' DISPLAY-RADIX='DEC'/>
            </DATA-OBJECT-PROP>
		"
	}
	
	return prm_string
	#return "<DATA-OBJECT-PROPS>#{prm_string}</DATA-OBJECT-PROPS>"
end

def getTemplate_DiagComms(did, r_service)
	return "
			  <DIAG-SERVICE ID='_#{$id}' SEMANTIC='STOREDDATA' ADDRESSING='FUNCTIONAL-OR-PHYSICAL'>
				<SHORT-NAME>#{did[:DID_name]}_#{r_service}</SHORT-NAME>
				<LONG-NAME>#{did[:DID_name]} #{r_service}</LONG-NAME>
				<SDGS>
				  <SDG>
					<SDG-CAPTION ID='_#{$id+1}'>
					  <SHORT-NAME>CANdelaServiceInformation</SHORT-NAME>
					</SDG-CAPTION>
					<SD SI='DiagInstanceQualifier'>#{did[:DID_name]}</SD>
					<SD SI='DiagInstanceName'>#{did[:DID_name]}</SD>
					<SD SI='ServiceQualifier'>#{r_service}</SD>
					<SD SI='ServiceName'>#{r_service}</SD>
					<SD SI='PositiveResponseSuppressed'>no</SD>
				  </SDG>
				  <SDG>
					<SDG-CAPTION ID='_#{$id+2}'>
					  <SHORT-NAME>State_Model</SHORT-NAME>
					  <LONG-NAME>State Model</LONG-NAME>
					</SDG-CAPTION>
				  </SDG>
				</SDGS>
				<FUNCT-CLASS-REFS>
				  <FUNCT-CLASS-REF ID-REF='#{ID_REF_FunctionalClass}'/>
				</FUNCT-CLASS-REFS>
				<AUDIENCE/>
				<REQUEST-REF ID-REF='_#{did[:RQ_id]}'/>
				<POS-RESPONSE-REFS>
				  <POS-RESPONSE-REF ID-REF='_#{did[:POSRESP_id]}'/>
				</POS-RESPONSE-REFS>
				<NEG-RESPONSE-REFS>
				  <NEG-RESPONSE-REF ID-REF='_#{did[:NEGRESP_id]}'/>
				</NEG-RESPONSE-REFS>
			  </DIAG-SERVICE>
		"
end

def getTemplate_Params(params)

	paramsString1 = "<PARAMS>"
	paramsString2 = ""
	paramsString3 = "</PARAMS>"
	
	start_byte = 0
	
	params.each{ |prm|
		paramsString2 += "
			    <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
                  <SHORT-NAME>#{prm[:PRM_shortname]}</SHORT-NAME>
                  <LONG-NAME>#{prm[:PRM_longname]}</LONG-NAME>
                  <BYTE-POSITION>#{prm[:PRM_startbyte]}</BYTE-POSITION>
				  <BIT-POSITION>#{prm[:PRM_startbit]}</BIT-POSITION>
                  <DOP-REF ID-REF='_#{prm[:PRM_dop]}'/>
                </PARAM>
		"
	}

	return paramsString1 + paramsString2 + paramsString3
	
#	return "
#              <PARAMS>
#                <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
#                  <SHORT-NAME>blinker_mode</SHORT-NAME>
#                  <LONG-NAME>blinker_mode</LONG-NAME>
#                  <BYTE-POSITION>0</BYTE-POSITION>
#                  <DOP-REF ID-REF='_11'/>
#                </PARAM>
#                <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
#                  <SHORT-NAME>Unused</SHORT-NAME>
#                  <LONG-NAME>Unused</LONG-NAME>
#                  <BYTE-POSITION>0</BYTE-POSITION>
#                  <BIT-POSITION>1</BIT-POSITION>
#                  <DOP-REF ID-REF='_5'/>
#                </PARAM>
#              </PARAMS>
#	"
end

def getTemplate_Structure(did)
	xml_struct = "
		<STRUCTURE ID='_#{$id}'>
		  <SHORT-NAME>#{did[:DID_name]}</SHORT-NAME>
		  <LONG-NAME>#{did[:DID_name]}</LONG-NAME>
		  <BYTE-SIZE>#{did[:DID_byte_size]}</BYTE-SIZE>
		  #{getTemplate_Params(did[:DID_params])}
		</STRUCTURE>"
		
	return xml_struct
end