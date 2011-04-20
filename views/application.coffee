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

calculate_build_points = ->
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
        if old_value < attribute_value.start_value or $(element).attr("value") == ""
          $(element).attr("value", attribute_value.start_value)
        else if old_value > attribute_value.max_value
          $(element).attr("value", attribute_value.max_value)
        
        $(element).data("max_value", attribute_value.max_value)
    if $("#costs tbody .race").length > 0
      $("#costs tbody .race td").attr("textContent", races[selectedElement].build_points)
    else
      $("#costs tbody").append($("<tr/>", {'class': "race"})
        .append($("<th/>", {'textContent': "Rasse"}))
        .append($("<td/>", {'textContent': races[selectedElement].build_points}))
      )
    calculate_build_points()
    
  $("#attributes input").change ->
    current_value = $(this).attr("value")
    max_value = $(this).data("max_value")
    if current_value > max_value
      $(this).attr("value", max_value)
    else if current_value < 1
      $(this).attr("value", 1)
  
  $('#metatype').change()