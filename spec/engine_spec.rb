require 'engine'
require 'pizza'

describe Engine do
  before do 
    @rows = 3
    @cols = 5
    @mining = 1
    @maxcells = 6
    @pizza = Pizza.new(@rows, @cols, @mining, @maxcells)
    @pizza.load_row_ingredients(1, ("TTTTT".scan /\w/))
    @pizza.load_row_ingredients(2, ("TMMMT".scan /\w/))
    @pizza.load_row_ingredients(3, ("TTTTT".scan /\w/))
  end

  it "can be created and has the expected properties" do
    @engine = Engine.new(@pizza)
    expect(@engine.total_cells).to be == @rows * @cols
    expect(@engine.slice_min_cells).to be == @mining * 2
    expect(@engine.slice_max_cells).to be == @maxcells
    expect(@engine.s_count_w_max_cells).to be == (@rows * @cols) / @maxcells
    expect(@engine.s_w_pending_cells).to be == (@rows * @cols) - ( ((@rows * @cols) / @maxcells) * @maxcells)
    expect((@engine.s_count_w_max_cells * @maxcells) + @engine.s_w_pending_cells).to be == @rows * @cols
  end
end
