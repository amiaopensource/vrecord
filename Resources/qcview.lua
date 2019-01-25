--[[
qcview for vrecord, based on:

mpv scopes
Copyright 2017 Paul B Mahol
License: public domain
Source: https://paste.ubuntu.com/25318437/

Default config:
- Enter/exit scopes keys mode: ctrl+s
--]]
-- ------ config -------
local mp_msg = require 'mp.msg'
local start_keys_enabled = true  -- if true then choose the keys wisely
local key_toggle_bindings = 'ctrl+s'  -- enable/disable scopes key bindings
local intensity = 0.1
local graticule = true
local envelope = 0
local scopefilter = 0
local display = 0
local last_key = 1
local defaultfont = "/Library/Fonts/Tahoma.ttf"
local hue = 20
local sat = 0.3
local scopes = {
  {keys = {'1'}, desc = {'Broadcast Range Visual'}},
  {keys = {'2'}, desc = {'Full Range Visual'}},
  {keys = {'3'}, desc = {'Visual + Numerical: Broadcast Range'}},
  {keys = {'4'}, desc = {'Visual + Numerical: Full Range'}},
  {keys = {'5'}, desc = {'Color Matrix'}},
  {keys = {'6'}, desc = {'Bit Planes'}},
  {keys = {'7'}, desc = {'Split Fields'}},
  {keys = {'8'}, desc = {'color waveform'}},
  {keys = {'9'}, desc = {'overlaid waveform'}},
  {keys = {'v'}, desc = {'color vectorscope'}},
  {keys = {'V'}, desc = {'overlaid vectorscope'}},
  {keys = {'o'}, desc = {'overlaid oscilloscope'}},
  {keys = {'h'}, desc = {'histogram parade'}},
  {keys = {'H'}, desc = {'overlaid histogram'}},
  {keys = {'a'}, desc = {'Audio Passthrough'}},
  {keys = {'d'}, desc = {'toggle display filter'}},
  {keys = {'w'}, desc = {'toggle waveform filter'}},
  {keys = {'g'}, desc = {'toggle graticule'}},
  {keys = {'p'}, desc = {'toggle peak envelope'}},
  {keys = {'i'}, desc = {'increase intensity'}},
  {keys = {'I'}, desc = {'decrease intensity'}},
  {keys = {'='}, desc = {'refresh onscreen display'}},
}
-- local waveform_filter = "format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256"
-- local vectorscope_filter = "format=yuv422p,vectorscope=m='..filV..':g='..grat..':e='..env..':i='..intensity..':c=601,scale=512:512,drawbox=w=9:h=9:t=1:x=128-3:y=512-452-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=160-3:y=512-404-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=192-3:y=512-354-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=224-3:y=512-304-5:c=sienna@0.8,drawgrid=w=32:h=32:t=1:c=white@0.1,drawgrid=w=256:h=256:t=1:c=white@0.2"
-- bit planes filterchain breaks when it gets too long, so is separated into two chains below:
local bitplanes1 = '[b0]bitplanenoise=bitplane=10,crop=iw/10:ih:(iw/10)*0:0,lutyuv=u=(maxval/2):v=(maxval/2):y=bitand(val\\,pow(2\\,10-1))*pow(2\\,1),pad=iw:ih+64:0:64,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.0.10}:y=0:fontcolor=white:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.1.10}:y=20:fontcolor=white:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.2.10}:y=40:fontcolor=white:fontsize=20[b0c],[b1]bitplanenoise=bitplane=9,crop=iw/10:ih:(iw/10)*1:0,lutyuv=u=(maxval/2):v=(maxval/2):y=bitand(val\\,pow(2\\,10-2))*pow(2\\,2),pad=iw:ih+64:0:64,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.0.9}:y=0:fontcolor=silver:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.1.9}:y=20:fontcolor=silver:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.2.9}:y=40:fontcolor=silver:fontsize=20[b1c],[b2]bitplanenoise=bitplane=8,crop=iw/10:ih:(iw/10)*2:0,lutyuv=u=(maxval/2):v=(maxval/2):y=bitand(val\\,pow(2\\,10-3))*pow(2\\,3),pad=iw:ih+64:0:64,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.0.8}:y=0:fontcolor=white:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.1.8}:y=20:fontcolor=white:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.2.8}:y=40:fontcolor=white:fontsize=20[b2c],[b3]bitplanenoise=bitplane=7,crop=iw/10:ih:(iw/10)*3:0,lutyuv=u=(maxval/2):v=(maxval/2):y=bitand(val\\,pow(2\\,10-4))*pow(2\\,4),pad=iw:ih+64:0:64,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.0.7}:y=0:fontcolor=silver:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.1.7}:y=20:fontcolor=silver:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.2.7}:y=40:fontcolor=silver:fontsize=20[b3c],[b4]bitplanenoise=bitplane=6,crop=iw/10:ih:(iw/10)*4:0,lutyuv=u=(maxval/2):v=(maxval/2):y=bitand(val\\,pow(2\\,10-5))*pow(2\\,5),pad=iw:ih+64:0:64,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.0.6}:y=0:fontcolor=white:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.1.6}:y=20:fontcolor=white:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.2.6}:y=40:fontcolor=white:fontsize=20[b4c],[b5]bitplanenoise=bitplane=5,crop=iw/10:ih:(iw/10)*5:0,lutyuv=u=(maxval/2):v=(maxval/2):y=bitand(val\\,pow(2\\,10-6))*pow(2\\,6),pad=iw:ih+64:0:64,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.0.5}:y=0:fontcolor=silver:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.1.5}:y=20:fontcolor=silver:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.2.5}:y=40:fontcolor=silver:fontsize=20[b5c]'
local bitplanes2 = '[b6]bitplanenoise=bitplane=4,crop=iw/10:ih:(iw/10)*6:0,lutyuv=u=(maxval/2):v=(maxval/2):y=bitand(val\\,pow(2\\,10-7))*pow(2\\,7),pad=iw:ih+64:0:64,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.0.4}:y=0:fontcolor=white:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.1.4}:y=20:fontcolor=white:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.2.4}:y=40:fontcolor=white:fontsize=20[b6c],[b7]bitplanenoise=bitplane=3,crop=iw/10:ih:(iw/10)*7:0,lutyuv=u=(maxval/2):v=(maxval/2):y=bitand(val\\,pow(2\\,10-8))*pow(2\\,8),pad=iw:ih+64:0:64,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.0.3}:y=0:fontcolor=silver:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.1.3}:y=20:fontcolor=silver:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.2.3}:y=40:fontcolor=silver:fontsize=20[b7c],[b8]bitplanenoise=bitplane=2,crop=iw/10:ih:(iw/10)*8:0,lutyuv=u=(maxval/2):v=(maxval/2):y=bitand(val\\,pow(2\\,10-9))*pow(2\\,9),pad=iw:ih+64:0:64,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.0.2}:y=0:fontcolor=white:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.1.2}:y=20:fontcolor=white:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.2.2}:y=40:fontcolor=white:fontsize=20[b8c],[b9]bitplanenoise=bitplane=1,crop=iw/10:ih:(iw/10)*9:0,lutyuv=u=(maxval/2):v=(maxval/2):y=bitand(val\\,pow(2\\,10-10))*pow(2\\,10),pad=iw:ih+64:0:64,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.0.1}:y=0:fontcolor=silver:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.1.1}:y=20:fontcolor=silver:fontsize=20,drawtext=fontfile='..defaultfont..':text=%{metadata\\\\:lavfi.bitplanenoise.2.1}:y=40:fontcolor=silver:fontsize=20[b9c]'

