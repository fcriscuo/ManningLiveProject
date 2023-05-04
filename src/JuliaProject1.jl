module ManningLiveProject

using Printf
mutable struct Store
    stock::Dict{String,Int}
    prices::Dict{String,Float64}
    funds::Float64
end

function calculate_cost(store:: Store,item::String)
    item_cost = get(store.stock,item,0) * get(store.prices,item,0.0)
    item_cost
end

function delivery!(store::Store, item_list::Array{String})
    for n in eachindex(item_list)
        item = item_list[n]
        if (haskey(store.stock,item))
            store.stock[item] +=1
        else
            store.stock[item] = 1
        end
    end
end

function delivery(store::Store, item_dict::Dict{String,Int})
    for (key, value) in item_dict
        if(haskey(store.stock,key))
            store.stock[key] += value
        else
            store.stock[key] = value
        end
    end

end

function is_available(store::Store, item::String, quantity::Int) 
    haskey(store.stock,item) && store.stock[item]>= quantity  
end

function sell(store::Store, item_list::Array{String})
    for n in eachindex(item_list)
        item = item_list[n]
        if (is_available(store,item,1))
            store.stock[item] -= 1
            store.funds += store.prices[item]
            if (store.stock[item] == 0)
                delete!(store.stock,item)
            end
        else 
            @printf "Item %s is not in stock\n" item
        end
    end
end

function sell(store::Store, item_dict::Dict{String,Int})
    for (item,quantity) in item_dict
        if(is_available(store,item,quantity))
            store.stock[item] -= quantity
            store.funds +=store. prices[item] * quantity
            if (store.stock[item] == 0)
                delete!(store.stock, item)
            end
        else
            @printf "%d exceeds the current inventory for item %s \n" quantity item
        end
    end
end     

function init_inventory()
    
    food_stock = Dict([("milk",0),("eggs",0),("cheese",0), ("bread",0),("chocolate",0), ("flour",0), ("tomatoes",0) ,
     ("baguette",0), ("candy", 0), ("sugar",0) ])
    prices = Dict([("milk",1.00),("eggs",2.00),("cheese",3.50), ("bread",0.09),("chocolate",2.20),
     ("flour",0.5), ("tomatoes",1.50),("baguette",3.00),("candy",3.00) , ("sugar", 4.50)])
    store::Store = Store(food_stock,prices, 100.00 )
end

store = init_inventory()

new_items = Dict("eggs" => 12, "bread" => 2, "tomatoes" => 3)
#update inventory
delivery(store,new_items)

new_cost = calculate_cost(store,"baguette") + calculate_cost(store,"eggs") + calculate_cost(store,"candy") +
    calculate_cost(store,"cheese")
@printf "New cost = \$ %.2f \n" new_cost

sales_list::Array{String} = ["eggs", "bread","eggs", "bread", "tomatoes", "bread", "pasta","candy"]
sell(store, sales_list)

store = init_inventory()
# add some items
delivery(store,Dict("eggs" => 12, "bread" => 2, "tomatoes" => 3, "candy"=>20, "baguette"=>8) )
sales_order = Dict("eggs" => 6, "bread" => 6, "tomatoes" => 3, "candy"=>30, "baguette"=>6,"pasta"=>10)
sell(store, sales_order)
@printf "Final funds = %.2f \n" store.funds

end