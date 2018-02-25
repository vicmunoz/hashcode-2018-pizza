
class Pizza
  attr_reader :rows, :cols, :min_ings_slice, :max_cells_slice, :cells
  def initialize(rows, cols, mining, maxcells)
    @rows = rows
    @cols = cols
    @min_ings_slice = mining
    @max_cells_slice = maxcells
    @cells = Hash.new
  end

  def load_row_ingredients(row, cells_ings)
    col_count = 0

    raise "error - not equal ingredients than columns" if cells_ings.size != @cols.to_i
    
    cells_ings.each do |ing|
      @cells[[row, col_count]] = ing
      col_count += 1
    end  
  end
end

