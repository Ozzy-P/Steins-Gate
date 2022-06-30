local ScreenSize = .75

--Parallel enabled. [+50% chance to crash Roblox]
local Sync = task.synchronize
local dSync = task.desynchronize

_G.Dampen = 1
_G.EasingStyle = Enum.EasingStyle.Circular


assert(_G.Dampen > 0 and _G.Dampen < 8,"Invalid value.")

-- Christmas version merged with final experimental version. Everything is broken.

-- Tween sign rotate/move [WARNING: MITIGATED LAG, BUT STILL WILL LAG]
_G.ParallelTween = true
_G.TweenPositionTime = .05
_G.TweenRotateTime = 0

-- Default sentence location, feel free to edit.
local x = 0 -- Side
local y = -5 -- Down/Up
local z = 10 -- Forward/Back

-- Custom rotation (degrees), will create sign at this default angle.
_G.RotateX = 0
_G.RotateY = 0
_G.RotateZ = 0

-- Vertical and horizontal scales for all letters, same size from pillows for now.
-- You may edit this if you use another tool with a different size than the pillows.
local SignScale = (2/3-.05)
local Tracking = (4/3) -- Why did I call this tracking? I'm leaving it in anyway.

--[[ KeyBinds to edit signs, 
You may edit these binds by re-executing the script, only binds will refresh by doing so.
DeleteKey deletes all signs created.

Context actions are keybinds that edit signs when you have clicked on then (and have been outlined in blue)

ContextDelete deletes signs that you have clicked.
ContextRotate rotates signs at the selected rotation (uneditable in GUI unless you re-execute settings with a different number [re-executing only changes settings])
ContextRotate moves signs at the selected studs in the GUI
--]]
_G.DeleteKey = "Q"
_G.RefreshUI = "P"
_G.ContextDelete = "F"
_G.ContextMove = "E"
_G.ContextRotate = "R"
_G.ContextRotateDegrees = 20

_G.Signs = _G.Signs or {}
_G.Generator = true
--[[
Update log: 
    No updates.
--]]

--[[
███████╗░░░░█████╗░░░░  ░██████╗██╗░░░██╗░██████╗████████╗███████╗███╗░░░███╗
██╔════╝░░░██╔══██╗░░░  ██╔════╝╚██╗░██╔╝██╔════╝╚══██╔══╝██╔════╝████╗░████║
█████╗░░░░░███████║░░░  ╚█████╗░░╚████╔╝░╚█████╗░░░░██║░░░█████╗░░██╔████╔██║
██╔══╝░░░░░██╔══██║░░░  ░╚═══██╗░░╚██╔╝░░░╚═══██╗░░░██║░░░██╔══╝░░██║╚██╔╝██║
██║░░░░░██╗██║░░██║██╗  ██████╔╝░░░██║░░░██████╔╝░░░██║░░░███████╗██║░╚═╝░██║
╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝  ╚═════╝░░░░╚═╝░░░╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝
FA/Ozzy
--]]
local GUI = game:GetObjects("rbxassetid://10069041141")[1]

