--[[
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
local key_toggle_scopes = 'ctrl+S'  -- enable/disable scopes
local intensity = 0.1
local graticule = true
local envelope = 0
local filter = 0
local display = 0
local last_key = 1
local defaultfont = "/Library/Fonts/Tahoma.ttf"
local hue = 20
local sat = 0.3
local scopes = {
  {keys = {'1'}, desc = {'Broadcast Range Visual'}},
  {keys = {'2'}, desc = {'Full Range Visual'}},
  {keys = {'3'}, desc = {'Visual + Numerical'}},
  {keys = {'4'}, desc = {'Color Matrix'}},
  -- {keys = {'5'}, desc = {'Bit Planes'}},
  {keys = {'6'}, desc = {'color waveform'}},
  {keys = {'7'}, desc = {'overlaid waveform'}},
  {keys = {'8'}, desc = {'color vectorscope'}},
  {keys = {'9'}, desc = {'overlaid vectorscope'}},
  {keys = {'0'}, desc = {'overlaid oscilloscope'}},
  {keys = {'h'}, desc = {'histogram parade'}},
  {keys = {'H'}, desc = {'overlaid histogram'}},
  {keys = {'d'}, desc = {'toggle display filter'}}, -- too wide in some settings, adds color to waveform parade - overlay YUV, parade YUV, overlay Y
  {keys = {'w'}, desc = {'toggle waveform filter'}},
  {keys = {'g'}, desc = {'toggle graticule'}},
  {keys = {'p'}, desc = {'toggle peak envelope'}},
  {keys = {'i'}, desc = {'increase intensity'}},
  {keys = {'I'}, desc = {'decrease intensity'}},
}
-- local waveform_filter = "format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256"
-- local vectorscope_filter = "format=yuv422p,vectorscope=m='..filV..':g='..grat..':e='..env..':i='..intensity..':c=601,scale=512:512"

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
local scopes_enabled = true  -- but vf is not touched before the scopes are modified


-- ------ OSD handling -------
local function ass(x)
  -- local gpo = mp.get_property_osd
  -- return gpo('osd-ass-cc/0') .. x .. gpo('osd-ass-cc/1')

  -- seemingly it's impossible to enable ass escaping with mp.set_osd_ass,
  -- so we're already in ass mode, and no need to unescape first.
  return x
end

local function fsize(s)  -- 100 is the normal font size
  return ass('{\\fscx' .. s .. '\\fscy' .. s ..'}')
end

local function color(c)  -- c is RRGGBB
  return ass('{\\1c&H' .. ss(c, 5, 7) .. ss(c, 3, 5) .. ss(c, 1, 3) .. '&}')
end

local function cnorm() return color('ffffff') end  -- white
local function cdis()  return color('909090') end  -- grey
local function ceq()   return iff(scopes_enabled, color('ffff90'), cdis()) end  -- yellow-ish
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
  local msg1 = fsize(50) .. 'Video Scopes: ' .. ceq() .. iff(scopes_enabled, 'On', 'Off')
            .. ' [' .. key_toggle_scopes .. ']' .. cnorm()
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

  local msg = msg3 .. '\n' .. msg2 .. '\n' .. msg1

  local duration = iff(start_keys_enabled, iff(bindings_enabled and scopes_enabled, 5, nil)
                                         , iff(bindings_enabled, 0, nil))
  ass_osd(msg, duration);
end


local function getBind(key, index)
  return function()  -- onKey
    if not scopes_enabled then return end

    if key[1] == 'i' then
      intensity = intensity + 0.01;
      intensity = math.min(intensity, 1)
    elseif key[1] == 'I' then
      intensity = intensity - 0.01;
      intensity = math.max(intensity, 0)
    elseif key[1] == 'g' then
      graticule = not graticule
    elseif key[1] == 'G' then
      envelope = envelope + 1;
      if envelope == 4 then
        envelope = 0
      end
    elseif key[1] == 'F' then
      filter = filter + 1;
      if filter == 6 then
        filter = 0
      end
    elseif key[1] == 'D' then
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
    
    if filter == 0 then
      filW = "lowpass"
      filV = "gray"
    elseif filter == 1 then
      filW = "flat"
      filV = "color"
    elseif filter == 2 then
      filW = "aflat"
      filV = "color2"
    elseif filter == 3 then
      filW = "chroma"
      filV = "color3"
    elseif filter == 4 then
      filW = "color"
      filV = "color4"
    elseif filter == 5 then
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

    filters = {
      {filter = {'split=5[a][b][c][d][e],[b]field=top[b1],[c]field=bottom[c1],[b1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[b2],[c1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[c2],[a][b2][c2]vstack=inputs=3,format=yuv422p[abc1],[d]format=yuv422p,vectorscope=m='..filV..':g='..grat..':e='..env..':i='..intensity..':c=601,scale=512:512[d1],[e]signalstats=out=brng,scale=512:ih[e1],[e1][d1]vstack[de1],[abc1][de1]hstack'}}, --1 broadcast
      {filter = {'split=5[a][b][c][d][e],[b]field=top[b1],[c]field=bottom[c1],[b1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[b2],[c1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[c2],[a][b2][c2]vstack=inputs=3,format=yuv422p[abc1],[d]format=yuv422p,vectorscope=m='..filV..':g='..grat..':e='..env..':i='..intensity..':c=601,scale=512:512[d1],[e]format=yuv444p,lutyuv=y=if(gte(val\\,254)\\,1\\,if(lte(val\\,1)\\,254\\,val)):u=val:v=val,scale=512:ih[e1],[e1][d1]vstack[de1],[abc1][de1]hstack'}}, --2 full range
      {filter = {'split=7[a][b][c][d][e][f][g],[b]field=top[b1],[c]field=bottom[c1],[b1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[b2],[c1]format=yuv422p,waveform=c='..comp..':d='..disp..':f='..filW..':g='..grat..':e='..env..':fl=numbers+dots:s=ire:i='..intensity..',scale=iw:256[c2],[a][b2][c2]vstack=inputs=3,format=yuv422p[abc1],[d]format=yuv422p,vectorscope=m='..filV..':g='..grat..':e='..env..':i='..intensity..':c=601,scale=512:512[d1],[e]signalstats=out=brng,scale=512:ih[e1],[e1][d1]vstack[de1],[f]signalstats=stat=brng+vrep+tout,format=yuv422p,geq=lum=60:cb=128:cr=128,scale=180:ih+512,setsar=1/1,drawtext=fontcolor=white:fontsize=22:fontfile='..defaultfont..':textfile=/tmp/drawtext.txt,drawtext=fontcolor=white:fontsize=17:fontfile='..defaultfont..':textfile=/tmp/drawtext2.txt,drawtext=fontcolor=white:fontsize=52:fontfile='..defaultfont..':textfile=/tmp/drawtext3.txt[f1],[abc1][de1][f1]hstack=inputs=3[abcdef1],[g]scale=iw+512+180:82,format=yuv422p,geq=lum=60:cb=128:cr=128,drawtext=fontcolor=white:fontsize=22:fontfile='..defaultfont..':textfile=/tmp/vrecord_input.log:reload=1:y=100-th[g1],[abcdef1][g1]vstack'}}, --3 visual + numerical
      {filter = {'scale=iw/4:ih/4,split=9[x][hm][hp][sm][sp][hmsm][hmsp][hpsm][hpsp],[hm]hue=h=-'..hue..'[hm1],[hp]hue=h='..hue..'[hp1],[sm]hue=s=1-'..sat..'[sm1],[sp]hue=s=1+'..sat..'[sp1],[hmsm]hue=h=-'..hue..':s=1-'..sat..'[hmsm1],[hmsp]hue=h=-'..hue..':s=1+'..sat..'[hmsp1],[hpsm]hue=h='..hue..':s=1-'..sat..'[hpsm1],[hpsp]hue=h='..hue..':s=1+'..sat..'[hpsp1],[hpsm1][hp1][hpsp1]hstack=3[top],[sm1][x][sp1]hstack=3[mid],[hmsm1][hm1][hmsp1]hstack=3[bottom],[top][mid][bottom]vstack=3'}}, --4 color matrix
      {filter = {'waveform=f=acolor:i='..intensity..':g='..grat}}, --6 color waveform
      {filter = {'split[a][b],[a]format=yuva444p,waveform=g='..grat..':f=acolor:i='..intensity..':[a],[b][a]overlay=x=W-w:y=H-h'}}, --7 overlaid waveform
      {filter = {'vectorscope=m=color3:i='..intensity..':g='..grat}}, --8 color vectorscope
      {filter = {'split[a][b],[a]format=yuva444p,vectorscope=g='..grat..':i='..intensity..':m=color3[a],[b][a]overlay=x=W-w:y=H-h'}}, --9 overlaid vectorscope
      {filter = {'oscilloscope'}}, --0 oscilloscope
      {filter = {'histogram=c='..comp..':d='..disp}}, --h histogram
      {filter = {'split[a][b],[a]format=yuva444p,histogram=d=parade[a],[b][a]overlay=x=W-w:y=H-h'}}, --H overlaid histogram
    }

    if key[1] == 'i' then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("intensity: " .. intensity, duration);
    elseif key[1] == 'I' then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("intensity: " .. intensity, duration);
    elseif key[1] == 'g' then
      mp.command(get_cmd(filters[last_key].filter))
    elseif key[1] == 'G' then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("envelope: " .. env, duration);
    elseif key[1] == 'F' and last_key == 11 then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("filter: " .. filW, duration);
    elseif key[1] == 'F' and last_key == 13 then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("filter: " .. filV, duration);
    elseif key[1] == 'F' then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("filter: " .. filV .. " " .. filW, duration);
    elseif key[1] == 'D' then
      mp.command(get_cmd(filters[last_key].filter))
      ass_osd("display: " .. disp .. " " .. comment, duration);
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

local function toggle_scopes()
  scopes_enabled = not scopes_enabled
  if not scopes_enabled then
    mp.command('no-osd vf clr ""')
  end
  updateOSD()
end

mp.add_forced_key_binding(key_toggle_scopes, toggle_scopes)
mp.add_forced_key_binding(key_toggle_bindings, toggle_bindings)
if bindings_enabled then toggle_bindings(true, true) end