-- ------- utils --------
function iff(cc, a, b) if cc then return a else return b end end
function ss(s, from, to) return s:sub(from, to - 1) end

-- the mpv command string for adding the filter
local function get_cmd(filter)
  return 'no-osd vf set lavfi=[' .. filter[1] .. ']'
end
local function get_value(value)
  return value[1]
end

-- these two vars are used globally
local bindings_enabled = start_keys_enabled

-- ------ OSD handling -------
local function ass(x)
  -- local gpo = mp.get_property_osd
  -- return gpo('osd-ass-cc/0') .. x .. gpo('osd-ass-cc/1')

  -- seemingly it's impossible to enable ass escaping with mp.set_osd_ass,
  -- so we're already in ass mode, and no need to unescape first.
  return x
end

local function fsize(s)  -- 100 is the normal font size
  local s = 40
  return ass('{\\fscx' .. s .. '\\fscy' .. s ..'}')
end

local function color(c)  -- c is RRGGBB
  return ass('{\\1c&H' .. ss(c, 5, 7) .. ss(c, 3, 5) .. ss(c, 1, 3) .. '&}')
end

local function cnorm() return color('ffffff') end  -- white
local function cdis()  return color('909090') end  -- grey
local function ceq()   return color('ffff90') end  -- yellow-ish
local function ckeys() return iff(bindings_enabled, color('90FF90'), cdis()) end  -- green-ish