local service = setmetatable({ }, {
	__index = function(self, key)
		return game:GetService(key)
	end
})
--[[
VAC BAN ID / Debug ID:
FA!
403628923+1024-1.9!8!2!0_806611267991+524288-1.9!8!2!0_4492029283+8192-1.9!8!2!0_800935854+1024-1.9!8!2!0_48705336+128-1.9!8!2!0_6311102+16-1.9!8!2!0_63991793+128-1.9!8!2!0_69213895+128-1.9!8!2!0_658758296261+524288-1.9!8!2!0_6503167328+65536-1.9!8!2!0_6777645+16-1.9!8!2!0_4030356433+8192-1.9!8!2!0_67546207942+65536-1.9!8!2!0_82374316892+65536-1.9!8!2!0_483603+2-1.9!8!2!0_0257227+16-1.9!8!2!0_407217821+1024-1.9!8!2!0_255385664+1024-1.9!8!2!0_654939771412+524288-1.9!8!2!0_02329725+128-1.9!8!2!0_06102875+128-1.9!8!2!0_4249593+16-1.9!8!2!0_6503167328+65536-1.9!8!2!0_63176811801+65536-1.9!8!2!0_295454336061+524288-1.9!8!2!0_610278+2-1.9!8!2!0_8630927+16-1.9!8!2!0_0671478989271+4194304-1.9!8!2!0_447777+2-1.9!8!2!0_8467436+16-1.9!8!2!0_0257227+16-1.9!8!2!0_2361079201+8192-1.9!8!2!0_8421643513+8192-1.9!8!2!0_8216796+16-1.9!8!2!0_673504434+1024-1.9!8!2!0_42071841562+65536-1.9!8!2!0_449497781942+524288-1.9!8!2!0_6503167328+65536-1.9!8!2!0_4492029283+8192-1.9!8!2!0_2348900578281+4194304-1.9!8!2!0_4857876+16-1.9!8!2!0_25768715+128-1.9!8!2!0_6929553983+8192-1.9!8!2!0_2933841531+8192-1.9!8!2!0_6311102+16-1.9!8!2!0_846724834+1024-1.9!8!2!0_4811247053+8192-1.9!8!2!0_2916356+16-1.9!8!2!0_025353+2-1.9!8!2!0_6311102+16-1.9!8!2!0_449417903+1024-1.9!8!2!0_82752885+128-1.9!8!2!0_02912930692+65536-1.9!8!2!0_401383034+1024-1.9!8!2!0_8064067+16-1.9!8!2!0_293152+2-1.9!8!2!0_656281493+1024-1.9!8!2!0_403267395822+524288-1.9!8!2!0_04876692072+65536-1.9!8!2!0_6311102+16-1.9!8!2!0_840413732+1024-1.9!8!2!0_6796801461+8192-1.9!8!2!0
--]]
local F_Frame = CFrame.new(0,0.5,0,1,0,90,0,1,0,0,0,1)
--Wrap everything in pcalls now, in case pop/blox try to delete more stuff, including the plane itself.
local c= service.Players.LocalPlayer
if not _G.BindDisconnect then
	_G.BindDisconnect = true
	local QEvent;QEvent = service.UserInputService.InputBegan:Connect(function(x,Observable)
		_G.DeleteKey = string.upper(_G.DeleteKey)
		if Observable then return end
		if x.KeyCode == Enum.KeyCode[_G.DeleteKey] then 
			for _,sign in pairs(_G.Signs) do
				local cIndex = table.find(_G.Signs,sign)
				local heldContext = table.find(_G.contextSigns,sign)
				for _,part in pairs(sign) do
					part:Destroy()
				end
				table.remove(_G.Signs,cIndex)
				if heldContext then
					table.remove(_G.contextSigns,heldContext)
				end
				task.wait()
			end
			for _,v in pairs(c.Backpack:GetChildren()) do
				if v.Name=="UwU"then v:Destroy()end
			end
		end 
	end)
end

local function Message(a,b)
    local SG = Instance.new("UIGradient")
SG.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(131, 137, 255)),
	ColorSequenceKeypoint.new(0.5,Color3.fromRGB(131, 137, 255)),
	ColorSequenceKeypoint.new(0.75,Color3.fromRGB(255, 140, 140)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(255, 140, 140)),
})
    local c=Instance.new('ScreenGui',service.CoreGui);
    c.Name=''local d=Instance.new('Frame',c)
    d.Name=''d.Size=UDim2.new(0,400,0,350)
    d.Position=UDim2.new(.5,-200,.5,-175)
    d.BackgroundColor3=Color3.new(0,0,0)d.BackgroundTransparency=.2;
    d.BorderSizePixel=0;
    local e=Instance.new('TextLabel',d)
    e.Text="FA System - "..a;
    SG.Parent=e;
    e.Name=''
    e.TextScaled=true;e.Font=19;
    e.TextColor3=Color3.new(255,255,255)
    e.BackgroundTransparency=1;
    e.Size=UDim2.new(0,300,0,50)
    e.Position=UDim2.new(.5,-150,.1,-25)
    local f=Instance.new('TextLabel',d)
    f.Text=""f.Name=''f.Font=19;
    f.TextColor3=Color3.new(255,255,255)
    f.BackgroundTransparency=0;
    f.BorderColor3=Color3.new(255,255,255)
    f.Size=UDim2.new(0,300,0,0)
    f.Position=UDim2.new(.5,-150,.15,0)
    local g=Instance.new('TextLabel',d)
    g.Text=b;
    g.Name=''
    g.TextScaled=true;
    g.Font=19;
    g.TextColor3=Color3.new(255,255,255)
    g.BackgroundTransparency=1;
    g.Size=UDim2.new(0,300,0,200)
    g.Position=UDim2.new(.5,-150,.5,-100)
    local h=Instance.new('TextButton',d)
    h.Text='Dismiss'
    h.Name=''
    h.TextScaled=true;
    h.Font=19;
    h.TextColor3=Color3.new(255,255,255)
    h.BackgroundTransparency=.9;
    h.Size=UDim2.new(0,150,0,50)
    h.Position=UDim2.new(.5,-75,.94,-50)
    c.DescendantRemoving:Connect(function()
        task.wait()
        c:Destroy()
    end)
    h.MouseButton1Click:Connect(function()
        c:Destroy()
    end)
