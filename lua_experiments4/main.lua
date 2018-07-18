function love.load()

    love.window.setMode(700, 750, {resizable=true, vsync=false, minwidth=400, minheight=300})
    --Load the image
    image = love.graphics.newImage("tile.png")
    image2 = love.graphics.newImage("toilet-paper-icon(min).png")
    image3 = love.graphics.newImage("shit.png")
    --We need the full image width and height for creating the quads
    width = image:getWidth()
    height = image:getHeight()

    --The width and height of each tile is 32, 32
    --So we could do:
    -- width = 32
    -- height = 32
    -- --But let's say you didn't know the width and height of a tile
    -- --You can also use the number of rows and columns in the tileset
    -- --Our tileset has 2 rows and 3 columns
    -- --But we need to subtract 2 to make up for the empty pixels we included to prevent bleeding
    -- width = (image_width / 3) - 2
    -- height = (image_height / 2) - 2

    --Create the quads
    -- quads = {}

    -- for i=0,1 do
    --     for j=0,2 do
    --         --The only reason this code is split up in multiple lines
    --         --is so that it fits the page
    --         table.insert(quads,
    --             love.graphics.newQuad(
    --                 1 + j * (width + 2),
    --                 1 + i * (height + 2),
    --                 width, height,
    --                 image_width, image_height))
    --     end
    -- end
    papercount = 0
    tilemap = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
    }
    math.randomseed( os.time() )
    for i=2,20 do
        for j=2,19 do
            if tilemap[i-1][j-1] < 1 then 
                tilemap[i][j]= math.random(0,1)
                -- print(tilemap[i][j])
            end
        end
    end
    for i=2,20,math.random(2,5) do
        for j=3,19,math.random(2,5) do
            if tilemap[i][j] ~= 1 then 
                tilemap[i][j]= math.random(-2,0)
                -- if tilemap[i][j] == -1 then
                --     shitx = j * width
                --     shity = i * height
                -- -- print(tilemap[i][j])
            end
        end
    end
    player = {
        image = love.graphics.newImage("playermin.png"),
        x = 80,
        y = 80,
        width = image:getWidth(),
        height = image:getHeight(),
        speed = 200,
        angle = 0,
        origin_x = width / 2,
        origin_y = 0
    }
end

function love.update(dt)
    mouse_x, mouse_y = love.mouse.getPosition()
    distance = getDistance(player.x, player.y, mouse_x, mouse_y)
    player.angle = math.atan2(mouse_y - player.y, mouse_x - player.x)
    cos = math.cos(player.angle)
    sin = math.sin(player.angle)
    nextXTile = math.floor((player.x + player.speed * cos * dt)/32)
    nextYTile = math.floor((player.y + player.speed * sin * dt)/32)
    -- for i=2,20,math.random(2,5) do
    --     for j=3,19,math.random(2,5) do
    --         if tilemap[i][j] == -1 then 
    --             tilemap[i][j] = 0
                

    --             if tilemap[i+1][j] ~= 1 then
    --                 shitx = shitx
    --                 shity = i * height
    --                 tilemap[i+1][j] = -1
    --                 break
    --             end
    --             if tilemap[i-1][j] ~= 1 then
    --                 tilemap[i-1][j] = -1
    --                 break
    --             end
    --             if tilemap[i][j+1] ~= 1 then
    --                 tilemap[i][j+1] = -1
    --                 break
    --             end
    --             if tilemap[i][j-1] ~= 1 then
    --                 tilemap[i][j-1] = -1
    --                 break
    --             end
    --         end
    --     end
    -- end
    if (distance > 8) then
        if isEmpty(nextXTile, nextYTile) then
                player.x = player.x + player.speed * cos * dt
                player.y = player.y + player.speed * sin * dt
        end
        if isPaper(nextXTile, nextYTile) then
            player.x = player.x + player.speed * cos * dt
            player.y = player.y + player.speed * sin * dt
            tilemap[nextYTile][nextXTile] = 0
            papercount = papercount + 1
        end
        if isShit(nextXTile, nextYTile) and love.mouse.isDown(1) and papercount % 2 >= 0 and papercount > 0 then 
            tilemap[nextYTile][nextXTile] = 0
            player.x = player.x + player.speed * cos * dt
            player.y = player.y + player.speed * sin * dt
            papercount = papercount - 2

        end
    end
end

function love.draw()
    for i,row in ipairs(tilemap) do
        for j,tile in ipairs(row) do
            if tile == 1 then
                --Draw the image with the correct quad
                love.graphics.draw(image, j * width, i * height)
                -- love.graphics.print(j .. "," .. i, (j * width)+2, (i * height)+2)
            end
            if tile == -2  then
                --Draw the image with the correct quad
                love.graphics.draw(image2, j * width, i * height)
                -- love.graphics.print(j .. "," .. i, (j * width)+2, (i * height)+2)
            end 
            if tile == -1  then
                --Draw the image with the correct quad
                love.graphics.draw(image3, j * width, i * height)
                -- love.graphics.print(j .. "," .. i, (j * width)+2, (i * height)+2)
            end 
        end
    end
    love.graphics.draw(player.image, player.x , player.y, player.angle+math.pi/2, 1,1, player.origin_x, player.origin_y)
    love.graphics.print("Paper Count: " .. papercount,10,10)
    -- love.graphics.print("y: " .. player.y,10,30)
    -- love.graphics.print("currentXT: " .. currentXTile,10,50)
    -- love.graphics.print("currentYT: " .. currentYTile,10,70)
    -- love.graphics.print("Angle: " .. player.angle,150,10)
end

function isEmpty(x, y)
    return tilemap[y][x] == 0
end

function isPaper(x, y)
    return tilemap[y][x] == -2
end

function isShit(x, y)
    return tilemap[y][x] == -1
end
isRepeat = love.keyboard.setKeyRepeat( true )

function love.keypressed(key)

    -- x = player.x
    -- y = player.y
    -- if key == "left" then
    --     x = x - 1
    --     print(key)
    -- elseif key == "right" then
    --     x = x + 1
    --     print(key)
    -- elseif key == "up" then
    --     y = y - 1
    --     print(key)
    -- elseif key == "down" then
    --     y = y + 1
    --     print(key)
    -- end
    

    -- if isEmpty(x, y) then
    --     player.x = x
    --     player.y = y
    -- elseif key == "space" then
    --     player.tile_x = x
    --     player.tile_y = y
    -- end

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
-- function love.keypressed(key)
--     if key == "space" then
--         player.tile_x = x
--         player.tile_y = y
--     end
-- end
