# Internal representation of DIDs
#
# Copyright (C) 2014 Kresimir Spisic <keko@spisic.de>
# See COPYING for the License of this software

class Did
	attr_accessor  		:name,
						:desc,
						:id,
						:rw,
						:byte_size,
						:struct_ref_id,
						:rq_id,
						:posresp_id,
						:negresp_id,
						:params

end
class Param
	attr_accessor 		:shortname,
						:longname,
						:startbyte,
						:startbit,
						:lengthinbits,
						:isArray,
						:arrayLengthInByte,
						:arrayElementLengthInBits,
						:dop
end