end
local V = Vector3.new
local library = {}
--Compressed coordinates (not really, but imagine it is)
--I'm not rewriting the coordinates to get rid of the striped lines effect.
local sussy = {{2,0,3,0,0,0,0,1,0,2,0,3,0,4,0,5,3,0,3,0,3,1,3,2,3,3,3,4,3,5,2,5,3,5},{-1,1,0,0,0,1,0,2,0,3,0,4,0,5},{-1,1,0,0,1,0,2,1,2,2,1,3,0,4,-1,5,0,5,1,5,2,5},{0,0, 1.5,0, 1.5,1, 1.5,2, 1.5,3, 0.25,2.5, 1.5,4, 1.5,5, 0,5},{0,0,0,1,0,2,0,3,1,3,2,3,3,3,3,1,3,2,3,0,3,3,3,4,3,5},{0,2, 0,0, 2,0, 3,0, 0,1, 1,2, 2,3, 3,3, 3,4, 3,5, 2,5, 1,5, 0, 5},{0,0,0,1,0,2,0,3,0,4,0,5,3,0,3,3,3,4,3,5,1,0,2,0,3,0,1,5,2,5,3,5,1,3,2,3},{0,0,1,0,2,0,3,0,3,1,3,2,2,3,2,2,1,4,1,5},{0,0,0,1,0,2,0.5,3,0,4,0,5,3,0,3,1,3,2,2.5,3,3,4,3,5,1,0,2,0,3,0,1,5,2,5,3,5,1,3,2,2},{0,0,0,1,0,2,0,3,0,5,3,0,3,1,3,2,3,3,3,4,1,0,2,0,3,0,1,5,3,5,1,3,2,2}}
local baka = {{0.5,0, 1,0, 2,0, 2.5,0, 1.5,2, 0,1 ,0,2, 0,3, 0,4, 3,1, 3,2 ,3,3, 3,4},{0,0,1,0,2.5,0,1.5,2,0,1,0,2,0,3,0,4,3,1,3,2,3,3,2.5,4,1,4},{0,0,0,1,0,2,0,3,0,4,2,0,3,0,2,4,3,4},{0,0,0,1,0,2,0,3,0,4,1,0,2,0,3,1,3,2,3,3,1,4,2,4},{0,0,0,1,0,2,0,3,0,4,1,0,2,0,3,0,1,4,2,4,3,4,1,2,2,2},{0,0,0,1,0,2,0,3,0,4,2,0,3,0,2,2},{0,0,0,1,0,2,0,3,0,4,1,0,2,0,3,0,1,4,2,4,3,4,3,2,2.5,2,3,3},{0,0,0,1,0,2,0,3,0,4,1.5,2,3,0,3,1,3,2,3,3,3,4},{1,0,1.5,1,1.5,2,1.5,3,1.5,4,0,0,2,0,3,0,0,4,1,4,2,4,3,4},{0,0,1,0,1.5,1,1.5,2,1.5,3,1.5,4,2,0,3,0,0,4,1,4},{0,0,0,1,0,2,0,3,0,4,2,2,3,1,3,0,3,3,3,4},{0,0,0,1,0,2,0,3,0,4,1,4,2,4},{-2,1,-2,2,-2,3,-2,4,-2,0,-0.5,1,1,2,2.5,1,4,0,4,4,4,3,4,2,4,1},{0,1,0,2,0,3,0,4,0,0,1.5,1,3,2,4,0,4,4,4,3,4,2,4,1},{0,0,0,1,0,2,0,3,0,4,3,0,3,0,3,1,3,2,3,3,3,4,2,0,3,0,2,4,3,4},{0,0,0,1,0,2,0,3,0,4,1,0,2,0,3,0,3,1,3,2,2,2,1,2},{0,0,0,1,0,2,0,3,0,4,3,0,3,0,3,1,3,2,3,3,3,4,2,0,3,0,2,4,3,4,4,4},{0,0,0,1,0,2,0,3,0,4,1,0,2,0,3,0,3,1,3,2,2,2,1,2,2,3,3,4},{0,0,1,0,2,0,3,0,0,1,0,2,2,2,3,2,3,3,0,4,1,4,2,4,3,4},{0,0,1,0,2,0,3,0,1.5,1,1.5,2,1.5,3,1.5,4},{0,0,0,1,0,2,0,3,0,4,3,0,3,0,3,1,3,2,3,3,3,4,2,4,3,4},{0,0,0,1,0.25,2,0.25,3,1.5,4,2.75,3,2.75,2,3,0,3,1},{-1.75,0,-1.75,1,-1.75,2,-1.75,3,-1.25,4,.75,3,2.25,4,3.25,3,3.25,2,3.25,1,3.25,0},{0,0,0,1,0,3,0,4,1.5,2,3,0,3,1,3,3,3,4},{-.25,0, -.25,1, -.25,1.6, 3.25,0, 3.25,1, 3.25,1.6, 1.5,2, 1.5,3, 1.5,4, 1.5,4.5},{0,0,1,0,2,0,3,0,3,1,2,2,1,3,0,4,1,4,2,4,3,4}}
function compile(t,a,b,mason,EdgeCase)
	do
		local startSequence,char = mason,string.char
		for letter = a,b do
			local SteinsGate = {}
			for Sequence = 0b1, #t[letter],0b10 do
				table.insert(SteinsGate,V((t[letter][Sequence]+1)*Tracking,t[letter][Sequence+0b1])*SignScale)
			end
			library[char(startSequence + (0b1)*letter + (EdgeCase or 0))] = SteinsGate
		end
	end
