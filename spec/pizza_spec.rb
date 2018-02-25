require 'pizza'

describe Pizza do
  before do
      
  end

  it "can be created and has the expected properties" do
    rows = rand(1..1000)
    cols = rand(1..1000)
    mining = rand(1..1000)
    maxcells = rand(1..1000)
    pizza = Pizza.new(rows, cols, mining, maxcells)
    expect(pizza.rows).to be == rows
    expect(pizza.cols).to be == cols
    expect(pizza.min_ings_slice).to be == mining
    expect(pizza.max_cells_slice).to be == maxcells
  end

  it "can load ingredients into cells and are loaded properly" do
    pizza = Pizza.new(2, 6, 1, 3)

    row_ings_1 = "TTTMMT".scan /\w/
    row_ings_2 = "MMMMMM".scan /\w/

    pizza.load_row_ingredients(0, row_ings_1)
    pizza.load_row_ingredients(1, row_ings_2)

    expect(pizza.cells[[0, 0]]).to be == 'T'
    expect(pizza.cells[[0, 1]]).to be == 'T'
    expect(pizza.cells[[0, 2]]).to be == 'T'
    expect(pizza.cells[[0, 3]]).to be == 'M'
    expect(pizza.cells[[0, 4]]).to be == 'M'
    expect(pizza.cells[[0, 5]]).to be == 'T'
    
    expect(pizza.cells[[1, 0]]).to be == 'M'
    expect(pizza.cells[[1, 1]]).to be == 'M'
    expect(pizza.cells[[1, 2]]).to be == 'M'
    expect(pizza.cells[[1, 3]]).to be == 'M'
    expect(pizza.cells[[1, 4]]).to be == 'M'
    expect(pizza.cells[[1, 5]]).to be == 'M'
  end


end
