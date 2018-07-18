function love.load()
    image = love.graphics.newImage("jump.png")
    local width = image:getWidth()
    local height = image:getHeight() 

    frames = {}

    local frame_width = 117
    local frame_height = 233
    frame_x = 200
    frame_y = 200
    frame_speed = 400
    frame_angle = 0
    frame_origin_x = frame_width / 2
    frame_origin_y = frame_height / 2
    for i=0,4 do
        table.insert(frames, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, width, height))
    end

    --Don't forget the currentFrame variable!
    currentFrame = 1
end

function love.update(dt)
    mouse_x, mouse_y = love.mouse.getPosition()
    frame_angle = math.atan2(mouse_y - frame_y, mouse_x - frame_x)
    cos = math.cos(frame_angle)
    sin = math.sin(frame_angle)
    distance = getDistance(frame_x, frame_y, mouse_x, mouse_y)
    currentFrame = currentFrame + 10 * dt
    if distance > 50 then
        frame_x = frame_x + frame_speed * cos * dt
        frame_y = frame_y + frame_speed * sin * dt
    end
    if currentFrame >= 6 then
        currentFrame = 1
    end
end

function love.draw()
    if mouse_x < frame_x then
        love.graphics.draw(image, frames[math.floor(currentFrame)], frame_x, frame_y,frame_angle-math.pi, 1,1, frame_origin_x, frame_origin_y)    
    else
        love.graphics.draw(image, frames[math.floor(currentFrame)], frame_x, frame_y,frame_angle, 1,1, frame_origin_x, frame_origin_y)
    end
    love.graphics.print("mouse_x: " .. mouse_x, 10, 30)
    love.graphics.circle("fill", mouse_x, mouse_y, 3)
end

function getDistance(x1, y1, x2, y2)
    local horizontal_distance = x1 - x2
    local vertical_distance = y1 - y2
    --Both of these work
    local a = horizontal_distance ^2
    local b = vertical_distance ^2

    local c = a + b
    local distance = math.sqrt(c)
    return distance
end