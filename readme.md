# Fake Heart Beat Visualizer
It will get your heart racing.
## About
"Fake Heart Beat Visualizer" is an Etterna add-on designed solely to display a simulated heart rate.
The heart rate displays the BPM of the current song.
There is probably no demand for it.
## How to use
1. Please copy `fake_heart_beat` to the following path
```
Etterna/Themes/<YourTheme>/Graphics
```
2. Please open `BGAnimations/ScreenGameplay Overlay/default.lua`
3. Please copy `t[#t+1] = LoadActor(THEME:GetPathG("","fake_heart_beat))` to the following location. Here is an example for Rebirth.
```lua
local t = Def.ActorFrame {Name = "GameplayOverlayDefaultFile"}

t[#t+1] = LoadActor("elements")
t[#t+1] = LoadActor("titlesplash")
t[#t+1] = LoadActor(THEME:GetPathG("","fake_heart_beat")) -- This

return t
```
## Settings
In `fake_heart_beat/default.lua`, you can configure the following settings.
- position x, y
- zoom
You can configure this using the following code.
``` lua
-- Actor details
local details = {
	x = 0,
	y = 0,
	zoom = 3.0
}
```
You should avoid changing any settings other than this one.
I just put this together on a whim, so you might find it a bit clunky. I apologize for that.