end
compile(sussy,0b1,0b1010,0b110000,-1)
compile(baka,0b1,0b11010,0b1000000)
library["="] = {V(0,2),V(1,2),V(2,2),V(3,2),V(0,4),V(1,4),V(2,4),V(3,4)}
library["+"] = {V(0.8,1.5),V(0.8,2.5),V(2.2,2),V(3.5,1.5),V(3.5,2.5),V(2.2,3),V(2.2,4),V(2.2,1),V(2.2,0)}
library["/"] = {V(0,4),V(1,3),V(2,2),V(3,1),V(4,0)}
library["!"] = {V(1.5,0),V(1.5,1),V(1.5,2),V(1.5,4)}
library['"'] = {V(-1.2,2),V(0,1),V(0,0),V(2.2,2),V(3,1),V(3,0)}
library["'"] = {V(-1.2,2),V(0,1),V(0,0)}
library[";"] = {V(-1.2,4),V(0,3),V(0,3),V(0,1)}
library[":"] = {V(0,4),V(0,0)}
library[","] = {V(-1.2,6),V(0,5),V(0,4)}
library["?"] = {V(1.5,0),V(2.5,0),V(3,0),V(3,1),V(3,2),V(1.5,2),V(1.5,3),V(1.5,5)}
library["_"] = {V(0,4),V(1,4),V(2,4)}
library["<"] = {V(0,2.5),V(1,1.5),V(1,3),V(2,4),V(2,0.5)}
library[">"] = {V(3,2.5),V(2,1.5),V(2,3),V(0,4),V(0,0.5)}
library["."] = {V(1.5,4)}
library["-"] = {V(1.5,2),V(2.5,2)}
library["~"] = {V(-1,2),V(0.5,1),V(2,2),V(3,3),V(5,2),V(6.5,1)}
library[" "] = {}
library["w"] = {V(-1.5,2),V(-1.5,3),V(0,4),V(1.5,3),V(3,4),V(4.5,3),V(4.5,2)}

local fLib = {"=","+","/","!",'"',"'",";",":",",","?","_","<",">",".","-","~"," ","w"}

local function ScaleLetter(pair,ScaleX,ScaleY)
 	for key, Vector in pairs(library[pair]) do
		local OldX = Vector.X * ScaleX
		local NewY = Vector.Y * ScaleY
		library[pair][key] = V(OldX,NewY)
 	end
end

for _,pair in pairs(fLib) do
    if pair == "w"then
        ScaleLetter(pair,2/3 + 0.15,SignScale)
    elseif pair == "~" then
        ScaleLetter(pair,2/3 + 0.05,SignScale)
    else
        ScaleLetter(pair,1,SignScale)
    end
    
