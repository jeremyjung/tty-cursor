# encoding: utf-8

cursor = TTY::Cursor

assert "moves to home" do
  assert_equal "\e[H", cursor.move_to
end

assert "moves to row and column" do
  assert_equal "\e[4;3H", cursor.move_to(2, 3)
end
