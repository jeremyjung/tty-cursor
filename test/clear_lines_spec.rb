# encoding: utf-8

cursor = TTY::Cursor

assert "clears character" do
  assert_equal "\e[X", cursor.clear_char
end

assert "clears few characters" do
  assert_equal "\e[5X", cursor.clear_char(5)
end

assert "clears line" do
  assert_equal "\e[2K\e[1G", cursor.clear_line
end

assert "clears the line before the cursor" do
  assert_equal "\e[0K", cursor.clear_line_before
end

assert "clears the line after the cursor" do
  assert_equal "\e[1K", cursor.clear_line_after
end

assert "clears 5 lines up" do
  assert_equal [
    "\e[2K\e[1G\e[1A",
    "\e[2K\e[1G\e[1A",
    "\e[2K\e[1G\e[1A",
    "\e[2K\e[1G\e[1A",
    "\e[2K\e[1G"
  ].join, cursor.clear_lines(5) 
end

assert "clears 5 lines down" do
  assert_equal [
    "\e[2K\e[1G\e[1B",
    "\e[2K\e[1G\e[1B",
    "\e[2K\e[1G\e[1B",
    "\e[2K\e[1G\e[1B",
    "\e[2K\e[1G"
  ].join, cursor.clear_lines(5, :down) 
end

assert "clears screen down" do
  assert_equal "\e[J", cursor.clear_screen_down
end

assert "clears screen up" do
  assert_equal "\e[1J", cursor.clear_screen_up
end

assert "clears entire screen" do
  assert_equal "\e[2J", cursor.clear_screen 
end