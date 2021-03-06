# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#products').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    $AjaxSource: $('#products').data('source')

    $("#products tbody").on "click", "tr", (event) ->
      window.location.href = "contexts/" + $(this).attr("id")

    $("#addIcon").on "click" , (event) ->
      window.location.href = "contexts/new"
