# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

degrees = ["light ", "", "dark "]
colors = ["blue", "red", "green", "black", "white", "grey", "pink", "pruple", "indigo", "brown"]

colors.each do |color|
    degrees.each do |degree|
        Color.create(name: degree + color)
    end
end

clothes = {
    #top
    'tank top': ["top",  20, 45],
    't shirt': ["top", 20, 45],
    'tee': ["top", 20, 45],
    'shirt':["top", 20, 45],
    'blouse': ["top", 10, 20],
    'sweatshirt': ["top", 10, 20],
    'long sleeve shirt': ["top", 10, 20],
    'dress shirt': ["top", -30, 20],
    'dress t shirt': ["top", 20, 45],
    'polo': ["top", 20, 45],
    'crop top': ["top", 20, 45],
    'halter top': ["top", 20, 45],
    'tube top': ["top", 20, 45],
    'sports bra': ["top", 30, 45],
    'sweater': ["top", 0, 10],

    #layer1
    'poncho': ["top_layer", 30, 45],
    'sweater vest': ["top_layer", 10, 20],
    'vest': ["top_layer", 10, 20],
    'cardigan': ["top_layer", 0, 20],

    #bottom
    'jeans': ["bottom", -30, 20],
    'mini skirt': ["bottom", 20, 30],
    'skirt': ["bottom", 10, 20],
    'pants': ["bottom", -30, 20],
    'trousers': ["bottom", -30, 20],
    'slacks': ["bottom", 0, 20],
    'shorts': ["bottom", 20, 45],
    'capri pants': ["bottom", 0, 20],
    'overalls': ["bottom", -30, 0],
    'yoga pants': ["bottom", 10, 20],
    'leather pants': ["bottom", 0, 10],
    'snow pants': ["bottom", -30, -20],
    'track pants': ["bottom", 10, 30],
    'dress pants': ["bottom", -10, 30],
    'sweatpants': ["bottom", 10, 30],
    'sweats': ["bottom", 10, 30],

    #all
    'dress': ["all", -20, 20],
    'sundress': ["all", -20, 20],
    'slip dress': ["all", -20, 20],
    'strapless dress': ["all", -20, 20],
    'short dress': ["all", 0, 20],
    'gown': ["all", -30, 20],
}

clothes.each do |key, value|
    case value[0]
    when "all"
        pos = 0
    when "top"
        pos = 1
    when "bottom"
        pos = 2
    when "top_layer"
        pos = 3
    end
    Article.create(name: key, position: pos, temp_min: value[1], temp_max: value[2])
end

Variable.create(name: "temp", value: "11")

["casual", "bussiness casual", "formal"].each do |situation|
    Situation.create(name: situation)
end
samples = [
    ["light brown sweater"], #0
    ["blue ripped jeans"], #1
    ["nike t shirt in white"], #2
    ["light green t shirt"], #3
    ["brown brand pants"], #4
     ["blue flower skirt"], #5
     ["red plain dress"], #6
     ["light blue formal shirt"], #7
     ["black formal pants"],#8
     ["white plain long sleeve shirt"],#9
     ["black formal dress"], #10
     ["blue sunny shorts"], #11
     ["red plain t shirt"]
 ]

samples.each do |ph|
    res = Clothe.prase_and_add(ph[0])

    if res[:success]
        ph << Clothe.find(res[:id])
    else
        ph << Clothe.all.sample
    end
end

su = Suggestion.create
su.clothes << [samples[1][1], samples[12][1]]
su.save
su.good_for_situation("casual")
su.update_response("positive")

su = Suggestion.create
su.clothes << [samples[0][1], samples[1][1]]
su.save
su.good_for_situation("casual")
su.update_response("positive")

su = Suggestion.create
su.clothes << [samples[3][1], samples[11][1]]
su.save
su.good_for_situation("casual")
su.update_response("positive")

su = Suggestion.create
su.clothes << [samples[10][1]]
su.save
su.good_for_situation("bussiness casual")
su.update_response("positive")

su = Suggestion.create
su.clothes << [samples[0][1], samples[1][1]]
su.save
su.good_for_situation("formal")
su.update_response("positive")

su = Suggestion.create
su.clothes << [samples[9][1], samples[4][1]]
su.save
su.good_for_situation("casual")
su.update_response("positive")

su = Suggestion.create
su.clothes << [samples[10][1]]
su.save
su.good_for_situation("bussiness casual")
su.update_response("positive")

su = Suggestion.create
su.clothes << [samples[0][1], samples[4][1]]
su.save
su.good_for_situation("formal")
su.update_response("positive")

su = Suggestion.create
su.clothes << [samples[9][1], samples[1][1]]
su.save
su.update_response("very_negative")
