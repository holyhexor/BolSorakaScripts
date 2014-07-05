local version = "1.0"
local AutoUpdate = true
local SELF = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local URL = "https://raw.githubusercontent.com/Whatefang/FreakingGoodEvade/master/FreakingGoodEvade.lua"
local UPDATE_TMP_FILE = LIB_PATH.."FGETmp.txt"
local versionmessage = "<font color=\"#81BEF7\" >Changelog: Added new Karthus Q, should work all the time when in vision but doesn't work 100% of the time when cast from the fog of war.</font>"

function Update()
DownloadFile(URL, UPDATE_TMP_FILE, UpdateCallback)
end

function UpdateCallback()
file = io.open(UPDATE_TMP_FILE, "rb")
if file ~= nil then
content = file:read("*all")
file:close()
os.remove(UPDATE_TMP_FILE)
if content then
tmp, sstart = string.find(content, "local version = \"")
if sstart then
send, tmp = string.find(content, "\"", sstart+1)
end
if send then
Version = tonumber(string.sub(content, sstart+1, send-1))
end
if (Version ~= nil) and (Version > tonumber(version)) and content:find("--EOS--") then
file = io.open(SELF, "w")
if file then
file:write(content)
file:flush()
file:close()
PrintChat("<font color=\"#81BEF7\" >FreakingGoodEvade:</font> <font color=\"#00FF00\">Successfully updated to: v"..Version..". Please reload the script with F9.</font>")
else
PrintChat("<font color=\"#81BEF7\" >FreakingGoodEvade:</font> <font color=\"#FF0000\">Error updating to new version (v"..Version..")</font>")
end
elseif (Version ~= nil) and (Version == tonumber(version)) then
PrintChat("<font color=\"#81BEF7\" >FreakingGoodEvade:</font> <font color=\"#00FF00\">No updates found, latest version: v"..Version.." </font>")
end
end
end
end