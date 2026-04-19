-- Actor details
local details = {
	x = 0,
	y = 0,
	zoom = 3.0
}
-- main code
local height = 0
local function InitBPM(self)
	local fixedBpm = GAMESTATE:GetSongOptionsObject("ModsLevel_Current"):MusicRate() * 60
	local songPosition = GAMESTATE:GetPlayerState():GetSongPosition()
	local curBps = SongPosition.GetCurBPS
	local text = self:GetChild("Text")
	if #GAMESTATE:GetCurrentSong():GetTimingData():GetBPMs() > 1 then
		self:SetUpdateFunction(function(self)
			local bpm = curBps(songPosition) * fixedBpm
			text:settext(math.round(bpm, 0))
			height = text:GetZoomedHeight()
			self:queuecommand("Move")
		end)
		self:SetUpdateRate(0.5)
	else
		self:SetUpdateFunction(nil)
		text:settextf(math.round(curBps(songPosition) * fixedBpm, 0))
		height = text:GetZoomedHeight()
		self:queuecommand("Move")
	end
end
local t = Def.ActorFrame {
	Name = "FakeHeartBeat",
	InitCommand = function(self)
		self:xy(details.x, details.y)
		self:zoom(details.zoom)
		self:queuecommand("Set")
	end,
	MoveCommand = function(self)
		self:GetChild("Text"):xy(height, 0)
		self:GetChild("Sprite"):xy(height / 2, height / 2)
			:queuecommand("SetZoom")
	end,
	SetCommand = function(self)
		InitBPM(self)
	end,
	CurrentRateChangedMessageCommand = function(self)
		self:playcommand("Set")
	end,
	PracticeModeReloadMessageCommand = function(self)
		self:playcommand("Set")
	end,
	DoneLoadingNextSongMessageCommand = function(self)
		self:playcommand("Set")
	end,
	LoadFont("Common Normal") .. {
		Name = "Text",
		InitCommand = function(self)
			self:align(0, 0)
			self:diffuse(1, 1, 1, 1)
		end
	},
	Def.Sprite {
		Name = "Sprite",
		Texture = THEME:GetPathG("", "fake_heart_beat/heart"),
		InitCommand = function(self)
			self:align(0.5, 0.5)
			self:effectclock("beat")
			self:heartbeat(1.0)
		end,
		SetZoomCommand = function(self)
			self:zoom(height / 64)
		end
	}
}

return t
