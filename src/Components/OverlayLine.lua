OverlayLine = {}

--- Util method to draw text to the screen
-- @param obstacleName Name of textbox
-- @param text String to display
-- @param kwargs Format values (defaults to Chamber Number format)
-- font, font_size, color, outline_color, justification, shadow_color
function OverlayLine.display(obstacleName, text, kwargs)
    -- Use Chamber Number as default font style
    local text_config_table = DeepCopyTable(UIData.CurrentRunDepth.TextFormat)

    -- Throw the text somewhere in the middle of the screen, if not specified
    local x_pos = 500
    local y_pos = 500
    local group = "Combat_Menu_TraitTray_Overlay"

    if kwargs ~= nil then
        text_config_table.Font = kwargs.font or text_config_table.Font
        text_config_table.FontSize = kwargs.font_size or text_config_table.FontSize
        text_config_table.Color = kwargs.color or text_config_table.Color
        text_config_table.OutlineColor = kwargs.outline_color or text_config_table.OutlineColor
        text_config_table.Justification = kwargs.justification or text_config_table.Justification
        text_config_table.ShadowColor = kwargs.shadow_color or { 0, 0, 0, 0 }
        x_pos = kwargs.x_pos or x_pos
        y_pos = kwargs.y_pos or y_pos
        group = kwargs.group or group
    end

    -- If this anchor was already created, just modify the existing textbox
    if ScreenAnchors[obstacleName] ~= nil then
        ModifyTextBox({
            Id = ScreenAnchors[obstacleName],
            Text = text,
            Color = (kwargs or { color = Color.White }).color or text_config_table.Color
        })
    else -- create a new anchor/textbox and fade it in
        ScreenAnchors[obstacleName] = CreateScreenObstacle({
            Name = "BlankObstacle",
            X = x_pos,
            Y = y_pos,
            Group = group
        })

        CreateTextBox(
            MergeTables(
                text_config_table,
                {
                    Id = ScreenAnchors[obstacleName],
                    Text = text
                }
            )
        )

        ModifyTextBox({
            Id = ScreenAnchors[obstacleName],
            FadeTarget = 1,
            FadeDuration = 0.0
        })
    end
end

function OverlayLine.destroy(obstacleName)
    if ScreenAnchors[obstacleName] ~= nil then
        Destroy({ Id = ScreenAnchors[obstacleName] })
        ScreenAnchors[obstacleName] = nil
    end
end
