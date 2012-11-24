# Conway's Game of Life in Ruby
# Bill Laboon

class World

  LIVING_CELL = 1
  DEAD_CELL   = 0

  def initialize(xSize, ySize)
    # Current matrix is matrix being displayed
    # Write matrix is matrix being written to
    @currentMatrix = make_new_matrix(xSize, ySize)
    @writeMatrix = make_new_matrix(xSize, ySize)

    # Making these class variables so I don't have to keep getting
    # the size later on.
    @xSize = xSize
    @ySize = ySize
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
    # This is inefficient.  Need to fix by using refs.
    tempMatrix = @currentMatrix.dup
    @currentMatrix = @writeMatrix.dup
    @writeMatrix = tempMatrix.dup
  end

  def print_world
    @currentMatrix.values.each do |j|
      j.each { |k| print k }
      puts
    end
  end

  def make_live(x, y)
    @write_matrix = LIVING_CELL
  end

  def make_dead(x, y)
    @write_matrix = DEAD_CELL
  end

  def num_living_neighbors(x,y)
    count = 0;
    if @currentMatrix[(x - 1) % @xSize][ (y - 1) % @ySize] == LIVING_CELL then
      count += 1 end
    if @currentMatrix[(x - 1) % @xSize][y]                 == LIVING_CELL then 
      count += 1 end
    if @currentMatrix[(x - 1) % @xSize][(y + 1) % @ySize] == LIVING_CELL then
      count += 1 end
    if @currentMatrix[x][(y - 1) % @ySize]                 == LIVING_CELL then 
      count += 1 end
    if @currentMatrix[x][(y + 1) % @ySize]                == LIVING_CELL then 
      count += 1 end
    if @currentMatrix[(x + 1) % @xSize][(y - 1) % @ySize]  == LIVING_CELL then 
      count += 1 end
    if @currentMatrix[(x + 1) % @xSize][y]                 == LIVING_CELL then 
      count += 1 end
    if @currentMatrix[(x + 1) % @xSize][(y + 1) % @ySize] == LIVING_CELL then
      count += 1 end

    return count
  end

  def iterate

    @currentMatrix.values.each do |j|
      j.each do |k|
        if @currentMatrix[j][k] == LIVING_CELL
            case num_living_neighbors(j,k)
            when 0,1 
              make_dead(j,k)
            when 2,3 
              make_live(j,k)
            when 4,5,6,7,8
              make_dead(j,k)
            end
        else 
            case num_living_neighbors(j,k)
            when 0,1,2 
              make_dead(j,k)
            when 3 
              make_live(j,k)
            when 4,5,6,7,8
              make_dead(j,k)
            end
        end
      end
    end
    swap_matrices

  end

  def set_from_console

  end

  def run_world

    while (true)
      print "[I, #, Q, ?] > "
      command = gets.chomp
      case
        when command.match(/\d/)
          # TODO - IMPLEMENT
          puts "Run # of iters.."
        when command.match(/[Ii]/)
          iterate
          print_world
        when command.match(/[Qq]/)
          exit 0
        when command.match(/[?]/)
          puts "I = iterate, # = number of iters to run, Q to quit, ? for help"
      end
    end
  end

end

# EXECUTION STARTS HERE

world = World.new(5,5)
world.print_world
world.set_from_console
world.run_world
