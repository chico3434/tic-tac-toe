
function drawX(i, j)
  love.graphics.setColor(1,1,1)
  stepX = grid.width/3 
  x = stepX * (j-1)

  stepY = grid.height/3 
  y = stepY * (i-1)

  love.graphics.line(x, y, x + stepX, y + 200)
  love.graphics.line(x, y + 200, x + stepX, y)
end

function drawO(i, j)
  love.graphics.setColor(1,1,1)
  stepX = grid.width/3 
  x = stepX * (j-1) + stepX/2

  stepY = grid.height/3 
  y = stepY * (i-1) + 100

  love.graphics.ellipse("line", x,y,stepX/2,100)
end

function drawGrid()
  love.graphics.setColor(1,1,1)
  -- horizontal
  step = grid.height/3
  love.graphics.line(0, step, grid.width, step)
  love.graphics.line(0, step*2, grid.width, step*2)

  -- vertical
  step = grid.width/3
  love.graphics.line(step, 0, step, grid.height)
  love.graphics.line(step*2, 0, step*2, grid.height)
end

function verifyEnd()
  for s=1,8 do
    if grid[end_situations[s][1][1]][end_situations[s][1][2]] == grid[end_situations[s][2][1]][end_situations[s][2][2]] and grid[end_situations[s][1][1]][end_situations[s][1][2]] == grid[end_situations[s][3][1]][end_situations[s][3][2]] and grid[end_situations[s][1][1]][end_situations[s][1][2]] ~= '' then
      game.win = grid[end_situations[s][1][1]][end_situations[s][1][2]]
      game.running = false
    end   
  end
end

function drawEndScreen()
  love.graphics.setColor(1,1,1)
  love.graphics.print('O Jogador ' .. game.win .. ' venceu!!')
end

function love.load() 

  grid = {}
  grid.width = 800
  grid.height = 600
  grid[1] = {'','',''}
  grid[2] = {'','',''}
  grid[3] = {'','',''}

  game = {}
  game.running = true
  game.win = ''

  turn = 'X'

  end_situations = {
    {
      {1,1},{1,2},{1,3}
    },{
      {1,1},{2,2},{3,3}
    },{
      {1,1},{2,1},{3,1}
    },{
      {1,2},{2,2},{3,2}
    },{
      {1,3},{2,3},{3,3}
    },{
      {1,3},{2,2},{3,1}
    },{
      {2,1},{2,2},{2,3}
    }, {
      {3,1},{3,2},{3,3}
    }
  }

end

function love.update(dt)

end

function love.draw()
  if game.running then
    drawGrid()
    for i=1,3 do
      for j=1,3 do
        if grid[i][j] == 'X' then
          drawX(i,j)
        elseif grid[i][j] == 'O' then
          drawO(i,j)
        end
      end
    end
  else 
    drawEndScreen()
  end
end

function love.mousepressed(x, y, button, istouch)
  stepX = grid.width/3
  stepY = grid.height/3 
  i = 0
  j = 0
  if(button == 1) then
    if x <= stepX then
       j = 1
    elseif x <= stepX * 2 then
      j = 2
    else 
      j = 3
    end 
    if y <= stepY then
      i = 1
    elseif y <= stepY * 2 then
     i = 2
    else 
     i = 3
    end
    if grid[i][j] == '' and game.running then
      grid[i][j] = turn
      verifyEnd()
      if turn == 'X' then
        turn = 'O'
      else 
        turn = 'X'
      end
    end
  end
end