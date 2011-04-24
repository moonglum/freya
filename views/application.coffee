races = {
  'human': {
    'body': {
      'start_value': 1,
      'max_value': 6
    },
    'agility': {
      'start_value': 1,
      'max_value': 6
    },
    'reaction': {
      'start_value': 1,
      'max_value': 6
    },
    'strength': {
      'start_value': 1,
      'max_value': 6
    },
    'charisma': {
      'start_value': 1,
      'max_value': 6
    },
    'intuition': {
      'start_value': 1,
      'max_value': 6
    },
    'logic': {
      'start_value': 1,
      'max_value': 6
    },
    'willpower': {
      'start_value': 1,
      'max_value': 6
    },
    'edge': {
      'start_value': 2,
      'max_value': 7
    },
    'magic': {
      'start_value': 1,
      'max_value': 6
    },
    'build_points': 0
  },
  'orc': {
    'body': {
      'start_value': 4,
      'max_value': 9
    },
    'agility': {
      'start_value': 1,
      'max_value': 6
    },
    'reaction': {
      'start_value': 1,
      'max_value': 6
    },
    'strength': {
      'start_value': 3,
      'max_value': 8
    },
    'charisma': {
      'start_value': 1,
      'max_value': 5
    },
    'intuition': {
      'start_value': 1,
      'max_value': 6
    },
    'logic': {
      'start_value': 1,
      'max_value': 5
    },
    'willpower': {
      'start_value': 1,
      'max_value': 6
    },
    'edge': {
      'start_value': 1,
      'max_value': 6
    },
    'magic': {
      'start_value': 1,
      'max_value': 6
    },
    'build_points': 20
  },
  'dwarf': {
    'body': {
      'start_value': 2,
      'max_value': 7
    },
    'agility': {
      'start_value': 1,
      'max_value': 6
    },
    'reaction': {
      'start_value': 1,
      'max_value': 5
    },
    'strength': {
      'start_value': 3,
      'max_value': 8
    },
    'charisma': {
      'start_value': 1,
      'max_value': 6
    },
    'intuition': {
      'start_value': 1,
      'max_value': 6
    },
    'logic': {
      'start_value': 1,
      'max_value': 6
    },
    'willpower': {
      'start_value': 2,
      'max_value': 7
    },
    'edge': {
      'start_value': 1,
      'max_value': 6
    },
    'magic': {
      'start_value': 1,
      'max_value': 6
    },
    'build_points': 25
  },
  'elf': {
    'body': {
      'start_value': 1,
      'max_value': 6
    },
    'agility': {
      'start_value': 2,
      'max_value': 7
    },
    'reaction': {
      'start_value': 1,
      'max_value': 6
    },
    'strength': {
      'start_value': 1,
      'max_value': 6
    },
    'charisma': {
      'start_value': 3,
      'max_value': 8
    },
    'intuition': {
      'start_value': 1,
      'max_value': 6
    },
    'logic': {
      'start_value': 1,
      'max_value': 6
    },
    'willpower': {
      'start_value': 1,
      'max_value': 6
    },
    'edge': {
      'start_value': 1,
      'max_value': 6
    },
    'magic': {
      'start_value': 1,
      'max_value': 6
    },
    'build_points': 30
  },
  'troll': {
    'body': {
      'start_value': 5,
      'max_value': 10
    },
    'agility': {
      'start_value': 1,
      'max_value': 5
    },
    'reaction': {
      'start_value': 1,
      'max_value': 6
    },
    'strength': {
      'start_value': 5,
      'max_value': 10
    },
    'charisma': {
      'start_value': 1,
      'max_value': 4
    },
    'intuition': {
      'start_value': 1,
      'max_value': 5
    },
    'logic': {
      'start_value': 1,
      'max_value': 5
    },
    'willpower': {
      'start_value': 1,
      'max_value': 6
    },
    'edge': {
      'start_value': 1,
      'max_value': 6
    },
    'magic': {
      'start_value': 1,
      'max_value': 6
    },
    'build_points': 40
  }
}

name_of_maximum = null