local DUR_DEFAULT = 1.5 -- seconds
local osd_timer = nil
-- duration: seconds, or default if missing/nil, or infinite if 0 (or negative)
local function ass_osd(msg, duration)  -- empty or missing msg -> just clears the OSD
  duration = duration or DUR_DEFAULT
  if not msg or msg == '' then
    msg = '{}'  -- the API ignores empty string, but '{}' works to clean it up
    duration = 0
  end
  mp.set_osd_ass(0, 0, msg)
  if osd_timer then
    osd_timer:kill()
    osd_timer = nil
  end
  if duration > 0 then
    osd_timer = mp.add_timeout(duration, ass_osd)  -- ass_osd() clears without a timer
  end
end

-- some visual messing about
local function updateOSD()
  local msg2 = fsize(50)
            .. 'Key-bindings: ' .. ckeys() .. iff(bindings_enabled, 'On', 'Off')
            .. ' [' .. key_toggle_bindings .. ']' .. cnorm()
  local msg3 = ''

  for i = 1, #scopes do
    local desc = scopes[i].desc
    local key  = scopes[i].keys
    local info =
      fsize(30) .. 'key '.. ckeys() .. key[1] .. ' ' .. ceq() .. desc[1] .. '\n'

    msg3 = msg3 .. info
  end

  local msg = msg3 .. '\n' .. msg2

  local duration = iff(start_keys_enabled, iff(bindings_enabled, 6, nil))
  ass_osd(msg, duration);
end


local function getBind(key, index)
  return function()  -- onKey

-- adjustment filters (filters that toggle, cycle, etc.)
    if key[1] == 'i' then
      intensity = intensity + 0.01;
      intensity = math.min(intensity, 1)
    elseif key[1] == 'I' then
      intensity = intensity - 0.01;
      intensity = math.max(intensity, 0)
    elseif key[1] == 'g' then
      graticule = not graticule
    elseif key[1] == 'p' then
      envelope = envelope + 1;
      if envelope == 4 then
        envelope = 0
      end
    elseif key[1] == 'w' then
      scopefilter = scopefilter + 1;
      if scopefilter == 6 then
        scopefilter = 0
      end
    elseif key[1] == 'd' then
      display = display + 1;
      if display == 3 then
        display = 0
      end
    end
    
    if graticule == true then
        grat = 1
    else
        grat = 0
    end
    
    if envelope == 0 then
      env = "none"
    elseif envelope == 1 then
      env = "instant"
    elseif envelope == 2 then
      env = "peak"
    elseif envelope == 3 then
      env = "peak+instant"
    end
    
    if scopefilter == 0 then
      filW = "lowpass"
      filV = "gray"
    elseif scopefilter == 1 then
      filW = "flat"
      filV = "color"
    elseif scopefilter == 2 then
      filW = "aflat"
      filV = "color2"
    elseif scopefilter == 3 then
      filW = "chroma"
      filV = "color3"
    elseif scopefilter == 4 then
      filW = "color"
      filV = "color4"
    elseif scopefilter == 5 then
      filW = "acolor"
      filV = "color5"
    end

    if display == 0 then
      disp = "overlay"
      comment = "Y"
      comp = 1
    elseif display == 1 then
      disp = "overlay"
      comment = "YUV"
      comp = 7
    elseif display == 2 then
      disp = "parade"
      comment = "YUV"
      comp = 7
    end

