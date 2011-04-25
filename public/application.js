(function() {
  var add_line_to_costs, build_points_for_attributes, name_of_maximum, races, table_change;
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
  };
  name_of_maximum = null;
  add_line_to_costs = function(category, description, costs, type) {
    var knp, result, sum;
    if (type == null) {
      type = "costs";
    }
    if ($("#" + type + " tbody ." + category).length > 0) {
      $("#" + type + " tbody ." + category + " td").attr("textContent", costs);
    } else {
      $("#" + type + " tbody").append($("<tr/>", {
        'class': category
      }).append($("<th/>", {
        'textContent': description
      })).append($("<td/>", {
        'textContent': costs
      })));
    }
    sum = 0;
    $("#" + type + " tbody td").each(function(cell) {
      return sum += parseFloat(this.textContent);
    });
    result = parseFloat($("#" + type + " thead td").text()) - sum;
    $("#" + type + " tfoot td").text(result);
    if (type === "costs") {
      $("#nuyen thead td").text(Math.min(result, 50) * 5000);
      knp = parseInt($("input[name=logic]").attr("value")) + parseInt($("input[name=intuition]").attr("value")) + parseInt($("input[name=additional_knowledge]").attr("value"));
      return $("#knowledgepoints thead td").text(knp * 3);
    }
  };
  build_points_for_attributes = function() {
    var sum;
    sum = 0;
    $("#attributes input").each(function() {
      if (this.value !== "") {
        return sum += parseInt(this.value) - $(this).data("min_value");
      }
    });
    sum *= 10;
    if (name_of_maximum != null) {
      sum += 15;
    }
    return sum;
  };
  table_change = function(selector, german_name, columns, specialization, type) {
    var cost, row, unoccupated_rows;
    if (specialization == null) {
      specialization = false;
    }
    if (type == null) {
      type = "costs";
    }
    unoccupated_rows = 0;
    cost = 0;
    $("#" + selector + " tbody tr").each(function() {
      var cost_cell, val;
      if (type === "specialize") {
        if ($("." + selector + "_specialize", this).attr("checked")) {
          cost += 2;
          return $(".specialize", this).fadeIn();
        } else {
          return $(".specialize", this).fadeOut();
        }
      } else {
        if (type === "costs" || type === "knowledgepoints") {
          cost_cell = $("." + selector, this);
          val = parseInt(cost_cell.attr("value"));
          if (val !== NaN) {
            if (val < 0) {
              cost_cell.attr("value", 0);
            } else if (val > 6) {
              cost_cell.attr("value", 6);
            }
          }
        } else if (type === "nuyen") {
          cost_cell = $("." + selector + "_nuyen", this);
        } else if (type === "essence") {
          cost_cell = $("." + selector + "_essence", this);
        }
        if (cost_cell.attr("value") === "") {
          return unoccupated_rows += 1;
        } else {
          return cost += parseFloat(cost_cell.attr("value"));
        }
      }
    });
    if (unoccupated_rows === 1) {
      row = $("<tr/>").append($("<th/>").append($("<input/>", {
        'type': "text"
      })));
      if (columns === 2) {
        row.append($("<td/>").append($("<input/>", {
          'type': "text",
          'class': selector
        })));
      } else if (columns === 3) {
        row.append($("<td/>").append($("<input/>", {
          'type': "text",
          'class': selector + "_nuyen"
        }))).append($("<td/>").append($("<input/>", {
          'type': "text",
          'class': selector + "_essence"
        })));
      }
      if (specialization) {
        row.append($("<td/>").append($("<input/>", {
          'type': "checkbox",
          'class': "specialize_select"
        })));
      }
      $("#" + selector + " tbody").append(row);
    }
    return add_line_to_costs("" + selector + "_" + type + "_calculation", german_name, cost, type === "specialize" ? "costs" : type);
  };
  $(function() {
    $(window).scroll(function() {
      return $("#head_display").stop().animate({
        'top': $(document).scrollTop() + 10
      });
    });
    $('#metatype').change(function(e) {
      var race, selectedElement;
      selectedElement = e.target.options[e.target.options.selectedIndex].value;
      race = races[selectedElement];
      $("#attributes input, #special_attributes input").each(function(input_field) {
        var attribute_value, element, old_value;
        element = $("#attributes input, #special_attributes input")[input_field];
        attribute_value = race[element.name];
        if (attribute_value != null) {
          old_value = parseInt($(element).attr("value"));
          $(element).data("min_value", attribute_value.start_value);
          $(element).data("max_value", attribute_value.max_value);
          return $(element).change();
        }
      });
      return add_line_to_costs("race", "Rasse", race.build_points);
    });
    $("#attributes input").change(function() {
      var current_value, excess, initiative, max_value, physical_damage, stun_damage;
      current_value = $(this).attr("value");
      excess = build_points_for_attributes() - 200;
      if (excess > 0) {
        current_value -= Math.ceil(excess / 10);
        $(this).attr("value", current_value);
      }
      max_value = $(this).data("max_value");
      if (current_value >= max_value) {
        if (!(name_of_maximum != null)) {
          $(this).attr("value", max_value);
          name_of_maximum = $(this).attr('name');
        } else if (name_of_maximum === $(this).attr('name')) {
          $(this).attr("value", max_value);
        } else {
          $(this).attr("value", max_value - 1);
        }
      } else if (current_value < $(this).data("min_value") || $(this).attr("value") === "") {
        $(this).attr("value", $(this).data("min_value"));
      }
      if ($(this).attr("value") < $(this).data("max_value") && name_of_maximum === $(this).attr('name')) {
        name_of_maximum = null;
      }
      initiative = parseInt($("#attributes input[name=intuition]").attr("value")) + parseInt($("#attributes input[name=logic]").attr("value"));
      $("#calculated_attributes input[name=initiative]").attr("value", initiative);
      physical_damage = 8 + Math.ceil(parseInt($("#attributes input[name=body]").attr("value")) / 2);
      $("#calculated_attributes input[name=physical_damage]").attr("value", physical_damage);
      stun_damage = 8 + Math.ceil(parseInt($("#attributes input[name=willpower]").attr("value")) / 2);
      $("#calculated_attributes input[name=stun_damage]").attr("value", stun_damage);
      return add_line_to_costs("attributes", "Attribute", build_points_for_attributes());
    });
    $("input[name=name]").change(function() {
      return $("title").text("Freya: " + $("input[name=name]").attr("value"));
    });
    $("#special_attributes input").change(function() {
      var current_value, sum;
      current_value = $(this).attr("value");
      if (current_value < $(this).data("min_value") || $(this).attr("value") === "") {
        $(this).attr("value", $(this).data("min_value"));
      } else if (current_value > $(this).data("max_value")) {
        $(this).attr("value", $(this).data("max_value"));
      }
      sum = 0;
      $("#special_attributes input").each(function() {
        var my_value;
        my_value = parseInt($(this).attr("value"));
        if ($(this).attr("value") !== "") {
          if (my_value === $(this).data("max_value")) {
            sum += 15;
          }
          return sum += (my_value - $(this).data("min_value")) * 10;
        }
      });
      return add_line_to_costs("special_attributes", "Spezielle Attribute", sum);
    });
    $(".quality_cost").change(function() {
      var cost, maximum;
      maximum = 25 - parseInt($("#special_profession :selected").attr("cost"));
      cost = 0;
      $(".quality_cost").each(function() {
        if (!($(this).attr("value") === "" || $(this).attr("value") === "Zu hohe Kosten")) {
          cost += parseInt($(this).attr("value"));
        }
        if (cost > maximum) {
          cost -= parseInt($(this).attr("value"));
          return $(this).attr("value", "Zu hohe Kosten");
        }
      });
      return add_line_to_costs("good_quality", "Gaben", cost);
    });
    $(".quality_earn").change(function() {
      var earn;
      earn = 0;
      $(".quality_earn").each(function() {
        if (!($(this).attr("value") === "" || $(this).attr("value") === "Zu viel Gewinn")) {
          earn += parseInt($(this).attr("value"));
        }
        if (earn > 25) {
          earn -= parseInt($(this).attr("value"));
          return $(this).attr("value", "Zu viel Gewinn");
        }
      });
      return add_line_to_costs("bad_quality", "Handicap", -earn);
    });
    $(".connections").change(function() {
      var cost;
      cost = 0;
      $(".connections").each(function() {
        var value;
        if ($(this).attr("value") !== "") {
          value = parseInt($(this).attr("value"));
          if ((1 < value && value <= 6)) {
            return cost += value;
          } else {
            $(this).attr("value", 1);
            return cost += 1;
          }
        }
      });
      return add_line_to_costs("my_connections", "Connections", cost);
    });
    $("#special_profession").change(function() {
      add_line_to_costs("my_special_profession", "Spezielle Profession", $("#special_profession :selected").attr("cost"));
      $(".quality_cost").change();
      if ($("#special_profession :selected").attr("value") === "none") {
        $("input[name=magic]").attr("value", 1);
        $("#special_attributes input").change();
        return $("label[for=magic], input[name=magic]").fadeOut();
      } else {
        if ($("#special_profession :selected").attr("value") === "technomancer") {
          $("label[for=magic]").text("Resonanz");
        } else {
          $("label[for=magic]").text("Magie");
        }
        return $("label[for=magic], input[name=magic]").fadeIn();
      }
    });
    $("#skill_groups input").change(function() {
      var cost;
      cost = 0;
      return $("#skill_groups table").each(function() {
        var group_value, my_table;
        my_table = this;
        group_value = parseInt($("thead input", my_table).attr("value"));
        if (group_value < 0) {
          group_value = 0;
          $("thead input", my_table).attr("value", 0);
        } else if (group_value > 4) {
          group_value = 4;
          $("thead input", my_table).attr("value", 4);
        }
        cost += group_value * 10;
        $("tbody tr", my_table).each(function() {
          var absolute_value, relative_value;
          relative_value = parseInt($(".relative", this).attr("value"));
          absolute_value = group_value + relative_value;
          if (absolute_value < 0) {
            relative_value = 0;
            absolute_value = 0;
          } else if (absolute_value > 6) {
            relative_value = 6 - group_value;
            absolute_value = group_value + relative_value;
          }
          $(".relative", this).attr("value", relative_value);
          $(".absolute", this).attr("value", absolute_value);
          if ($(".specialize_select", this).attr("checked")) {
            cost += 2;
            $(".specialize", this).fadeIn();
          } else {
            $(".specialize", this).fadeOut();
          }
          return cost += relative_value * 4;
        });
        return add_line_to_costs("skill_groups", "Fertigkeitengruppen", cost);
      });
    });
    $("#single_skills").delegate("input", "change", function() {
      table_change("single_skills", "Einzelne Fertigkeiten", 2, true);
      return table_change("single_skills", "Einzelne Fertigkeiten (Spez.)", 2, true, "specialize");
    });
    $("#spells").delegate("input", "change", function() {
      return table_change("spells", "Zauber", 2);
    });
    $("#knowledge").delegate("input", "change", function() {
      table_change("knowledge", "Wissen", 2, true, "knowledgepoints");
      return table_change("knowledge", "Wissen (Spez.)", 2, true, "specialize");
    });
    $("#normal_items").delegate("input", "change", function() {
      return table_change("normal_items", "Normale Gegenstaende", 3, false, "nuyen");
    });
    $("#bioware").delegate("input", "change", function() {
      table_change("bioware", "Bioware", 3, false, "nuyen");
      return table_change("bioware", "Bioware", 3, false, "essence");
    });
    $("#cyberware").delegate("input", "change", function() {
      table_change("cyberware", "Cyberware", 3, false, "nuyen");
      return table_change("cyberware", "Cyberware", 3, false, "essence");
    });
    $("input.additional_knowledge").change(function() {
      var cost;
      cost = parseInt($("input.additional_knowledge").attr("value")) * 2;
      return add_line_to_costs("additional_knowledge", "Zus. Wissenspunkte", cost);
    });
    return $('#metatype, \
    .quality_cost, \
    .quality_earn, \
    .connections, \
    #special_profession, \
    #skill_groups input:first, \
    #single_skill input:first, \
    #single_skill input[type=checkbox]:first, \
    #spells input:first,\
    #knowledge input:first,\
    #knowledge input[type=checkbox]:first,\
    #normal_items input:first,\
    #bioware input:first,\
    #cyberware input:first').change();
  });
}).call(this);