add_line_to_costs = (category, description, costs, type="costs") ->
  if $("##{type} tbody .#{category}").length > 0
    $("##{type} tbody .#{category} td").attr("textContent", costs)
  else
    $("##{type} tbody").append($("<tr/>", {'class': category})
      .append($("<th/>", {'textContent': description}))
      .append($("<td/>", {'textContent': costs}))
    )
  sum = 0
  $("##{type} tbody td").each (cell) ->
    sum+= parseFloat(this.textContent)
  result = parseFloat($("##{type} thead td").text()) - sum
  $("##{type} tfoot td").text(result)
  
  if type == "costs"
    $("#nuyen thead td").text(Math.min(result, 50) * 5000)

build_points_for_attributes = ->
  sum = 0
  $("#attributes input").each ->
    unless this.value == ""
      sum += (parseInt(this.value) - $(this).data("min_value"))
  sum*= 10
  
  sum+= 15 if name_of_maximum?
  
  return sum

table_change= (selector, german_name, columns, type) ->
  unoccupated_rows = 0
  cost = 0
  $("##{selector} tbody tr").each ->
    if type == undefined
      cost_cell = $(".#{selector}", this)
    else if type == "nuyen"
      cost_cell = $(".#{selector}_nuyen", this)
    else if type == "essence"
      cost_cell = $(".#{selector}_essence", this)
      
    if cost_cell.attr("value") == ""
      unoccupated_rows += 1
    else
      cost += parseFloat(cost_cell.attr("value"))
  if unoccupated_rows == 1
    $("##{selector} tbody").append($("<tr/>")
      .append($("<th/>").append($("<input/>", {'type' : "text"})))
      .append($("<td/>").append($("<input/>", {'type' : "text", 'class' : selector})))
    )
  
  add_line_to_costs("#{selector}_calculation", german_name, cost, type)