-- display filters
-- key bindings are set in local scopes variable in config, above; filters are assigned to keys sequentially, so they must remain in order
    filters = {
      {filter = {'split=5[a][b][c][d][e],[b]field=top[b1],[c]field=bottom[c1],[b1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[b2],[c1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[c2],[a][b2][c2]vstack=inputs=3,format=yuv422p[abc1],[d]format=yuv422p,vectorscope=m='..filV..':g='..grat..':e='..env..':i='..intensity..':c=601,scale=512:512,drawbox=w=9:h=9:t=1:x=128-3:y=512-452-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=160-3:y=512-404-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=192-3:y=512-354-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=224-3:y=512-304-5:c=sienna@0.8,drawgrid=w=32:h=32:t=1:c=white@0.1,drawgrid=w=256:h=256:t=1:c=white@0.2[d1],[e]signalstats=out=brng,scale=512:ih[e1],[e1][d1]vstack[de1],[abc1][de1]hstack'}}, --1 broadcast
      {filter = {'split=5[a][b][c][d][e],[b]field=top[b1],[c]field=bottom[c1],[b1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[b2],[c1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[c2],[a][b2][c2]vstack=inputs=3,format=yuv422p[abc1],[d]format=yuv422p,vectorscope=m='..filV..':g='..grat..':e='..env..':i='..intensity..':c=601,scale=512:512,drawbox=w=9:h=9:t=1:x=128-3:y=512-452-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=160-3:y=512-404-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=192-3:y=512-354-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=224-3:y=512-304-5:c=sienna@0.8,drawgrid=w=32:h=32:t=1:c=white@0.1,drawgrid=w=256:h=256:t=1:c=white@0.2[d1],[e]format=yuv444p,pseudocolor=if(between(1\\,val\\,amax)+between(val\\,254\\,amax)\\,65\\,-1):if(between(1\\,val\\,amax)+between(val\\,254\\,amax)\\,100\\,-1):if(between(1\\,val\\,amax)+between(val\\,254\\,amax)\\,212\\,-1),scale=512:ih[e1],[e1][d1]vstack[de1],[abc1][de1]hstack'}}, --2 full range
      {filter = {'split=7[a][b][c][d][e][f][g],[b]field=top[b1],[c]field=bottom[c1],[b1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[b2],[c1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[c2],[a][b2][c2]vstack=inputs=3,format=yuv422p[abc1],[d]format=yuv422p,vectorscope=m='..filV..':g='..grat..':e='..env..':i='..intensity..':c=601,scale=512:512,drawbox=w=9:h=9:t=1:x=128-3:y=512-452-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=160-3:y=512-404-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=192-3:y=512-354-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=224-3:y=512-304-5:c=sienna@0.8,drawgrid=w=32:h=32:t=1:c=white@0.1,drawgrid=w=256:h=256:t=1:c=white@0.2[d1],[e]signalstats=out=brng,scale=512:ih[e1],[e1][d1]vstack[de1],[f]signalstats=stat=brng+vrep+tout,format=yuv422p,geq=lum=60:cb=128:cr=128,scale=180:ih+512,setsar=1/1,drawtext=fontcolor=white:fontsize=22:fontfile='..defaultfont..':textfile=/tmp/drawtext.txt,drawtext=fontcolor=white:fontsize=17:fontfile='..defaultfont..':textfile=/tmp/drawtext2.txt,drawtext=fontcolor=white:fontsize=52:fontfile='..defaultfont..':textfile=/tmp/drawtext3.txt[f1],[abc1][de1][f1]hstack=inputs=3[abcdef1],[g]scale=iw+512+180:82,format=yuv422p,geq=lum=60:cb=128:cr=128,drawtext=fontcolor=white:fontsize=22:fontfile='..defaultfont..':textfile=/tmp/vrecord_input.log:reload=1:y=100-th[g1],[abcdef1][g1]vstack'}}, --3 visual + numerical
      {filter = {'split=7[a][b][c][d][e][f][g],[b]field=top[b1],[c]field=bottom[c1],[b1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[b2],[c1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[c2],[a][b2][c2]vstack=inputs=3,format=yuv422p[abc1],[d]format=yuv422p,vectorscope=m='..filV..':g='..grat..':e='..env..':i='..intensity..':c=601,scale=512:512,drawbox=w=9:h=9:t=1:x=128-3:y=512-452-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=160-3:y=512-404-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=192-3:y=512-354-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=224-3:y=512-304-5:c=sienna@0.8,drawgrid=w=32:h=32:t=1:c=white@0.1,drawgrid=w=256:h=256:t=1:c=white@0.2[d1],[e]format=yuv444p,pseudocolor=if(between(1\\,val\\,amax)+between(val\\,254\\,amax)\\,65\\,-1):if(between(1\\,val\\,amax)+between(val\\,254\\,amax)\\,100\\,-1):if(between(1\\,val\\,amax)+between(val\\,254\\,amax)\\,212\\,-1),scale=512:ih[e1],[e1][d1]vstack[de1],[f]signalstats=stat=brng+vrep+tout,format=yuv422p,geq=lum=60:cb=128:cr=128,scale=180:ih+512,setsar=1/1,drawtext=fontcolor=white:fontsize=22:fontfile='..defaultfont..':textfile=/tmp/drawtext.txt,drawtext=fontcolor=white:fontsize=17:fontfile='..defaultfont..':textfile=/tmp/drawtext2.txt,drawtext=fontcolor=white:fontsize=52:fontfile='..defaultfont..':textfile=/tmp/drawtext3.txt[f1],[abc1][de1][f1]hstack=inputs=3[abcdef1],[g]scale=iw+512+180:82,format=yuv422p,geq=lum=60:cb=128:cr=128,drawtext=fontcolor=white:fontsize=22:fontfile='..defaultfont..':textfile=/tmp/vrecord_input.log:reload=1:y=100-th[g1],[abcdef1][g1]vstack'}}, --4 visual + numerical, full range
      {filter = {'scale=iw/4:ih/4,split=9[x][hm][hp][sm][sp][hmsm][hmsp][hpsm][hpsp],[hm]hue=h=-'..hue..'[hm1],[hp]hue=h='..hue..'[hp1],[sm]hue=s=1-'..sat..'[sm1],[sp]hue=s=1+'..sat..'[sp1],[hmsm]hue=h=-'..hue..':s=1-'..sat..'[hmsm1],[hmsp]hue=h=-'..hue..':s=1+'..sat..'[hmsp1],[hpsm]hue=h='..hue..':s=1-'..sat..'[hpsm1],[hpsp]hue=h='..hue..':s=1+'..sat..'[hpsp1],[hpsm1][hp1][hpsp1]hstack=3[top],[sm1][x][sp1]hstack=3[mid],[hmsm1][hm1][hmsp1]hstack=3[bottom],[top][mid][bottom]vstack=3'}}, --5 color matrix
      {filter = {'format=yuv420p10le|yuv422p10le|yuv444p10le|yuv440p10le,split=10[b0][b1][b2][b3][b4][b5][b6][b7][b8][b9],'..bitplanes1..','..bitplanes2..',[b0c][b1c][b2c][b3c][b4c][b5c][b6c][b7c][b8c][b9c]hstack=10,format=yuv444p,drawgrid=w=iw/10:h=ih:t=2:c=green@0.5'}}, --6 bit planes
      {filter = {'format=yuv444p,split=4[f][y][u][v],[f]il=l=d:c=d,pad=iw+10:ih+10:10:10[f1],[y]il=l=d,extractplanes=y,pad=iw+10:ih+10:10:10[y1],[u]il=c=d,extractplanes=u,pad=iw+10:ih+10:10:10[u1],[v]il=c=d,extractplanes=v,pad=iw+10:ih+10:10:10[v1],[f1][y1]hstack=2[a],[u1][v1]hstack=2[b],[a][b]vstack=2'}}, --7 split fields/planes view
      {filter = {'waveform=f=acolor:i='..intensity..':g='..grat}}, --8 color waveform
      {filter = {'split[a][b],[a]format=yuva444p,waveform=g='..grat..':f=acolor:i='..intensity..':[a],[b][a]overlay=x=W-w:y=H-h'}}, --9 overlaid waveform
      {filter = {'vectorscope=m=color3:i='..intensity..':g='..grat}}, --v color vectorscope
      {filter = {'split[a][b],[a]format=yuva444p,vectorscope=g='..grat..':i='..intensity..':m=color3[a],[b][a]overlay=x=W-w:y=H-h'}}, --V overlaid vectorscope
      {filter = {'oscilloscope'}}, --o oscilloscope
      {filter = {'histogram=c='..comp..':d='..disp}}, --h histogram
      {filter = {'split[a][b],[a]format=yuva444p,histogram=d=parade[a],[b][a]overlay=x=W-w:y=H-h'}}, --H overlaid histogram
      {filter = {'[aid1]asplit=2[z][ao],[z]channelsplit=channel_layout=quad[s1][s2][s3][s4],[s1][s2][s3][s4]amerge=inputs=4,aformat=channel_layouts=quad[zz],[zz]showvolume=t=0:h=17:w=200[xx],[vid1]split=5[a][b][c][d][e],[b]field=top[b1],[c]field=bottom[c1],[b1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[b2],[c1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[c2],[a][b2][c2]vstack=inputs=3,format=yuv422p[abc1],[d]format=yuv422p,vectorscope=m='..filV..':g='..grat..':e='..env..':i='..intensity..':c=601,scale=512:512,drawbox=w=9:h=9:t=1:x=128-3:y=512-452-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=160-3:y=512-404-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=192-3:y=512-354-5:c=sienna@0.8,drawbox=w=9:h=9:t=1:x=224-3:y=512-304-5:c=sienna@0.8,drawgrid=w=32:h=32:t=1:c=white@0.1,drawgrid=w=256:h=256:t=1:c=white@0.2[d1],[e]signalstats=out=brng,scale=512:ih[e1],[e1][d1]vstack[de1],[abc1][de1]hstack[abcde1],[abcde1][xx]overlay=10:10[vo]'}}, --a audio passthrough - not yet working, needs lavfi-complex
    }