end

if not _G.ClickDetector then
	local genericStatus,genericError = pcall(function()
		for _,v in pairs(game.Workspace.Parts.Models:GetDescendants()) do
			if v.Name == "Kitchen" and v:IsA("ProximityPrompt") and v.Parent.Parent:FindFirstChildOfClass("Model") and #v.Parent.Parent.Model:GetChildren() == 3 then
				_G.ClickDetector = v
			end
		end
	end)
end

local TaskLibrary = {task.wait,task.delay}
local _wait = TaskLibrary[1]
local function gCo()
	local Tools = {}
	for _,Tool in pairs(c.Backpack:GetChildren()) do
		if Tool.Name == "Dough" then
			table.insert(Tools,Tool)
		end
	end
	return Tools
end
local GC = gCo()
local TextOffset = V(x,y,z)
local LastOffset = V(-4,0,0)
local TextRotation = CFrame.Angles(0,0,0)
local function PrepareNextLetter()
	GC = gCo()
	LastOffset = LastOffset + V(7.5,0,0)
end
local function GenerateWord(Table,edgeCase,NOF)
	PrepareNextLetter()
	local letter = {}
	for i = 1,#Table do
		GC[i].Parent = c.Character
		pcall(function()
			for _,v in pairs(GC[i]:GetDescendants()) do
				pcall(function()
					if v:IsA("Decal") then
						v:Destroy()
					end
					v.CanCollide = false
				end)
			end
		end)
		GC[i].Grip = (F_Frame + Table[i] + TextOffset + LastOffset) * TextRotation
		GC[i].Parent = c.Backpack
		GC[i].Parent = c.Character
		GC[i].Name = "UwU"
		table.insert(letter,GC[i])
	end
	if edgeCase then
	    LastOffset -= NOF end
	return letter
end


local AI,SLength,UwU,Generator,sentence
local fired,foundCD = nil,false

