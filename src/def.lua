---@meta HadesSpeedrunning-PrintUtil
local public = {}

--- Draw text to the screen
-- @param obstacleName Name of textbox
-- @param text String to display
-- @param kwargs Format values (defaults to Chamber Number format)
-- font, font_size, color, outline_color, justification, shadow_color, x_pos, y_pos, group
function public.OverlayLine.display(obstacleName, text, kwargs) end

-- @param obstacleName Name of textbox
function public.OverlayLine.destroy(obstacleName) end

return public
