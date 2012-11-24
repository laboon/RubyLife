# Conway's Game of Life in Ruby
# Bill Laboon

class World

  LIVING_CELL = 1
  DEAD_CELL   = 0

  def initialize(xSize, ySize)
    # @matrix1 = 
    # @matrix2 =
    @currentMatrix = make_new_matrix(xSize, ySize)
    @writeMatrix = make_new_matrix(xSize, ySize)
  end

  def make_new_matrix(xSize, ySize)
    toReturn = Hash.new(|j, k| j[k] = [])
    for j in 0..@xSize
      for k in 0..@ySize
        @matrix[j][k] = DEAD_CELL
      end
    end
    return toReturn
  end

  def swap_matrices
    tempMatrix = @current_matrix
    @currentMatrix = @write_matrix
    @writeMatrix = tempMatrix
  end

  def print

  end

  def make_live(x, y)
    # 
  end

  def make_dead(x, y)
    #
  end

  def num_living_neighbors(x,y)
    
  end

  def iterate
    
  end

end

# EXECUTION STARTS HERE

world = World.new(5,5)