-- toggling filters
    if key[1] == 'i' then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("intensity: " .. intensity, duration);
    elseif key[1] == 'I' then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("intensity: " .. intensity, duration);
    elseif key[1] == 'g' then
      mp.command(get_cmd(filters[last_key].filter))
    elseif key[1] == 'p' then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("envelope: " .. env, duration);
    elseif key[1] == 'w' and last_key == 11 then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("filter: " .. filW, duration);
    elseif key[1] == 'w' and last_key == 13 then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("filter: " .. filV, duration);
    elseif key[1] == 'w' then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("filter: " .. filV .. " " .. filW, duration);
    elseif key[1] == 'd' then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("display: " .. disp .. " " .. comment, duration);
    elseif key[1] == '=' then
      updateOSD();
    else
      mp.command(get_cmd(filters[index].filter))
      last_key = index
      updateOSD()
    end
  end
end

local function update_key_binding(enable, key, name, fn)
  if enable then
    mp.add_forced_key_binding(key, name, fn, 'repeatable')
  else
    mp.remove_key_binding(name)
  end
end

local function toggle_bindings(explicit, no_osd)
  bindings_enabled = iff(explicit ~= nil, explicit, not bindings_enabled)
  for i = 1, #scopes do
    local k = scopes[i].keys
    update_key_binding(bindings_enabled, k[1], 'eq' .. k[1], getBind(k, i))
  end
  if not no_osd then updateOSD() end
end

updateOSD()
mp.add_forced_key_binding(key_toggle_bindings, toggle_bindings)
if bindings_enabled then toggle_bindings(true, true) end
