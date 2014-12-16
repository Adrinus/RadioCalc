gauges = {}
gauges[1] = 0.2893
gauges[2] = 0.2576
gauges[3] = 0.2294
gauges[4] = 0.2043
gauges[5] = 0.1819
gauges[6] = 0.1620
gauges[7] = 0.1443
gauges[8] = 0.1285
gauges[9] = 0.1144
gauges[10] = 0.1019
gauges[11] = 0.0907
gauges[12] = 0.0808
gauges[13] = 0.0720
gauges[14] = 0.0641
gauges[15] = 0.0571
gauges[16] = 0.0508
gauges[17] = 0.0453
gauges[18] = 0.0403
gauges[19] = 0.0359
gauges[20] = 0.0320
gauges[21] = 0.0285
gauges[22] = 0.0253
gauges[23] = 0.0226
gauges[24] = 0.0201
gauges[25] = 0.0179
gauges[26] = 0.0159
gauges[27] = 0.0142
gauges[28] = 0.0126
gauges[29] = 0.0113
gauges[30] = 0.0100
gauges[31] = 0.00893
gauges[32] = 0.00795
gauges[33] = 0.00708
gauges[34] = 0.00630
gauges[35] = 0.00561
gauges[36] = 0.00500
gauges[37] = 0.00445
gauges[38] = 0.00397
gauges[39] = 0.00353
gauges[40] = 0.00314

function calcInduction()
	if (tonumber(gauge) > 0 and tonumber(gauge) <= 40) and tonumber(radius) > 0 and tonumber(inductance) > 0 then
		local R = (gauges[tonumber(gauge)]/2)+tonumber(radius)
		local W = gauges[tonumber(gauge)]
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





