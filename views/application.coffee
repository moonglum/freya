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

add_line_to_costs = (category, description, costs) ->
  if $("#costs tbody .#{category}").length > 0
    $("#costs tbody .#{category} td").attr("textContent", costs)
  else
    $("#costs tbody").append($("<tr/>", {'class': category})
      .append($("<th/>", {'textContent': description}))
      .append($("<td/>", {'textContent': costs}))
    )
  sum = 0
  $("#costs tbody td").each (cell) ->
    sum+= parseInt(this.textContent)
  result = parseInt($("#costs thead td").text()) - sum
  $("#costs tfoot td").text(result);

$ -> 
  $('#metatype').change (e) ->
    selectedElement = e.target.options[e.target.options.selectedIndex].value
    race = races[selectedElement]
    $("#attributes input").each (input_field) ->
      element = $("#attributes input")[input_field]
      attribute_value = race[element.name]
      
      if attribute_value?
        old_value = parseInt($(element).attr("value"))
        $(element).data("min_value", attribute_value.start_value)
        $(element).data("max_value", attribute_value.max_value)
        $(element).change()
    add_line_to_costs("race", "Rasse", race.build_points)
    
  $("#attributes input").change ->
    current_value = $(this).attr("value")
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
    
    sum = 0
    $("#attributes input").each ->
      unless this.value == ""
        sum += (parseInt(this.value) - $(this).data("min_value"))
    sum*= 10
    
    sum+= 15 if name_of_maximum?
    
    add_line_to_costs("attributes", "Attribute", sum)
  
  $('#metatype').change()