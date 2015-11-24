UI = require 'Thranduil/UI'
Theme = require 'Thranduil/Theme'

function load ()
    UI.registerEvents()
    slider = UI.Slider(love.window.getWidth() - 400, 0, 400, 50, { extensions = {Theme.Slider}, vertical = no, value_interval = 1} )
        slider.value = 100
        slider.min_value = 0
        slider.max_value = 100
end

function love.update (dt)
    love.audio.setVolume (slider.value / 100)

    slider:update (dt)
end

function love.draw ()
    love.graphics.setColor ( 255, 255, 255, 255 )
    love.graphics.setBackgroundColor ( 0, 0, 0 )

    love.graphics.print ("Sound: ".. slider.value, 50, 25, 0, 2, 2)
    slider:draw ()
end