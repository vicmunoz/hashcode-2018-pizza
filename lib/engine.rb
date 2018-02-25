#!/usr/bin/env ruby
#

class Engine
  attr_reader :total_cells, :slice_min_cells, :slice_max_cells, :s_count_w_max_cells, :s_w_pending_cells
  def initialize(pizza)
    @total_cells = pizza.rows.to_i * pizza.cols.to_i    
    @slice_min_cells = pizza.min_ings_slice.to_i * 2
    @slice_max_cells = pizza.max_cells_slice.to_i

    @s_count_w_max_cells = @total_cells / @slice_max_cells
    @s_w_pending_cells = @total_cells - ( @s_count_w_max_cells * @slice_max_cells )
  end





  

end
