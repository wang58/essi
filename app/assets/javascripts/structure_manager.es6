import {StructureParser} from "structure_parser"
import shift_enabled_selecting from "shift_selecting"
export default class StructureManager {
  constructor() {
    this.initialize_sortable()
    this.initialize_selectable()
    this.bind_persist()
    this.add_section_button()
    this.toggle_thumbnails_button()
  }

  initialize_sortable() {
    $(".sortable").nestedSortable({
      handle: ".move",
      items: "li",
      toleranceElement: "> div",
      listType: "ul",
      placeholder: "placeholder",
      parentNodeFactory: this.new_node,
      preventExpansion: true,
      helper: function(e, item) {
        if ( ! item.hasClass("ui-selected") ) {
          item.parent().children(".ui-selected").removeClass("ui-selected")
          item.addClass("ui-selected")
        }

        var selected = item.parent().children(".ui-selected").clone()
        item.data("multidrag", selected).siblings(".ui-selected").remove()
        return $("<li/>").append(selected)
      },
      stop: function(e, ui) {
        var selected = ui.item.data("multidrag")
        ui.item.after(selected)
        ui.item.remove()
        $(".ui-selected").removeClass("ui-selected")
      },
      start: function(event, ui) {
        ui.placeholder.height(ui.item.height())
      },
      isTree: true,
      collapsedClass: "collapsed",
      expandedClass: "expanded"
    })
    $(".sortable").on("click", ".expand-collapse", function() {
      let parent = $(this).parents("li").first()
      parent.toggleClass("expanded")
      parent.toggleClass("collapsed")
    })
  }

  initialize_selectable() {
    $(".sortable").selectable({
      cancel: ".move,input,a,.expand-collapse,.ignore-select",
      filter: "li",
      selecting: shift_enabled_selecting()
    })
    $(".sortable").on("click", "*[data-action=remove-list]", function(event) {
      event.preventDefault()
      if(confirm("Delete this structure?")) {
        let parent_li = $(this).parents("li").first()
        let child_items = parent_li.children("ul").children()
        parent_li.before(child_items)
        parent_li.remove()
      }
    })
  }

  bind_persist() {
    $("*[data-action=submit-list]").click(function(event) {
      event.preventDefault()
      let element = $(".sortable")
      let serializer = new StructureParser(element)
      let root_prefix = $(event.currentTarget).attr("data-prefix")
      let url = `${root_prefix}/concern/${element.attr("data-class-name")}/${element.attr("data-id")}/structure`
      let button = $(this)
      button.text(I18n.t('essi.structure.saving'))
      button.addClass("disabled")
      $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(serializer.serialize),
        dataType: "text",
        contentType: "application/json"
      }).done(function(data, textStatus) {
        window.essi.flash.set("success", "Request complete: " + textStatus)
      }).fail(function(jqXHR, textStatus, errorThrown) {
        window.essi.flash.set("danger", "Request failed: " + errorThrown)
      }).always(() => {
        button.text(I18n.t('essi.structure.save'))
        button.removeClass("disabled")
      })
    })
  }

  add_section_button() {
    let new_node = this.new_node
    $("*[data-action=add-to-list]").click(function(event) {
      event.preventDefault()
      let top_element = $(".sortable")
      let new_element = new_node()
      top_element.prepend(new_element)
    })
  }

  toggle_thumbnails_button(){
    let show_html = "<span class='glyphicon glyphicon-eye-open'></span> " + I18n.t('essi.structure.show_thumbnails')
    let hide_html = "<span class='glyphicon glyphicon-eye-close'></span> " + I18n.t('essi.structure.hide_thumbnails')
    $("*[data-action=toggle-thumbnails]").click(function(event) {
      event.preventDefault()
      if($(".structure-thumbnail").is(':visible')){
        $(".structure-thumbnail").hide()
        $("#structure-thumbnail-button").html(show_html)
      }else{
        $(".structure-thumbnail").show()
        $("#structure-thumbnail-button").html(hide_html)
      }
    })
  }

  new_node() {
    return $("<li>", { class: "expanded" }).append(
      $("<div>").append(
        $("<div>", { class: "panel panel-default" }).append(
          $("<div>", { class: "panel-heading" }).append(
            $("<div>", { class: "row" }).append(
              $("<div>", { class: "title" }).append(
                $("<span>", { class: "move glyphicon glyphicon-move" })).append(
                $("<span>", { class: "glyphicon expand-collapse" })).append(
                $("<input>", { type: "text", name: "label", id: "label" }))).append(
              $("<div>", { class: "toolbar" }).append(
                $("<a>", { href: "", "data-action": "remove-list", title: "Remove "}).append(
                  $("<span>", { class: "glyphicon glyphicon-remove" })
                )
              )
            )
          )
        )
      )
    )
  }
}
