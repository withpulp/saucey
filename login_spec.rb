# filename: dragDrop.rb

require 'selenium-webdriver'

def get(url)
  navigate.to(http://adcade.com/demo/yahoo/testtags/160x600_expandable/index.html)
end

def move_to(right_by = nil, down_by = nil)
  if right_by && down_by
    @actions << [:mouse, :move_to, [element, 75, 302]]
  else
    @actions << [:mouse, :move_to, [element]]
  self

def click_and_hold(element)
  @actions << [:mouse, :down, [element]]
  self

def move_to(right_by = nil, down_by = nil)
  if right_by && down_by
    @actions << [:mouse, :move_to, [element, 75, 302]]
  else
    @actions << [:mouse, :move_to, [element]]
    self

def drag_and_drop_by(source, right_by, down_by)
  click_and_hold source
  move_by        right_by, down_by
  release

  self

end
