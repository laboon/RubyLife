# Conway's Game of Life in Ruby
# Bill Laboon

class World

  LIVING_CELL = 1
  DEAD_CELL   = 0

  def initialize(xSize, ySize)

    @matrix1 = make_new_matrix(xSize, ySize)
    @matrix2 = make_new_matrix(xSize, ySize)

    @matrices = [@matrix1, @matrix2]
    @currentMatrix = 0

    # Making these class variables so I don't have to keep getting
    # the size later on.
    @xSize = xSize + 1
    @ySize = ySize + 1
  end

  def make_new_matrix(xSize, ySize)
    toReturn = Hash.new{|j, k| j[k] = []}
    for j in 0..xSize
      for k in 0..ySize
        toReturn[j][k] = 0
      end
    end
    return toReturn
  end

  def swap_matrices
    @currentMatrix = (@currentMatrix + 1) % 2
  end

  def current_matrix
    return @matrices[@currentMatrix]
  end

  def write_matrix
    return @matrices[(@currentMatrix + 1) % 2]
  end

  def print_world
    # puts "Current is " + @currentMatrix.to_s
    current_matrix.values.each do |j|
      j.each { |k| if k == DEAD_CELL then print "." else print "O" end }
      puts
    end
  end

  def derive(x, y)
    xDerived = x % @xSize
    yDerived = y % @ySize
    return xDerived, yDerived
  end

  def make_live(x, y)
    x, y = derive(x, y)
    write_matrix[x][y] = LIVING_CELL
  end

  def make_dead(x, y)
    x, y = derive(x, y)
    write_matrix[x][y] = DEAD_CELL
  end

  def get_cell(x, y)
    x, y = derive(x, y)
    
    #puts "\tx = " + x.to_s + " y = " + y.to_s + ": " +
    #  current_matrix[x][y].to_s + "(" + x.to_s + ", " + y.to_s + ")"
  
    return current_matrix[x][y]
  end

  def num_living_neighbors(x,y)
    count = 0;
    
    if get_cell((x - 1), (y - 1))  == LIVING_CELL then
      count += 1 end
    if get_cell((x - 1), y)        == LIVING_CELL then 
      count += 1 end
    if get_cell((x - 1), (y + 1))  == LIVING_CELL then
      count += 1 end
    if get_cell(x, (y - 1))        == LIVING_CELL then 
      count += 1 end
    if get_cell(x, (y + 1))        == LIVING_CELL then 
      count += 1 end
    if get_cell((x + 1), (y - 1))  == LIVING_CELL then 
      count += 1 end
    if get_cell((x + 1), y)        == LIVING_CELL then 
      count += 1 end
    if get_cell((x + 1), (y + 1))  == LIVING_CELL then
      count += 1 end
    # puts x.to_s + "," + y.to_s + ": " + count.to_s + " neighbors"
    return count
  end

  def iterate
    x = 0
    current_matrix.values.each do |j|
      y = 0
      j.each do |k|
        if k == LIVING_CELL
            case num_living_neighbors(x,y)
            when 0,1 
              make_dead(x,y)
            when 2,3 
              make_live(x,y)
            when 4,5,6,7,8
              make_dead(x,y)
            end
        else 
            case num_living_neighbors(x,y)
            when 0,1,2 
              make_dead(x,y)
            when 3 
              make_live(x,y)
            when 4,5,6,7,8
              make_dead(x,y)
            end
        end
        y += 1
      end
      x += 1
    end
    swap_matrices

  end

  def flip_cell(x, y)
    xDerived = x % @xSize
    yDerived = y % @ySize
    newVal = LIVING_CELL
    if get_cell(xDerived, yDerived) == LIVING_CELL then
      newVal = DEAD_CELL
    else
      newVal = LIVING_CELL
    end
    current_matrix[xDerived][yDerived] = newVal;
  end

  def set_from_console
    entered = ""
    while !(entered.match(/[Ss]/))
      print "Flip cell (x y), s to stop > "
      entered = gets.chomp
      if (entered.match(/[Ss]/)) then
        break
      else
        x, y = entered.split(/ /)
        x = x.to_i
        y = y.to_i
        flip_cell(x,y)
        print_world
      end
    end
  end

  def run_world

    while (true)
      print_world
      print "[I, #, Q, ?] > "
      command = gets.chomp
      case
        when command.match(/\d/)
          command.to_i.times { iterate }
        when command.match(/[Ii]/)
          iterate
        when command.match(/[Qq]/)
          exit 0
        when command.match(/[?]/)
          puts "I = iterate, # = number of iters to run, Q to quit, ? for help"
      end
    end
  end

end

# EXECUTION STARTS HERE

print "Size of world (integer) > "
size = gets.chomp.to_i

world = World.new(size - 1, size - 1)
world.print_world
world.set_from_console
world.run_world