$ -> 
  $(window).scroll ->
    $("#head_display").stop().animate({'top': $("body").scrollTop() + 10})
    

  $('#metatype').change (e) ->
    selectedElement = e.target.options[e.target.options.selectedIndex].value
    race = races[selectedElement]
    $("#attributes input, #special_attributes input").each (input_field) ->
      element = $("#attributes input, #special_attributes input")[input_field]
      attribute_value = race[element.name]
      
      if attribute_value?
        old_value = parseInt($(element).attr("value"))
        $(element).data("min_value", attribute_value.start_value)
        $(element).data("max_value", attribute_value.max_value)
        $(element).change()
    add_line_to_costs("race", "Rasse", race.build_points)
    
  $("#attributes input").change ->
    current_value = $(this).attr("value")
    
    excess = build_points_for_attributes() - 200
    if excess > 0
      current_value-= Math.ceil(excess / 10)
      $(this).attr("value", current_value)
    
    max_value = $(this).data("max_value")
    if current_value >= max_value
      if !name_of_maximum?
        $(this).attr("value", max_value)
        name_of_maximum = $(this).attr('name')
      else if name_of_maximum == $(this).attr('name')
        $(this).attr("value", max_value)
      else
        $(this).attr("value", max_value - 1)
    else if current_value < $(this).data("min_value") or $(this).attr("value") == ""
      $(this).attr("value", $(this).data("min_value"))
    
    if $(this).attr("value") < $(this).data("max_value") and name_of_maximum == $(this).attr('name')
      name_of_maximum = null
    
    initiative = parseInt($("#attributes input[name=intuition]").attr("value")) + parseInt($("#attributes input[name=logic]").attr("value"))
    $("#calculated_attributes input[name=initiative]").attr("value", initiative)
    
    physical_damage = 8 + Math.ceil(parseInt($("#attributes input[name=body]").attr("value")) / 2)
    $("#calculated_attributes input[name=physical_damage]").attr("value", physical_damage)
    
    stun_damage = 8 + Math.ceil(parseInt($("#attributes input[name=willpower]").attr("value")) / 2)
    $("#calculated_attributes input[name=stun_damage]").attr("value", stun_damage)
    
    add_line_to_costs("attributes", "Attribute", build_points_for_attributes())
  
  $("#special_attributes input").change ->
    current_value = $(this).attr("value")
    if current_value < $(this).data("min_value") or $(this).attr("value") == ""
      $(this).attr("value", $(this).data("min_value"))
    else if current_value > $(this).data("max_value")
      $(this).attr("value", $(this).data("max_value"))
    
    sum = 0
    $("#special_attributes input").each ->
      my_value = parseInt($(this).attr("value"))
      
      unless $(this).attr("value") == ""
        if my_value == $(this).data("max_value")
          sum += 15
        sum += ((my_value - $(this).data("min_value")) *  10)
    
    add_line_to_costs("special_attributes", "Spezielle Attribute", sum)
  
  $(".quality_cost").change ->
    maximum = 25 - parseInt($("#special_profession :selected").attr("cost"))
    cost = 0
    $(".quality_cost").each ->
      cost += parseInt($(this).attr("value")) unless $(this).attr("value") == "" or $(this).attr("value") == "Zu hohe Kosten"
      if cost > maximum  
        cost -= parseInt($(this).attr("value"))
        $(this).attr("value", "Zu hohe Kosten")
      
    add_line_to_costs("good_quality", "Gaben", cost)
  
  $(".quality_earn").change ->
    earn = 0
    $(".quality_earn").each ->
      earn += parseInt($(this).attr("value")) unless $(this).attr("value") == "" or $(this).attr("value") == "Zu viel Gewinn"
      if earn > 25  
        earn -= parseInt($(this).attr("value"))
        $(this).attr("value", "Zu viel Gewinn")

    add_line_to_costs("bad_quality", "Handicap", -earn)
  
  $(".connections").change ->
    cost = 0
    $(".connections").each ->
      unless $(this).attr("value") == ""
        value = parseInt($(this).attr("value")) 
        if 1 < value <= 6
          cost += value
        else
          $(this).attr("value", 1)
          cost += 1
      
    add_line_to_costs("my_connections", "Connections", cost)
  
  $("#special_profession").change ->
    add_line_to_costs("my_special_profession", "Spezielle Profession", $("#special_profession :selected").attr("cost"))
    $(".quality_cost").change()
    
    if $("#special_profession :selected").attr("value") == "none"
      $("input[name=magic]").attr("value", 1)
      $("#special_attributes input").change()
      $("label[for=magic], input[name=magic]").fadeOut()
    else
      if $("#special_profession :selected").attr("value") == "technomancer"
        $("label[for=magic]").text("Resonanz")
      else
        $("label[for=magic]").text("Magie")
      $("label[for=magic], input[name=magic]").fadeIn()
  
  $("#skill_groups input").change ->
    cost = 0
    $("#skill_groups table").each ->
      my_table = this
      group_value = parseInt($("thead input", my_table).attr("value"))
      if group_value < 0
        group_value = 0
        $("thead input", my_table).attr("value", 0)
      else if group_value > 4
        group_value = 4
        $("thead input", my_table).attr("value", 4)
      cost += (group_value * 10)
      $("tbody tr", my_table).each ->
        relative_value = parseInt($(".relative", this).attr("value"))
        absolute_value = group_value + relative_value
        if absolute_value < 0
          relative_value = 0
          absolute_value = 0
        else if absolute_value > 6
          relative_value = 6 - group_value
          absolute_value = group_value + relative_value
        $(".relative", this).attr("value", relative_value)
        $(".absolute", this).attr("value", absolute_value)
        
        if $(".specialize_select", this).attr("checked")
          cost += 2
          $(".specialize", this).fadeIn()
        else
          $(".specialize", this).fadeOut()
        
        cost += (relative_value * 4)
      add_line_to_costs("skill_groups", "Fertigkeitengruppen", cost)  
      
  $("#spells").delegate("input", "change", ->
    table_change("spells", "Zauber", 2)
  )
  
  $("#knowledge").delegate("input", "change", ->
    table_change("knowledge", "Wissen", 2)
  )
  
  $("#normal_items").delegate("input", "change", ->
    table_change("normal_items", "Normale Gegenstaende", 3, "nuyen")
  )
  
  $("#bioware").delegate("input", "change", ->
    table_change("bioware", "Bioware", 3, "nuyen")
    table_change("bioware", "Bioware", 3, "essence")
  )
  
  $("#cyberware").delegate("input", "change", ->
    table_change("cyberware", "Cyberware", 3, "nuyen")
    table_change("cyberware", "Cyberware", 3, "essence")
  )
  
  $('#metatype, 
    .quality_cost, 
    .quality_earn, 
    .connections, 
    #special_profession, 
    #skill_groups input:first, 
    #spells input:first,
    #knowledge input:first,
    #normal_items input:first,
    #bioware input:first,
    #cyberware input:first')
  .change()
  