function main()
	local bpGUI,dStats = pcall(function()
		local ABackpackGui = c.PlayerGui.BackpackGui.LocalScript
		if not ABackpackGui.Disabled then
			ABackpackGui.Disabled = not ABackpackGui.Disabled
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,true)
		end
	end)
	local special
	AI = sentence
	SLength = string.len(sentence)
	LastOffset = V(-4,0,0)
	TextOffset = V(x,y,z)
	if( not string.find(sentence, "m") == nil )then
		LastOffset = V(-3,0,0) end
	TextRotation = CFrame.Angles(math.rad(_G.RotateX),math.rad(_G.RotateY),math.rad(_G.RotateZ))

	UwU = {}
	special = {}
	Generator = 0
	for i = 1, SLength do
		local currentLetter = ""
		if string.sub(AI,i,i) == "w" then
			currentLetter = string.sub(AI,i,i)
		else
			currentLetter = string.upper(string.sub(AI,i,i))
		end

		if library[currentLetter] then
			table.insert(UwU,library[currentLetter])
			Generator = Generator + #library[currentLetter]
			if currentLetter == "w" then
				table.insert(special,#UwU)
			end
		end
	end

	foundCD = _G.ClickDetector and true
	
	if not foundCD then
		Message("Error","Attempt to index nil with gCo.")
	end
	assert(foundCD == true, "Attempt to index nil with gCo")
	
	for i = 1,Generator do
            fireproximityprompt(_G.ClickDetector)
	end

	function Spawn_Sign()
		local elapsedTime,maxTimeout = 0,15
		local pillowCount = {}
		repeat
			_wait(.25)
			elapsedTime = elapsedTime + 1
			pillowCount = gCo()
		until #pillowCount >= Generator or elapsedTime == maxTimeout


		if elapsedTime == maxTimeout then
			Message("Error","Script exhausted allocated execution time.")
			return("Fatal Error")
		else
			local tempS = {}
			for i = 1,#UwU do
				local letterDict
				if #special == 0 then
					letterDict = GenerateWord(UwU[i])
				elseif #special ~= 0 and special[1] == i then
					letterDict = GenerateWord(UwU[i],true,V(2,0,0))
				else
				    letterDict = GenerateWord(UwU[i])
				end
				for i = 1,#letterDict do
					table.insert(tempS,letterDict[i])
				end
			end
			table.insert(_G.Signs,tempS)
			tempS = nil
			_wait((#UwU)*(5/100))

			for _ , Item in pairs(c.Backpack:GetChildren()) do
				if Item:IsA('Tool') and Item.Name == "UwU" then
					Item.Parent = c.Character
				end
			end
			return("OK.")
		end
	end
	return Spawn_Sign()
end



if not _G.GlobalContextMenu then
	_G.GlobalContextMenu = true
	_G.contextSigns = _G.contextSigns or {} 



	--Ignore below, legacy comments for Steins;Gate Maid v2 -H
--[[
[S;G]
/* © __ - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by O____ P____ <__________@gmail.com>, April 2021
 */
--]]
	--[S;G]Se Q_Q
	--[S;G]Ct v4, ba compat w v3

    local Screen = GUI
    GUI.Parent = game:GetService("CoreGui")

    local TextEntry = GUI.TextObject.Value
    local SpawnButton = GUI.Spawn.Value
	local buttons,Connections = {},{}
	local MainConnection,ToggleConnection,IB,IC,UIC

    GUI.Frame:FindFirstChildOfClass("UIScale").Scale = ScreenSize

	function dragify(Frame)
		dragToggle = nil
		dragSpeed = .25 --[S;G]You can edit this.
		dragInput = nil
		dragStart = nil
		dragPos = nil

		function updateInput(input)
			Delta = input.Position - dragStart
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			service.TweenService:Create(Frame, TweenInfo.new(.25), {Position = Position}):Play()
		end

		IB = Frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if (input.UserInputState == Enum.UserInputState.End) then
						dragToggle = false
					end
				end)
			end
		end)

		IC = Frame.InputChanged:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				dragInput = input
			end
		end)

		UIC = service.UserInputService.InputChanged:Connect(function(input)
			if (input == dragInput and dragToggle) then
				updateInput(input)
			end
		end)
	end

	dragify(GUI.Frame)

	local ts = service.TweenService
    local mode = ""

	--[S;G]Core Scripting

	--[S;G]local _Prototype = getfenv(synapse_Env)

	-- Legacy code (S;G Maid Version)
	local Main = {
		DataModel = {
			Players = {"OnlyTwentyCharacters"},
			KeySet = {"HH","H","D","W"},
			PID = tostring(game.PlaceId),
			JID = game.JobId}
	}

	-- Unusuable table, "server_Authority" was redacted from Steins;Gate Maid.
	Server = {
		TCP_PORT = Main.DataModel.JID,
		AuthCode = "4d1708a36b405094a98f",
		JSON_Serializer = {TCP_PORT,AuthCode},
		server_Authority = nil, --Redacted
		--Known working series
		Series = {
			["PlaceID[Tag]"]=nil},

	}

	function Server:TCP(...)
		assert(self["TCP_PORT"] ~= Main.DataModel.JID, "Server denied request") --[S;G]Stop changing the script if this errors 
		self["TCP_PORT"]:FireServer(...)					--Sentence Generator Version: IF you even get this to error when I don't even call this anymore, congrats!
	end

	local Buttons = {XButton,YButton,ZButton} -- References
	local gcTableReferences = {Main,Server} --[S;G]Not used, old script part [1P], deletable
	local assignAxis = function(Button,axis)
		local delayer = false
		local ButtonConnection
		ButtonConnection = Button.MouseButton1Click:Connect(function()
			if delayer then return end delayer = true
			if Button.TextColor3 == Color3.fromRGB(255,169,169) then
				Button.TextColor3 = Color3.fromRGB(169,255,169)
				for _,v in pairs(Buttons) do
					if v ~= Button then
						v.TextColor3 = Color3.fromRGB(255,169,169)
					end
				end
				currentAxis = axis
			end
			wait(.2);delayer = false
		end)
		table.insert(Connections,ButtonConnection)
	end

	assignAxis = nil

	MainConnection = SpawnButton.MouseButton1Click:Connect(function()
		sentence = TextEntry.Text
		main()
	end)
	


	-- Store for data wipe (not possible)
	local UIF = {MainConnection}
	for i = 1,#UIF do
		table.insert(Connections,UIF[i])
	end

	local m = service.Players.LocalPlayer:GetMouse()
	local MAX_RAY_LENGTH = 5000
	local mouse = service.Players.LocalPlayer:GetMouse()

	function drawBounds(bounding)
		local Selections = {}
		for _,part in pairs(bounding) do
			local selection = Instance.new("SelectionBox")
			selection.Name = "ContextMenu"
			selection.LineThickness = 0.05
			selection.Color3 = Color3.fromRGB(161, 12, 37)
			selection.Adornee = part.Handle
			selection.Parent = part.Handle
		end
		return bounding
	end

	function eraseBounds(bounding)
		local indexKey = table.find(_G.contextSigns,sign)
		for _,selection in pairs(bounding) do
			selection.Handle.ContextMenu:Destroy()
		end
		table.remove(_G.contextSigns,indexKey)
	end

	function returnContexts()
		local Contexts = {#cont}
		for _,v in pairs(cont) do
			table.insert(Contexts,v)
		end
		return Contexts
	end
	
	function contextMenu(delete,part)
		if not delete then
			for _,sign in pairs(_G.Signs) do
				if table.find(sign,part) then
					if not table.find(_G.contextSigns,sign) then
						table.insert(_G.contextSigns,drawBounds(sign))
					else
						eraseBounds(sign)
					end
				end
			end
		elseif delete then
			for _ , sign in pairs(_G.contextSigns) do
				local heldContext = table.find(_G.contextSigns,sign)
				for key,part in pairs(sign) do
					part:Destroy()
				end
				table.remove(_G.contextSigns,heldContext)
			end
		end
	end	

	-- Notification for sc-CON/ctOS script [2018/2019], not used, I think.
	local function SendNotification(msg) --Self explanatory.
		service.StarterGui:SetCore("SendNotification", {
			Title = "Blume ctOS"; -- Old code from ctOS GUI, superseded by "Message" (FA ChBr.Dev)
			Text = msg;
		})
	end

	--[S;G]Mouse functions from random devforum page, 2020. Thanks, ThanksRoBama
	local function getMouseRay(rayLength)
		local rayLength = rayLength or 1
		return Ray.new(mouse.UnitRay.Origin, mouse.UnitRay.Direction * rayLength)
	end

	local function getMouseTarget()
		return game.Workspace:FindPartOnRay(getMouseRay(MAX_RAY_LENGTH))
	end

	local delayer = false

	local UserInputService = service.UserInputService

	--[S;G]What's m?
	mouse.Button1Down:Connect(function()
		if not delayer then delayer = not delayer
			local e,c = pcall(function()
				local s = getMouseTarget(  )
				if s ~= nil then
					if s.Parent.Name == "UwU" then --[S;G]Optimizing this later
						if service.Players:getPlayerFromCharacter(s.Parent.Parent) == service.Players.LocalPlayer then -- Rival UwU in game!? なに！？
							contextMenu(false,s.Parent)
						end
					end
				end
			end)
			_wait(.25)
			delayer = not delayer
		end
	end)
	-- Event listeners for ContextMenu keybinds, only 1 will call the contextMenu drawing function.
	local GEvent;GEvent = service.UserInputService.InputBegan:Connect(function(x,Observable)
		_G.ContextDelete = string.upper(_G.ContextDelete)
		_G.ContextRotate = string.upper(_G.ContextRotate)
		_G.ContextMove   = string.upper(_G.ContextMove)
		_G.RefreshUI   = string.upper(_G.RefreshUI)
		if Observable then return end
		if x.KeyCode == Enum.KeyCode[_G.RefreshUI] then 
			Connections = nil
			Main = nil
			if overWrite then overWrite:Disconnect() end
			Screen:Destroy()
			_G.GlobalContextMenu = false
			return
		end 
		if #_G.contextSigns == 0 then return end
		if x.KeyCode == Enum.KeyCode[_G.ContextDelete] then 
			contextMenu(true)
		end 
		if x.KeyCode == Enum.KeyCode[_G.ContextRotate] and not _G.IsRotating then
			local Rotate_Amount
			local rotater_ = tonumber(mode .. tostring(_G.ContextRotateDegrees))
			if currentAxis == "X" then
				Rotate_Amount = CFrame.Angles(math.rad(rotater_),0,0)
			elseif currentAxis == "Y" then
				Rotate_Amount = CFrame.Angles(0,math.rad(rotater_),0)
			elseif currentAxis == "Z" then
				Rotate_Amount = CFrame.Angles(0,0,math.rad(rotater_))
			end
			_G.IsRotating = true
			
			if _G.ParallelTween == true then
				for _ , sign in pairs(_G.contextSigns) do
					local SyncEvent = Instance.new("BindableEvent")
					for key,part in pairs(sign) do
						local function SyncPart()
                            local progress,OldFrame = Instance.new("CFrameValue"),part.Grip
							progress.Value = part.Grip

							local info = TweenInfo.new(	_G.TweenRotateTime, -- Time
								_G.EasingStyle, -- EasingStyle
								Enum.EasingDirection.In, -- EasingDirection
								0, -- RepeatCount (when less than zero the tween will loop indefinitely)
								false, -- Reverses (tween will reverse once reaching it's goal)
								0 )-- DelayTime)
				    			dSync()
							local Goals = {TweenPos={Value = part.Grip * Rotate_Amount}}
							local D_A = 0
							Sync()
							local TweenPosition  = ts:Create(progress, info, Goals.TweenPos)
							TweenPosition:Play()

							local prog;prog=progress.Changed:Connect(function()
							    dSync()
							    local Pog = progress.Value
							    D_A = D_A + 1
							    if (D_A % _G.Dampen ~= 0) then return end
							    Sync()
								part.Grip = Pog
								part.Parent = service.Players.LocalPlayer.Backpack
								part.Parent = service.Players.LocalPlayer.Character
							end)

							TweenPosition.Completed:Wait()
							_wait(.05)
							prog:Disconnect()

							progress,info,Goals,TweenPosition = nil,nil,nil,nil
						end

						SyncEvent.Event:Connect(SyncPart)
					end
					SyncEvent:Fire()
					SyncEvent = nil
					_wait()
				end

				_wait(_G.TweenRotateTime)
			else
				for _ , sign in pairs(_G.contextSigns) do
					for key,part in pairs(sign) do
						part.Grip = part.Grip * Rotate_Amount
						part.Parent = service.Players.LocalPlayer.Backpack
						part.Parent = service.Players.LocalPlayer.Character
					end
				end
			end
			_G.IsRotating = false
			
		end
		if x.KeyCode == Enum.KeyCode[_G.ContextMove] and not _G.IsMoving then
			if tonumber(XDirection.Text) == nil or tonumber(YDirection.Text) == nil or tonumber(ZDirection.Text) == nil then SendNotification("Invalid value(s) to move sign") return end
			_G.IsMoving = true
			local addV = Vector3.new(XDirection.Text,YDirection.Text,ZDirection.Text)
			if _G.ParallelTween == true then
				for _ , sign in pairs(_G.contextSigns) do
					local SyncEvent = Instance.new("BindableEvent")
					for key,part in pairs(sign) do
						local function SyncPart()
                            local progress,OldFrame = Instance.new("CFrameValue"),part.Grip
							progress.Value = part.Grip

							local info = TweenInfo.new(	_G.TweenPositionTime, -- Time
								_G.EasingStyle, -- EasingStyle
								Enum.EasingDirection.Out, -- EasingDirection
								0, -- RepeatCount (when less than zero the tween will loop indefinitely)
								false, -- Reverses (tween will reverse once reaching it's goal)
								0 )-- DelayTime)
                           	dSync()
							local Goals = {TweenPos={Value = part.Grip + addV}}
							local D_A = 0
							Sync()
							local TweenPosition  = ts:Create(progress, info, Goals.TweenPos)

							TweenPosition:Play()

							local prog;prog=progress.Changed:Connect(function()
							    dSync()
							    local Pog = progress.Value
							    D_A = D_A + 1
							    if (D_A % _G.Dampen) ~= 0 then return end
							    Sync()
								part.Grip = Pog
								part.Parent = service.Players.LocalPlayer.Backpack
								part.Parent = service.Players.LocalPlayer.Character
							end)

							TweenPosition.Completed:Wait()
							_wait(.05)
							prog:Disconnect()

							progress,info,Goals,TweenPosition = nil,nil,nil,nil
						end
						
						SyncEvent.Event:Connect(SyncPart)
						
					end
					SyncEvent:Fire()
					SyncEvent = nil
					_wait()
				end
				_wait(_G.TweenPositionTime)
			else
				for _ , sign in pairs(_G.contextSigns) do
					for key,part in pairs(sign) do
						part.Grip = part.Grip + addV 
						part.Parent = service.Players.LocalPlayer.Backpack
						part.Parent = service.Players.LocalPlayer.Character
					end
				end
			end
			_G.IsMoving = false
		end

	end)
end


