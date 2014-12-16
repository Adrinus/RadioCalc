enamelGauges = {}
enamelGauges[8] = 0.1324
enamelGauges[9] = 0.1181
enamelGauges[10] = 0.1054
enamelGauges[11] = 0.0941
enamelGauges[12] = 0.0840
enamelGauges[13] = 0.0750
enamelGauges[14] = 0.0670
enamelGauges[15] = 0.0599
enamelGauges[16] = 0.0534
enamelGauges[17] = 0.0478
enamelGauges[18] = 0.0426
enamelGauges[19] = 0.0382
enamelGauges[20] = 0.0341
enamelGauges[21] = 0.0306
enamelGauges[22] = 0.0273
enamelGauges[23] = 0.0244
enamelGauges[24] = 0.0218
enamelGauges[25] = 0.0195
enamelGauges[26] = 0.0174
enamelGauges[27] = 0.0156
enamelGauges[28] = 0.0139
enamelGauges[29] = 0.0126
enamelGauges[30] = 0.0112
enamelGauges[31] = 0.0100
enamelGauges[32] = 0.0091
enamelGauges[33] = 0.0081
enamelGauges[34] = 0.0072
enamelGauges[35] = 0.0064
enamelGauges[36] = 0.0058
enamelGauges[37] = 0.0052
enamelGauges[38] = 0.0047
enamelGauges[39] = 0.0041
enamelGauges[40] = 0.0037
enamelGauges[41] = 0.0033
enamelGauges[42] = 0.0030
enamelGauges[43] = 0.0026
enamelGauges[44] = 0.0024
enamelGauges[45] = 0.00205
enamelGauges[46] = 0.00185
enamelGauges[47] = 0.00170
enamelGauges[48] = 0.00150
enamelGauges[49] = 0.00130
enamelGauges[50] = 0.00120
enamelGauges[51] = 0.00110
enamelGauges[52] = 0.00100
enamelGauges[53] = 0.00085
enamelGauges[54] = 0.00075
enamelGauges[55] = 0.00070
enamelGauges[56] = 0.00065


function calcInduction()
	if (tonumber(gauge) > 7 and tonumber(gauge) <= 56) and tonumber(radius) > 0 and tonumber(inductance) > 0 then
		local R = (enamelGauges[tonumber(gauge)]/2)+tonumber(radius)
		local W = enamelGauges[tonumber(gauge)]
		local length = (math.sqrt(((tonumber(inductance))*(W^2))*((25*(tonumber(inductance))*(W^2))+(9*(R^3))))+(5*(tonumber(inductance))*(W^2)))/(R^2)
		local turns = round((length/W),3)
		local cir = 2*math.pi*R
		local wireLength = cir*turns
		return round(length,3),turns,wireLength
	else
		return 0,0,0
	end
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end





